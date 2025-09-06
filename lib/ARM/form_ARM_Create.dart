import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/ARM_SelectProvider.dart';
import 'package:test_code/dateTime.dart';
import 'package:test_code/send_button.dart';

class form_ARM_Create extends StatefulWidget {
  final String location;
  final String position;
  const form_ARM_Create({
    super.key,
    required this.location,
    required this.position,
  });

  @override
  State<form_ARM_Create> createState() => _form_ARM_CreateState();
}

class _form_ARM_CreateState extends State<form_ARM_Create> {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 50),
                          Text(
                            "From : RM Branch in $location",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'DMSerif',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(92, 112, 202, 1),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          SizedBox(width: 50),
                          Text(
                            "To : ARM Branch in ${Provider.of<ARM_Selection_provider>(context).selected.toString() ?? "Select Branch"}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'DMSerif',
                              fontSize: 18,

                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(92, 112, 202, 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SendButton_animated(
                  SerialNumberController,
                  PlaceOfCoupeController,
                  LetterNoController,
                  DateinforemedController,
                  position,
                  location,
                ),
                SizedBox(width: 10),
              ],
            ),

            SizedBox(height: 30),
            Form(
              child: CupertinoFormSection.insetGrouped(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(104, 127, 229, 0.12),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Color.fromRGBO(104, 127, 229, 0.591),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(
                        255,
                        204,
                        217,
                        233,
                      ).withOpacity(0.6),
                      blurRadius: 100,
                      spreadRadius: 0.1,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                children: <Widget>[
                  CupertinoTextFormFieldRow(
                    prefix: Text(
                      "දැව භාරදුන් ආයතනය හා කොට්ඨාසය   :   ",
                      style: TextStyle(
                        color: Color.fromRGBO(71, 61, 129, 1),
                        fontFamily: 'RoboSerif',
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    placeholder: 'Enter Serial Number',
                    controller: SerialNumberController,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'RoboSerif',
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Text(
                      'දැව භාරදුන් ආයතනයේ ලිපි අංකය හා දිනය  :   ',
                      style: TextStyle(
                        color: Color.fromRGBO(71, 61, 129, 1),
                        fontFamily: 'AbhayaLibre',

                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                    controller: PlaceOfCoupeController,
                    placeholder: 'Enter Place of Coupe',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'RoboSerif',
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                    cursorColor: Colors.black,
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Text(
                      'දැව ඇති ස්ථානය :   ',
                      style: TextStyle(
                        color: Color.fromRGBO(71, 61, 129, 1),
                        fontFamily: 'RoboSerif',
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    placeholder: 'Enter Letter No',
                    controller: LetterNoController,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'RoboSerif',
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Text(
                      'දැව පවතින ස්වභාවය :   ',
                      style: TextStyle(
                        color: Color.fromRGBO(71, 61, 129, 1),
                        fontFamily: 'RoboSerif',
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    placeholder: 'Enter Letter No',
                    controller: LetterNoController,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'RoboSerif',
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Text(
                      'දැව පරික්ෂා කල නිලධාරියාගේ නම :',
                      style: TextStyle(
                        color: Color.fromRGBO(71, 61, 129, 1),
                        fontFamily: 'RoboSerif',
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    placeholder: 'Enter Letter No',
                    controller: LetterNoController,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'RoboSerif',
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Text(
                      'දැව පරික්ෂා කල නිලධාරියාගේ තනතුර :   ',
                      style: TextStyle(
                        color: Color.fromRGBO(71, 61, 129, 1),
                        fontFamily: 'RoboSerif',
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    placeholder: 'Enter Letter No',
                    controller: LetterNoController,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'RoboSerif',
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Row(
                      children: [
                        Text(
                          'පරික්ෂා කල දිනය:',
                          style: TextStyle(
                            color: Color.fromRGBO(71, 61, 129, 1),
                            fontWeight: FontWeight.w900,
                            fontFamily: 'RoboSerif',
                            fontSize: 20,
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
                      ],
                    ),
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Text(
                      'ගස් ගණන  :',
                      style: TextStyle(
                        color: Color.fromRGBO(71, 61, 129, 1),
                        fontWeight: FontWeight.w900,
                        fontFamily: 'RoboSerif',
                        fontSize: 20,
                      ),
                    ),
                    placeholder: 'Enter Letter No',
                    controller: LetterNoController,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'RoboSerif',
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
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
