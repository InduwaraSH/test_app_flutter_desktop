import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              SizedBox(height: 20),
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
                          'Bus Number',
                          style: TextStyle(
                            fontFamily: 'sfpro',

                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        child: CupertinoTextFormFieldRow(
                          cursorColor: Theme.of(context).colorScheme.outline,
                          placeholder: 'Enter bus number',
                          onSaved: (value) {
                            print(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
