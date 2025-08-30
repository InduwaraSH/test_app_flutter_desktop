import 'dart:math';

import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frosted_glass_effect/frosted_glass_effect.dart';
import 'package:provider/provider.dart';
import 'package:test_code/animated_but.dart';
import 'package:test_code/button.dart';
import 'package:test_code/button_RM.dart';
import 'package:test_code/detail_panel.dart';
import 'package:test_code/firstpage.dart';
import 'package:test_code/form_RM_Create.dart';
import 'package:test_code/middle_RM.dart';
import 'package:test_code/middle_RM_Create.dart';
import 'package:test_code/midlle_container_data.dart';
import 'package:test_code/selected_provider.dart';
import 'package:test_code/theme.dart';
import 'package:test_code/theme_provider.dart';

import 'theme.dart';

class Home_RM extends StatefulWidget {
  final String location;
  final String position;
  const Home_RM({super.key, required this.location, required this.position});

  @override
  State<Home_RM> createState() => _Home_RMState();
}

class _Home_RMState extends State<Home_RM> {
  late String new_location;
  late String new_position;

  @override
  void initState() {
    super.initState();
    new_location = widget.location;
    new_position = widget.position;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Row(
            children: [
              SizedBox(width: 30),
              Column(
                children: [
                  SizedBox(height: 30),

                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    width: 250,
                    height: MediaQuery.of(context).size.height * 0.9,

                    child: Column(
                      children: [
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,

                          children: [
                            AnimatedButton(),
                            SizedBox(width: 8),
                            SizedBox(
                              width: 39, // button width
                              height: 39, // button height
                              child: ElevatedButton(
                                onPressed: () {
                                  FirebaseAuth.instance.signOut().whenComplete(
                                    () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => Firstpage(),
                                        ), // Login page
                                        (route) => false, // remove all routes
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.only(
                                    left: 6,
                                    top: 0,
                                  ),
                                  backgroundColor: Colors.black, // button color
                                  //elevation: 6, // shadow
                                ),
                                child: const Icon(
                                  Icons.logout,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                        SizedBox(height: 40),
                        Button_RM(),
                        SizedBox(height: 20),

                        // ElevatedButton(
                        //   onPressed: () {
                        //     FirebaseAuth.instance.signOut().whenComplete(() {
                        //       Navigator.pushAndRemoveUntil(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (_) => Firstpage(),
                        //         ), // Login page
                        //         (route) => false, // remove all routes
                        //       );
                        //     });
                        //   },
                        //   child: Text("Logout"),
                        // ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                ],
              ),
              SizedBox(width: 30),

              RM_Middle(location: new_location, position: new_position),
              //middle_RM(location: new_location, position: new_position),
              SizedBox(width: 30),
              Column(
                children: [
                  SizedBox(height: 30),
                  Container(
                    width: (MediaQuery.of(context).size.width - 100) * 0.52,
                    height: MediaQuery.of(context).size.height * 0.9,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: DetailPanel(
                      location: new_location,
                      position: new_position,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 30),
            ],
          ),
        ),
      ),
    );
  }
}
