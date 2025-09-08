import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/selected_provider.dart';

void main() {
  runApp(MaterialApp(home: Button_RM()));
}

class Button_RM extends StatefulWidget {
  @override
  _Button_RMState createState() => _Button_RMState();
}

class _Button_RMState extends State<Button_RM> {
  String? activeButton;

  @override
  void initState() {
    super.initState();
    activeButton = "CREATE";
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SelectionProvider>(
        context,
        listen: false,
      ).setSelected(activeButton!);
    });
  }

  void setActive(String key) {
    setState(() {
      activeButton = key;
    });
    print("Pressed button: $key");
    Provider.of<SelectionProvider>(context, listen: false).setSelected(key);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildColorButton("CREATE", Color(0xFF5065D8)),
        SizedBox(height: 15),
        buildColorButton("RECIVED", Color.fromRGBO(114, 99, 255, 1)),
        SizedBox(height: 15),
        buildColorButton("SEND", const Color(0xFF857CFF)),
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

  String getSelectedValue() {
    return activeButton ?? '';
  }
}
