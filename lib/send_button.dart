import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/theme_provider.dart';

class SendButton_animated extends StatelessWidget {
  const SendButton_animated({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedIconButton(
      size: 20,

      onPressed: () {
        
      },
      duration: const Duration(milliseconds: 500),
      icons: <AnimatedIconItem>[
        AnimatedIconItem(
          icon: Icon(Icons.send, color: Colors.white),
          tooltip: "Turn into Light Mode",
          backgroundColor: Colors.blue,
        ),
        AnimatedIconItem(
          icon: Icon(Icons.done_sharp, color: Colors.blue),
          backgroundColor: Colors.white,
          tooltip: "Turn into Dark Mode",
          
        ),
      ],
    );
  }
}
