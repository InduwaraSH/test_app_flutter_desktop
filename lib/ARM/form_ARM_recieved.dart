import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/ARM/form_ARM_Create.dart';
import 'package:test_code/ARM_SelectProvider.dart';
import 'package:test_code/RM_sent_provide.dart';
import 'package:test_code/dateTime.dart';
import 'package:test_code/send_button.dart';

class form_ARM_Recived extends StatefulWidget {
  final String location;
  final String position;
  const form_ARM_Recived({
    super.key,
    required this.location,
    required this.position,
  });

  @override
  State<form_ARM_Recived> createState() => _form_ARM_RecivedState();
}

class _form_ARM_RecivedState extends State<form_ARM_Recived> {
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
      child: Visibility(
        visible: Provider.of<RM_Sent>(context).selected ?? true,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     SendButton_animated(
              //       SerialNumberController,
              //       PlaceOfCoupeController,
              //       LetterNoController,
              //       DateinforemedController,
              //       position,
              //     ),
              //     SizedBox(width: 10),
              //   ],
              // ),
              SizedBox(height: 30),
              Center(
                child: Text(
                  "Enumeration And Wayside \n Deport Register For Donated Timber.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'DMSerif',
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(145, 142, 214, 1),
                  ),
                ),
              ),
              SizedBox(height: 70),
              Row(
                children: [
                  SizedBox(width: 50),
                  Text(
                    "From :   RM Branch in $location",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'DMSerif',
                      fontSize: 18,

                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(117, 106, 182, 1),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(width: 50),
                  Text(
                    "To      :   ARM Branch in $location",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'DMSerif',
                      fontSize: 18,

                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(117, 106, 182, 1),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Form(
                child: CupertinoFormSection.insetGrouped(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(76, 201, 203, 255),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Color.fromRGBO(177, 175, 255, 0.62),
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
                        "Serial No              :   ${Provider.of<RM_Sent>(context).s_num.toString()}",
                        style: TextStyle(
                          color: Color.fromRGBO(71, 61, 129, 1),
                          fontFamily: 'RoboSerif',
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                      // show text only
                      enabled: false,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(0, 255, 255, 255),
                      ), // remove background
                      placeholder: null, // remove placeholder
                      style: TextStyle(
                        color: Color.fromRGBO(117, 106, 182, 1),
                        fontFamily: 'sfpro',
                      ),
                    ),
                    CupertinoTextFormFieldRow(
                      prefix: Text(
                        'Place of Coupe  :   ${Provider.of<RM_Sent>(context).poc.toString()}',
                        style: TextStyle(
                          color: Color.fromRGBO(71, 61, 129, 1),
                          fontFamily: 'RoboSerif',
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                      //controller: PlaceOfCoupeController,
                      placeholder: null,
                      enabled: false,
                      cursorColor: Colors.black,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(0, 255, 255, 255),
                      ),
                    ),
                    CupertinoTextFormFieldRow(
                      prefix: Text(
                        'Letter No              :   ${Provider.of<RM_Sent>(context).letter_no.toString()}',
                        style: TextStyle(
                          color: Color.fromRGBO(71, 61, 129, 1),
                          fontFamily: 'RoboSerif',
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                      placeholder: null,
                      enabled: false,

                      decoration: BoxDecoration(
                        color: Color.fromARGB(0, 255, 255, 255),
                      ),
                    ),
                    CupertinoTextFormFieldRow(
                      prefix: Row(
                        children: [
                          Text(
                            'Date informed    :   ${Provider.of<RM_Sent>(context).date_informed.toString()}',
                            style: TextStyle(
                              color: Color.fromRGBO(71, 61, 129, 1),
                              fontFamily: 'RoboSerif',
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Divider(
                thickness: 2,
                indent: 200,
                endIndent: 200,
                color: Color.fromRGBO(104, 127, 229, 0.591),
              ),
              form_ARM_Create(location: location, position: position),
            ],
          ),
        ),
      ),
    );
  }
}
