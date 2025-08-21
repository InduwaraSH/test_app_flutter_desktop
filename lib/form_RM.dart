import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/ARM_SelectProvider.dart';

class form_RM extends StatefulWidget {
  const form_RM({super.key});

  @override
  State<form_RM> createState() => _form_RMState();
}

class _form_RMState extends State<form_RM> {
  final TreeName = TextEditingController();
  final District = TextEditingController();
  final CircumferenceOfTree = TextEditingController();
  final HeightOfTree = TextEditingController();
  final AgeOfTree = TextEditingController();
  final DangerLevel = TextEditingController();

  late DatabaseReference databaseReference;

  @override
  void initState() {
    super.initState();
    databaseReference = FirebaseDatabase.instance
        .ref()
        .child("ARM_branch_data_saved")
        .child("Matara");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: TreeName,
              decoration: InputDecoration(labelText: 'Tree Name'),
            ),

            TextField(
              controller: District,
              decoration: InputDecoration(labelText: 'District'),
            ),
            TextField(
              controller: CircumferenceOfTree,
              decoration: InputDecoration(labelText: 'Circumference of Tree'),
            ),
            TextField(
              controller: HeightOfTree,
              decoration: InputDecoration(labelText: 'Height of Tree'),
            ),
            TextField(
              controller: AgeOfTree,
              decoration: InputDecoration(labelText: 'Age of Tree'),
            ),
            TextField(
              controller: DangerLevel,
              decoration: InputDecoration(labelText: 'Danger Level'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Map<String, String> ticketdata = {
                  'Tree Name': TreeName.text,
                  'District': District.text,
                  'Circumference of Tree': CircumferenceOfTree.text,
                  'Height of Tree': HeightOfTree.text,
                  'Age of Tree': AgeOfTree.text,
                  'Danger Level': DangerLevel.text,
                };
                databaseReference
                    .push()
                    .set(ticketdata)
                    .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Data Updated Successfully')),
                      );
                    })
                    .catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to update data: $error'),
                        ),
                      );
                    });
              },
              child: Text(
                Provider.of<ARM_Selection_provider>(
                      context,
                    ).selected.toString() ??
                    "Select Branch",

                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
