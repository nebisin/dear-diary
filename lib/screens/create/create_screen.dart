import 'dart:io';

import 'package:dear_dairy/models/paper.dart';
import 'package:dear_dairy/provider/papers.dart';
import 'package:dear_dairy/screens/create/components/mood_widget.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/date_widget.dart';
import 'components/form_widget.dart';
import 'components/photo_widget.dart';

class CreateScreen extends StatefulWidget {
  final Paper editedItem;

  CreateScreen([this.editedItem]);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: 'ca-app-pub-1639338975133942/6880648672',
      size: AdSize.smartBanner,
      targetingInfo: MobileAdTargetingInfo(),
    );
  }

  var _loading = false;
  final _form = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  var _date = DateTime.now();
  var _mood = 'good';
  File _pickedImage;

  @override
  void initState() {
    if (widget.editedItem != null) {
      _titleController.text = widget.editedItem.title;
      _bodyController.text = widget.editedItem.body;
      _date = widget.editedItem.date;
      _mood = widget.editedItem.mood;
      _pickedImage = widget.editedItem.coverImage;
    }
    _bannerAd = createBannerAd();
    _bannerAd..load()..show();
    super.initState();
  }

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _bannerAd?.dispose();
    super.dispose();
  }

  void _setMood(String mood) {
    setState(() {
      _mood = mood;
    });
  }

  void _setDate(DateTime date) {
    setState(() {
      _date = date;
    });
  }

  void _savePaper() async {
    if (_loading == true) {
      return;
    }

    final isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }

    setState(() {
      _loading = true;
    });

    Paper newPaper;

    if (widget.editedItem == null) {
      newPaper = await Provider.of<Papers>(context, listen: false).addPaper(
        title: _titleController.text,
        body: _bodyController.text,
        mood: _mood,
        date: _date,
        coverImage: _pickedImage,
      );
    } else {
      newPaper = await Provider.of<Papers>(context, listen: false).updatePaper(
        id: widget.editedItem.id,
        title: _titleController.text,
        body: _bodyController.text,
        mood: _mood,
        date: _date,
        coverImage: _pickedImage,
        isFavorite: widget.editedItem.isFavorite,
      );
    }
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/detail-screen',
      (route) => route.settings.name == '/',
      arguments: newPaper.id,
    );

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editedItem == null ? 'New Sheet' : 'Edit Sheet'),
        actions: [
          _loading == false
              ? IconButton(
                  icon: Icon(Icons.save),
                  onPressed: _savePaper,
                )
              : Center(),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              DateWidget(_setDate),
              SizedBox(height: 10),
              PhotoWidget(_selectImage, _pickedImage),
              SizedBox(height: 20),
              MoodWidget(_mood, _setMood),
              FormWidget(_form, _titleController, _bodyController, _savePaper,
                  _loading),
              SizedBox(height: 100,)
            ],
          ),
        ),
      ),
    );
  }
}
