import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_code/picker.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final branchName = TextEditingController();
  final branchId = TextEditingController();
  final branchPassword = TextEditingController();
  final branchPasswordConfirm = TextEditingController();
  final locationController = TextEditingController();

  //Person data
  final personName = TextEditingController();
  final personId = TextEditingController();
  final personPassword = TextEditingController();
  final personPasswordConfirm = TextEditingController();

  late DatabaseReference branchReference;
  late DatabaseReference managerReference;

  @override
  void initState() {
    super.initState();
    branchReference = FirebaseDatabase.instance.ref().child("branches");
    managerReference = FirebaseDatabase.instance.ref().child("managers");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 50),
                Text(
                  "Registration",
                  style: TextStyle(
                    fontSize: 50,
                    fontFamily: 'lobstertwo',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                SizedBox(height: 40),
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
                              Picker(controller: locationController),
                            ],
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

                //-----------------second container-------------------
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
                        'Manager details',
                        style: TextStyle(
                          fontFamily: 'sfpro',

                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                      children: [
                        CupertinoFormRow(
                          prefix: Text(
                            'Manager Id',
                            style: TextStyle(
                              fontFamily: 'sfpro',
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          child: CupertinoTextFormFieldRow(
                            cursorColor: Colors.black,
                            controller: personId,
                            placeholder: 'Enter branch id',
                            onSaved: (value) {
                              print(value);
                            },
                          ),
                        ),
                        CupertinoFormRow(
                          prefix: Text(
                            'Manager Name',
                            style: TextStyle(
                              fontFamily: 'sfpro',
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          child: CupertinoTextFormFieldRow(
                            cursorColor: Colors.black,
                            controller: personName,
                            placeholder: 'Enter branch id',
                            onSaved: (value) {
                              print(value);
                            },
                          ),
                        ),

                        CupertinoFormRow(
                          prefix: Text(
                            'Manager Password',
                            style: TextStyle(
                              fontFamily: 'sfpro',
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          child: CupertinoTextFormFieldRow(
                            cursorColor: Colors.black,
                            controller: personPassword,
                            placeholder: 'Enter manager password',
                            onSaved: (value) {
                              print(value);
                            },
                          ),
                        ),
                        CupertinoFormRow(
                          prefix: Text(
                            'Manager Password',
                            style: TextStyle(
                              fontFamily: 'sfpro',
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          child: CupertinoTextFormFieldRow(
                            cursorColor: Colors.black,
                            controller: personPasswordConfirm,
                            placeholder: 'Re Enter manager password',
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
                      Map<String, String> branchData = {
                        "branchId": branchId.text,
                        "branchPassword": branchPassword.text,
                        "branchLocation": locationController.text,
                      };
                      branchReference
                          .push()
                          .set(branchData)
                          .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Registration Successful ' +
                                      locationController.text,
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
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'sfpro',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CupertinoButton(
                  child: Text(
                    'register p[erson]',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontFamily: 'sfpro',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    if (personId.text.isEmpty ||
                        personName.text.isEmpty ||
                        personPassword.text.isEmpty ||
                        personPasswordConfirm.text.isEmpty ||
                        personPassword.text != personPasswordConfirm.text) {
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
                      Map<String, String> managerData = {
                        "managerId": personId.text,
                        "managerName": personName.text,
                        "managerPassword": personPassword.text,
                      };
                      managerReference
                          .push()
                          .set(managerData)
                          .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Registration Successful ' + personName.text,
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
                                  "Failed to save manager data: $error",
                                  style: TextStyle(color: Colors.white),
                                ),
                                duration: Duration(seconds: 5),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
