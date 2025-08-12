import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Firstpage extends StatelessWidget {
  const Firstpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
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
                  color: Colors.grey[200],
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
                        backgroundColor: Colors.grey[200] ?? Colors.grey,
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
                              //controller: personId,
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
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            child: CupertinoTextFormFieldRow(
                              cursorColor: Colors.black,
                              //controller: personId,
                              placeholder: 'Enter branch id',
                              onSaved: (value) {
                                print(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 60),
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
                    SizedBox(height: 10),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CupertinoButton(
                            color: const Color.fromARGB(126, 0, 0, 0),
                            child: Text(
                              "Branch Register",
                              style: TextStyle(
                                fontFamily: 'sfpro',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {},
                          ),
                          SizedBox(width: 20),
                          CupertinoButton(
                            color: Color.fromARGB(126, 0, 0, 0),
                            child: Text(
                              "Person Register",
                              style: TextStyle(
                                fontFamily: 'sfpro',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {},
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
    );
  }
}
