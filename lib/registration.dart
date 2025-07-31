import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_code/picker.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

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
                    fontSize: 30,
                    fontFamily: 'sfpro',
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
                          child: Row(children: [SizedBox(width: 30), Picker()]),
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

                  onPressed: () {},
                  child: Text('Submit', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
