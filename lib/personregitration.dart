import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:test_code/picker.dart';

class PersonRegistrationPage extends StatefulWidget {
  const PersonRegistrationPage({super.key});

  @override
  State<PersonRegistrationPage> createState() => _PersonRegistrationPageState();
}

class _PersonRegistrationPageState extends State<PersonRegistrationPage> {
  //Person data
  final personName = TextEditingController();
  final personId = TextEditingController();
  final personPassword = TextEditingController();
  final personPasswordConfirm = TextEditingController();
  final mobileNumber = TextEditingController();
  final employeePositionController = TextEditingController();
  final locationController = TextEditingController();

  late DatabaseReference branchReference;
  late DatabaseReference employeeReference;

  final List<String> jobRoles = ['RM', 'ARM', 'EMP'];

  final List<String> myTowns = [
    'Maharagama',
    'Embilipitiya',
    'Matara',
    'Galle',
    'Colombo',
    'Trinco',
    'Walasmulla',
    'Negombo',
    'Rathnapura',
    'Kegalle',
    'Anuradhapura',
    'Polonnaruwa',
  ];

  @override
  void initState() {
    super.initState();

    employeeReference = FirebaseDatabase.instance.ref().child("employees");
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
                Text(
                  "User Registration",
                  style: TextStyle(
                    fontSize: 50,
                    fontFamily: 'lobstertwo',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: SizedBox(
                    width: 500,
                    height: 400,
                    child: Lottie.asset(
                      'assets/profile.json',
                      fit: BoxFit.fill,
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
                        'Employee details',
                        style: TextStyle(
                          fontFamily: 'sfpro',

                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                      children: [
                        CupertinoFormRow(
                          prefix: Text(
                            'Employee Id',
                            style: TextStyle(
                              fontFamily: 'sfpro',
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          child: CupertinoTextFormFieldRow(
                            cursorColor: Colors.black,
                            controller: personId,
                            placeholder: 'Enter Employee Id',
                            onSaved: (value) {
                              print(value);
                            },
                          ),
                        ),
                        CupertinoFormRow(
                          prefix: Text(
                            'Employee Name',
                            style: TextStyle(
                              fontFamily: 'sfpro',
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          child: CupertinoTextFormFieldRow(
                            cursorColor: Colors.black,
                            controller: personName,
                            placeholder: 'Enter Employee Name',
                            onSaved: (value) {
                              print(value);
                            },
                          ),
                        ),

                        CupertinoFormRow(
                          prefix: Text(
                            'Personal Mobile Number',
                            style: TextStyle(
                              fontFamily: 'sfpro',
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          child: CupertinoTextFormFieldRow(
                            cursorColor: Colors.black,
                            controller: mobileNumber,
                            placeholder: 'Enter Personal Mobile Number',
                            onSaved: (value) {
                              print(value);
                            },
                          ),
                        ),

                        CupertinoFormRow(
                          prefix: Text(
                            'Office or Job type',
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
                                controller: employeePositionController,
                                townNames: jobRoles,
                              ),
                            ],
                          ),
                        ),

                        CupertinoFormRow(
                          prefix: Text(
                            'Office Location',
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

                        CupertinoFormRow(
                          prefix: Text(
                            'Password',
                            style: TextStyle(
                              fontFamily: 'sfpro',
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          child: CupertinoTextFormFieldRow(
                            cursorColor: Colors.black,
                            controller: personPassword,
                            placeholder: 'Enter  password',
                            onSaved: (value) {
                              print(value);
                            },
                          ),
                        ),
                        CupertinoFormRow(
                          prefix: Text(
                            'Password',
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
                  color: Colors.black,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'sfpro',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    bool result = await InternetConnection().hasInternetAccess;

                    if (result == false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'No internet connection',
                            style: TextStyle(color: Colors.white),
                          ),
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.grey,
                        ),
                      );
                      return;
                    } else {
                      if (personId.text.isEmpty ||
                          personName.text.isEmpty ||
                          mobileNumber.text.isEmpty ||
                          mobileNumber.text.length != 10 ||
                          employeePositionController.text.isEmpty ||
                          locationController.text.isEmpty ||
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
                        Map<String, String> employeeData = {
                          "employeeId": personId.text,
                          "employeeName": personName.text,
                          "employeeMobile": mobileNumber.text,
                          "employeePosition": employeePositionController.text,
                          "employeeLocation": locationController.text,
                          "employeePassword": personPassword.text,
                        };
                        employeeReference
                            .child(personId.text)
                            .set(employeeData)
                            .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${personName.text} Registration Request Sent Successfully',
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
                    }
                  },
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
