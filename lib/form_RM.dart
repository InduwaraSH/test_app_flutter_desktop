import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/ARM_SelectProvider.dart';
import 'package:test_code/dateTime.dart';
import 'package:test_code/send_button.dart';

class form_RM extends StatefulWidget {
  final String location;
  final String position;
  const form_RM({super.key, required this.location, required this.position});

  @override
  State<form_RM> createState() => _form_RMState();
}

class _form_RMState extends State<form_RM> {
  final SerialNumberController = TextEditingController();
  final PlaceOfCoupeController = TextEditingController();
  final LetterNoController = TextEditingController();
  final DateinforemedController = TextEditingController();

  String? savedValue;

  // default
  late String location;
  late String position;

  @override
  void initState() {
    super.initState();
    location = widget.location;
    position = widget.position;

    final provider = Provider.of<ARM_Selection_provider>(
      context,
      listen: false,
    );
    savedValue = provider.selected;

    // listen for changes
    provider.addListener(() {
      setState(() {
        savedValue = provider.selected;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SendButton_animated(
                  SerialNumberController,
                  PlaceOfCoupeController,
                  LetterNoController,
                  DateinforemedController,
                  position,
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                "Enumeration And Wayside Deport Register For Donated Timber $savedValue .",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'DMSerif',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 50),
                Text(
                  "From : RM Branch in $location",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'DMSerif',
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 59, 59, 59),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 50),
                Text(
                  "To : ARM Branch in ${Provider.of<ARM_Selection_provider>(context).selected.toString() ?? "Select Branch"}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'DMSerif',
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 59, 59, 59),
                  ),
                ),
              ],
            ),
            SizedBox(height: 70),
            Form(
              child: CupertinoFormSection.insetGrouped(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(170, 255, 255, 255),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.6),
                      blurRadius: 100,
                      spreadRadius: 0.1,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                children: <Widget>[
                  CupertinoTextFormFieldRow(
                    prefix: Text(
                      "Serial Number.  : ",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'sfpro',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    placeholder: 'Enter text',
                    controller: SerialNumberController,
                    cursorColor: Colors.black,
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Text(
                      'Place of Coupe :',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'sfpro',
                      ),
                    ),
                    controller: PlaceOfCoupeController,
                    placeholder: 'Enter text',
                    cursorColor: Colors.black,
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Text(
                      'Letter No           : ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'sfpro',
                      ),
                    ),
                    placeholder: 'Enter text',
                    controller: LetterNoController,
                    cursorColor: Colors.black,
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Row(
                      children: [
                        Text(
                          'Date informed   : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'sfpro',
                          ),
                        ),
                        SimpleDatePicker(
                          initialDate: DateTime.now(),
                          onDateChanged: (date) {
                            print("Selected Date: $date");
                            setState(() {
                              DateinforemedController.text = date.toString();
                            });
                          },
                        ),
                        CupertinoButton(
                          child: Text("Select Date"),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
