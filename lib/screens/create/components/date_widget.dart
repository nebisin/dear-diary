import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatefulWidget {
  final setDate;

  DateWidget(this.setDate);

  @override
  _DateWidgetState createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  var _selectedDate = DateTime.now();

  void _selectDate() {
    showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
      widget.setDate(_selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        child: Text(
          DateFormat.MMMMEEEEd().format(_selectedDate),
          style: Theme.of(context).textTheme.headline4,
        ),
        onPressed: _selectDate,
      ),
    );
  }
}
