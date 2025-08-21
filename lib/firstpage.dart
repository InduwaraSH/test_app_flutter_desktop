import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test_code/branchRegistration.dart';
import 'package:test_code/login.dart';
import 'package:test_code/personregitration.dart';
import 'package:test_code/rm_AND_arm_picker.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  final login_ID = TextEditingController();
  final login_password = TextEditingController();

  bool isVisible_button = true;
  bool isVisible_loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal ,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 600,
                  height: 600,
                  padding: EdgeInsets.all(30),
                  margin: EdgeInsets.only(left: 30),
                  child: Lottie.asset('assets/lorry.json', fit: BoxFit.fill),
                ),
              ],
            ),
            SizedBox(width: 150),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                  width: 600,
                  height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontFamily: 'lobstertwo',
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Form(
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
                          // header: Text(
                          //   'Employee details',
                          //   style: TextStyle(
                          //     fontFamily: 'sfpro',

                          //     color: Colors.black,
                          //   ),
                          // ),
                          children: [
                            CupertinoFormRow(
                              prefix: Text(
                                'Employee Id',
                                style: TextStyle(
                                  fontFamily: 'sfpro',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              child: CupertinoTextFormFieldRow(
                                cursorColor: Colors.black,
                                controller: login_ID,
                                placeholder: 'Enter branch id',
                                onSaved: (value) {
                                  print(value);
                                },
                              ),
                            ),
                            CupertinoFormRow(
                              prefix: Text(
                                'Employee Password',
                                style: TextStyle(
                                  fontFamily: 'sfpro',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              child: CupertinoTextFormFieldRow(
                                cursorColor: Colors.black,
                                controller: login_password,
                                placeholder: 'Enter branch id',
                                onSaved: (value) {
                                  print(value);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: Visibility(
                          visible: isVisible_loading,
                          child: Center(
                            child: CupertinoActivityIndicator(
                              animating: isVisible_loading,
                              radius: 13,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: isVisible_button ? 1.0 : 0.0,
                          child: Visibility(
                            visible: isVisible_button,
                            child: CupertinoButton(
                              color: Colors.black,
                              child: Text(
                                "  Login ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'sfpro',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: () {
                                if (login_ID.text.isEmpty ||
                                    login_password.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Please fill in all fields.',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'sfpro',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      duration: Duration(seconds: 5),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                } else {
                                  setState(() {
                                    isVisible_button = false;
                                    isVisible_loading = true;
                                  });
                                  Login()
                                      .signIn(
                                        login_ID.text,
                                        login_password.text,
                                        context,
                                      )
                                      .whenComplete(() {
                                        setState(() {
                                          isVisible_button = true;
                                          isVisible_loading = false;
                                        });
                                      });
                                }

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => const Home(),
                                //   ),
                                // );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Center(
                        child: Text(
                          "If You Don't Have An Account, Please Register",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'sfpro',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 0),

                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CupertinoButton(
                              child: Text(
                                "Branch Registration",
                                style: TextStyle(
                                  fontFamily: 'sfpro',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RmAndArmPicker(),
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: 20),
                            CupertinoButton(
                              child: Text(
                                "User Registration",
                                style: TextStyle(
                                  fontFamily: 'sfpro',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PersonRegistrationPage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
