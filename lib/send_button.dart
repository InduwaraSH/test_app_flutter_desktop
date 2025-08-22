import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/ARM_SelectProvider.dart';
import 'package:test_code/theme_provider.dart';

class SendButton_animated extends StatefulWidget {
  final TextEditingController SerialNumberController;
  final TextEditingController PlaceOfCoupeController;
  final TextEditingController LetterNoController;
  final TextEditingController DateinforemedController;
  final String position;

  const SendButton_animated(
    this.SerialNumberController,
    this.PlaceOfCoupeController,
    this.LetterNoController,
    this.DateinforemedController,
    this.position, {
    super.key,
  });

  @override
  State<SendButton_animated> createState() => _SendButton_animatedState();
}

class _SendButton_animatedState extends State<SendButton_animated> {
  late TextEditingController SerialNumberController;
  late TextEditingController PlaceOfCoupeController;
  late TextEditingController LetterNoController;
  late TextEditingController DateinforemedController;
  late DatabaseReference databaseReference;
  late String position;
  String? savedValue;

  @override
  void initState() {
    super.initState();
    position = widget.position;
    SerialNumberController = widget.SerialNumberController;
    PlaceOfCoupeController = widget.PlaceOfCoupeController;
    LetterNoController = widget.LetterNoController;
    DateinforemedController = widget.DateinforemedController;
    final provider = Provider.of<ARM_Selection_provider>(
      context,
      listen: false,
    );
    savedValue = provider.selected;

    // listen for changes
    provider.addListener(() {
      setState(() {
        savedValue = provider.selected;
      });
    });
    print(savedValue.toString());
    
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedIconButton(
      size: 20,
      onPressed: () {
        
        Map<String, String> reqData = {
          'Serial Number': SerialNumberController.text,
          'placeOfCoupe': PlaceOfCoupeController.text,
          'LetterNo': LetterNoController.text,
          'DateInformed': DateinforemedController.text,
        };
        FirebaseDatabase.instance
        .ref()
        .child("ARM_branch_data_saved")
        .child(savedValue.toString())
        .child("Recived")
        .push()
        .set(reqData)
        .then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                  content: Text(
                    savedValue.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            })
            .catchError((error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to update data: $error')),
              );
            });
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
