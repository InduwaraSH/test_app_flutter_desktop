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
  final String location;

  const SendButton_animated(
    this.SerialNumberController,
    this.PlaceOfCoupeController,
    this.LetterNoController,
    this.DateinforemedController,
    this.position,
    this.location, {
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
  late String location;
  String? savedValue;

  @override
  void initState() {
    super.initState();
    position = widget.position;
    location = widget.location;
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
        if (SerialNumberController.text.isEmpty ||
            PlaceOfCoupeController.text.isEmpty ||
            LetterNoController.text.isEmpty ||
            DateinforemedController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Please fill in all fields',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
          );
          return;
        } else {
          Map<String, String> reqData = {
            'Serial Number': SerialNumberController.text,
            'placeOfCoupe': PlaceOfCoupeController.text,
            'LetterNo': LetterNoController.text,
            'DateInformed': DateinforemedController.text,
            'ARM_Branch_Name': Provider.of<ARM_Selection_provider>(
              context,
              listen: false,
            ).selected.toString(),
          };
          FirebaseDatabase.instance
              .ref()
              .child("ARM_branch_data_saved")
              .child(savedValue.toString())
              .child("Recived")
              .push()
              .set(reqData)
              .then((_) {
                FirebaseDatabase.instance
                    .ref()
                    .child("RM_branch_data_saved")
                    .child(location.toString())
                    .child("Sent")
                    .push()
                    .set(reqData);
              })
              .then((_) async {
                DatabaseReference dbref = FirebaseDatabase.instance
                    .ref()
                    .child("Ongoing_Count")
                    .child(location)
                    .child("ongoing");

                await dbref.runTransaction((currentData) {
                  int currentValue =
                      (currentData as int?) ?? 0; // if not exist → 0
                  return Transaction.success(currentValue + 1);
                });
              })
              .then((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(
                      "Request Sent Successfully",
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
        }
      },
      duration: const Duration(milliseconds: 500),
      icons: <AnimatedIconItem>[
        AnimatedIconItem(
          icon: Icon(Icons.send, color: Colors.white),

          tooltip: "Turn into Light Mode",
          backgroundColor: Colors.blue,
        ),
        AnimatedIconItem(
          icon: Icon(Icons.send, color: Colors.white),
          backgroundColor: Colors.blue,
          tooltip: "Turn into Dark Mode",
        ),
      ],
    );
  }
}
