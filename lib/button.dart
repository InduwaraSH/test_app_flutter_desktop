import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ButtonSelectionDemo()));
}

class ButtonSelectionDemo extends StatefulWidget {
  @override
  _ButtonSelectionDemoState createState() => _ButtonSelectionDemoState();
}

class _ButtonSelectionDemoState extends State<ButtonSelectionDemo> {
  String? activeButton;

  void setActive(String color) {
    setState(() {
      activeButton = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildColorButton("Recived", Theme.of(context).colorScheme.onPrimary),
        SizedBox(height: 15),
        buildColorButton(
          "Authorized",
          Theme.of(context).colorScheme.onSecondary,
        ),
        SizedBox(height: 15),
        buildColorButton("Rejected", const Color.fromARGB(255, 251, 33, 33)),
      ],
    );
  }

  Widget buildColorButton(String key, Color color) {
    final isActive = activeButton == key;
    return ElevatedButton(
      onPressed: () => setActive(key),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(210, 50),
        backgroundColor: isActive ? color : Colors.white,
        foregroundColor: isActive ? Colors.white : Colors.black,
        elevation: isActive ? 10 : 2, 
        shadowColor: isActive
            ? color.withValues(alpha: 0.9)
            : const Color.fromARGB(255, 255, 255, 255).withOpacity(0.4), 
        //side: BorderSide(color: color, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Text(key.toUpperCase()),
    );
  }
}
