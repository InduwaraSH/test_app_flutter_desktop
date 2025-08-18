import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_code/branchRegistration.dart';
import 'package:test_code/picker.dart';

class RmAndArmPicker extends StatefulWidget {
  const RmAndArmPicker({super.key});

  @override
  State<RmAndArmPicker> createState() => _RmAndArmPickerState();
}

class _RmAndArmPickerState extends State<RmAndArmPicker> {
  final employeePositionController = TextEditingController();

  final List<String> jobRoles = [
    'Choose One',
    'Regional Office (RO)',
    'Area Regional Office (ARO)',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, // Change the back button color
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              "Where Are You...?",
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'lobstertwo',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 90),
          // Center(
          //   child: Text(
          //     "Please select your office type: Regional Office (RO) or Area Regional Office (ARO). This selection will help us configure the system for your location.",
          //     style: TextStyle(
          //       fontSize: 15,
          //       fontFamily: 'sfpro',
          //       color: const Color.fromARGB(255, 50, 50, 50),
          //     ),
          //   ),
          // ),
          Container(
            width: 900,
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              onChanged: () {
                Form.maybeOf(primaryFocus!.context!)?.save();
              },
              child: CupertinoFormSection.insetGrouped(
                backgroundColor: Colors.white,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(26),
                ),
                header: Text(
                  "Please select your office type: Regional Office (RO) or Area Regional Office (ARO). This selection will help us configure the system for your location.",
                  style: TextStyle(fontFamily: 'sfpro', color: Colors.black),
                ),
                children: [
                  CupertinoFormRow(
                    prefix: Text(
                      'Office Type',
                      style: TextStyle(
                        fontFamily: 'sfpro',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 30),
                        Picker(
                          controller: employeePositionController,
                          townNames: jobRoles,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          CupertinoButton(
            onPressed: () {
              if (employeePositionController.text == 'Choose One' ||
                  employeePositionController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Please select a valid office type.',
                      style: TextStyle(
                        fontFamily: 'sfpro',
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BranchRegistration(
                      employeePosition: employeePositionController.text,
                    ),
                  ),
                );
              }
            },
            color: Colors.black,
            child: Text(
              "Next",
              style: TextStyle(fontFamily: 'sfpro', color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
