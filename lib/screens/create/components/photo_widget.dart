import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class PhotoWidget extends StatefulWidget {
  final Function onSelectImage;
  final File? pickedImage;

  PhotoWidget(this.onSelectImage, this.pickedImage);

  @override
  _PhotoWidgetState createState() => _PhotoWidgetState();
}

class _PhotoWidgetState extends State<PhotoWidget> {
  File? _storedImage;
  final picker = ImagePicker();

  @override
  void initState() {
    if (widget.pickedImage != null) {
      setState(() {
        _storedImage = widget.pickedImage;
      });
    }
    super.initState();
  }

  Future storeImage(imageFile) async {
    if (imageFile == null) {
      return;
    }

    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);

    final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');

    widget.onSelectImage(savedImage);
  }

  Future getImageFromCamera() async {
    try {
      final imageFile = await picker.getImage(
        source: ImageSource.camera,
        maxWidth: 600,
      );

      storeImage(imageFile);
    } catch (e) {
      print(e);
    }
  }

  Future getImageFromGallery() async {
    try {
      final imageFile = await picker.getImage(
        source: ImageSource.gallery,
        maxWidth: 600,
      );

      storeImage(imageFile);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.width / 3 * 2,
      color: Color.fromRGBO(207, 213, 225, 1),
      alignment: Alignment.center,
      child: _storedImage != null
          ? Image.file(
              _storedImage!,
              fit: BoxFit.cover,
              width: double.infinity,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Add a cover photo for your day (optinal)',
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton.icon(
                  onPressed: getImageFromCamera,
                  label: Text('From Camera'),
                  icon: Icon(Icons.camera),
                ),
                TextButton.icon(
                  onPressed: getImageFromGallery,
                  icon: Icon(Icons.photo_camera_back),
                  label: Text('From Gallery'),
                )
              ],
            ),
    );
  }
}
