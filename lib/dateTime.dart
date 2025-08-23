import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimpleDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateChanged;

  const SimpleDatePicker({
    super.key,
    required this.initialDate,
    required this.onDateChanged,
  });

  @override
  State<SimpleDatePicker> createState() => _SimpleDatePickerState();
}

class _SimpleDatePickerState extends State<SimpleDatePicker> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onDateChanged(_selectedDate);
    });
  }

  void _showDatePickerDialog() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoDatePicker(
          initialDateTime: _selectedDate,
          mode: CupertinoDatePickerMode.date,
          showDayOfWeek: true,
          use24hFormat: true,
          onDateTimeChanged: (DateTime newDate) {
            setState(() => _selectedDate = newDate);
            widget.onDateChanged(newDate);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: _showDatePickerDialog,
      child: Text(
        '${_selectedDate.year} / ${_selectedDate.month} / ${_selectedDate.day}',
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontFamily: 'sfpro',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
