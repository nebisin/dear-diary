import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  final form;
  final titleController;
  final bodyController;
  final savePaper;
  final loading;

  FormWidget(this.form, this.titleController, this.bodyController,
      this.savePaper, this.loading);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _bodyFocusNode = FocusNode();

  @override
  void dispose() {
    _bodyFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: widget.form,
        child: Column(
          children: [
            SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter a title for your day',
                labelText: 'Title',
                border: OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(207, 213, 225, 1),
                    width: 0.0,
                  ),
                ),
                fillColor: Color.fromRGBO(207, 213, 225, 1),
                filled: true,
              ),
              controller: widget.titleController,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_bodyFocusNode);
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a title!';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                alignLabelWithHint: true,
                hintText: 'Tell us your day.',
                labelText: 'What do you think? (optinal)',
                border: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(207, 213, 225, 1),
                    width: 0.0,
                  ),
                ),
                fillColor: Color.fromRGBO(207, 213, 225, 1),
                filled: true,
              ),
              controller: widget.bodyController,
              focusNode: _bodyFocusNode,
              maxLines: 3,
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.bottomRight,
              child: widget.loading
                  ? CircularProgressIndicator()
                  : RaisedButton(
                      onPressed: widget.savePaper,
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
