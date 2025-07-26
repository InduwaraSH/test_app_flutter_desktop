import 'dart:math';

import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frosted_glass_effect/frosted_glass_effect.dart';
import 'package:provider/provider.dart';
import 'package:test_code/animated_but.dart';
import 'package:test_code/button.dart';
import 'package:test_code/selected_provider.dart';
import 'package:test_code/theme_provider.dart';

class Homepg extends StatefulWidget {
  Homepg({super.key});

  @override
  State<Homepg> createState() => _HomepgState();
}

class _HomepgState extends State<Homepg> {
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

                          children: [AnimatedButton(), SizedBox(width: 8)],
                        ),
                        SizedBox(height: 40),
                        ButtonSelectionDemo(),
                        SizedBox(height: 20),

                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
              SizedBox(width: 30),
              Column(
                children: [
                  SizedBox(height: 30),

                  //middle container
                  Container(
                    width: (MediaQuery.of(context).size.width - 100) * 0.25,
                    height: MediaQuery.of(context).size.height * 0.9,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 30),

                          Container(
                            width:
                                (MediaQuery.of(context).size.width - 330) *
                                0.25,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSecondary,
                              borderRadius: BorderRadius.circular(15),
                              
                            ),
                            child: Center(child: Text(Provider.of<SelectionProvider>(context).selected ?? "None")),
                          ),

                          SizedBox(height: 30),

                          Container(
                            width:
                                (MediaQuery.of(context).size.width - 330) *
                                0.25,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.onInverseSurface,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          SizedBox(height: 30),

                          Container(
                            width:
                                (MediaQuery.of(context).size.width - 330) *
                                0.25,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.onInverseSurface,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            width:
                                (MediaQuery.of(context).size.width - 330) *
                                0.25,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.onInverseSurface,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            width:
                                (MediaQuery.of(context).size.width - 330) *
                                0.25,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.onInverseSurface,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            width:
                                (MediaQuery.of(context).size.width - 330) *
                                0.25,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.onInverseSurface,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
