import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test_code/picker.dart';

class BranchRegistration extends StatefulWidget {
  final String branchType;

  const BranchRegistration({super.key, required this.branchType});

  @override
  State<BranchRegistration> createState() => _BranchRegistrationState();
}

class _BranchRegistrationState extends State<BranchRegistration> {
  final branchName = TextEditingController();
  final branchId = TextEditingController();
  final branchPassword = TextEditingController();
  final branchPasswordConfirm = TextEditingController();
  final locationController = TextEditingController();
  final relevantROBranch = TextEditingController();

  late String branchType;
  late bool areaOfficeLocationVisibility;

  //Person data

  late DatabaseReference branchReference;

  final List<String> myTowns = [
    'Maharagama',
    'Embilipitiya',
    'Matara',
    'Galle',
    'Colombo',
    'Trinco',
    'Walasmulla',
    'Negombo',
  ];

  @override
  void initState() {
    super.initState();
    branchReference = FirebaseDatabase.instance.ref().child("RO_branches");
    branchType = widget.branchType;

    if (branchType == 'Regional Office (RO)') {
      areaOfficeLocationVisibility = false;
    } else if (branchType == 'Area Regional Office (ARO)') {
      areaOfficeLocationVisibility = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, // Change the back button color
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 1),
                Text(
                  "Branch Registration",
                  style: TextStyle(
                    fontSize: 50,
                    fontFamily: 'lobstertwo',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                SizedBox(height: 0),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Lottie.asset(
                      'assets/Company.json',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width - 100) * 0.82,

                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    onChanged: () {
                      Form.maybeOf(primaryFocus!.context!)?.save();
                    },
                    child: CupertinoFormSection.insetGrouped(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(26),
                      ),
                      header: Text(
                        'Branch details',
                        style: TextStyle(
                          fontFamily: 'sfpro',

                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                      children: [
                        CupertinoFormRow(
                          prefix: Text(
                            'Branch Id',
                            style: TextStyle(
                              fontFamily: 'sfpro',
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          child: CupertinoTextFormFieldRow(
                            controller: branchId,
                            cursorColor: Colors.black,
                            placeholder: 'Enter branch id',
                            onSaved: (value) {
                              print(value);
                            },
                          ),
                        ),
                        CupertinoFormRow(
                          prefix: Text(
                            'Branch Location',
                            style: TextStyle(
                              fontFamily: 'sfpro',

                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 30),
                              Picker(
                                controller: locationController,
                                townNames: myTowns,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: areaOfficeLocationVisibility,
                          child: CupertinoFormRow(
                            prefix: Text(
                              'RO Location',
                              style: TextStyle(
                                fontFamily: 'sfpro',

                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 30),
                                Picker(
                                  controller: relevantROBranch,
                                  townNames: myTowns,
                                ),
                              ],
                            ),
                          ),
                        ),
                        CupertinoFormRow(
                          prefix: Text(
                            'Branch Password',
                            style: TextStyle(
                              fontFamily: 'sfpro',
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          child: CupertinoTextFormFieldRow(
                            controller: branchPassword,
                            cursorColor: Colors.black,
                            placeholder: 'Enter branch password',
                            onSaved: (value) {
                              print(value);
                            },
                          ),
                        ),
                        CupertinoFormRow(
                          prefix: Text(
                            'Branch Password',
                            style: TextStyle(
                              fontFamily: 'sfpro',
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          child: CupertinoTextFormFieldRow(
                            cursorColor: Colors.black,
                            controller: branchPasswordConfirm,
                            placeholder: 'Re Enter branch password',
                            onSaved: (value) {
                              print(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 50),
                CupertinoButton(
                  color: CupertinoColors.black,

                  onPressed: () {
                    if (branchId.text.isEmpty ||
                        branchPassword.text.isEmpty ||
                        locationController.text.isEmpty ||
                        branchPasswordConfirm.text.isEmpty ||
                        branchPassword.text != branchPasswordConfirm.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please fill all fields correctly',
                            style: TextStyle(color: Colors.white),
                          ),
                          duration: Duration(seconds: 5),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    } else {
                      if (branchType == 'Regional Office (RO)') {
                        branchReference = FirebaseDatabase.instance.ref().child(
                          "RM_branches",
                        );
                        Map<String, String> branchData = {
                          "branchId": branchId.text,
                          "branchPassword": branchPassword.text,
                          "branchLocation": locationController.text,
                        };
                        branchReference
                            .child(branchId.text)
                            .set(branchData)
                            .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Registration Successful ${locationController.text}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  duration: Duration(seconds: 5),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            })
                            .catchError((error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Failed to save branch data: $error",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  duration: Duration(seconds: 5),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            });
                      } else if (branchType == 'Area Regional Office (ARO)') {
                        branchReference = FirebaseDatabase.instance.ref().child(
                          "ARM_branches",
                        );
                        Map<String, String> branchData = {
                          "branchId": branchId.text,
                          "Relevent RO Branch": relevantROBranch.text,
                          "branchLocation": locationController.text,
                        };
                        branchReference
                            .child(branchId.text)
                            .set(branchData)
                            .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Registration Successful ${locationController.text}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  duration: Duration(seconds: 5),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            })
                            .catchError((error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Failed to save branch data: $error",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  duration: Duration(seconds: 5),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            });
                      }
                    }
                  },
                  child: Text(
                    "Register Branch",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'sfpro',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
