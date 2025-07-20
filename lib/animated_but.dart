import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/theme_provider.dart';

class AnimatedButton extends StatelessWidget {
  const AnimatedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedIconButton(
      size: 20,

      onPressed: () {
        Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
      },
      duration: const Duration(milliseconds: 500),
      icons: <AnimatedIconItem>[
        AnimatedIconItem(
          icon: Icon(Icons.dark_mode, color: Colors.black),
          tooltip: "Turn into Light Mode",
          backgroundColor: Colors.amberAccent,
        ),
        AnimatedIconItem(
          icon: Icon(Icons.light_mode, color: Colors.amberAccent),
          backgroundColor: Colors.black,
          tooltip: "Turn into Dark Mode",
        ),
      ],
    );
  }
}
