import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class BranchList extends StatelessWidget {
  final DatabaseReference dbRef =
      FirebaseDatabase.instance.ref().child("Connection_RM_ARM").child("Matara");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Matara Main Branch")),
      body: StreamBuilder(
        stream: dbRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return const Center(child: Text("No branches found"));
          }

          // Convert to Map
          final data = Map<String, dynamic>.from(
              snapshot.data!.snapshot.value as Map);

          final branchNames = data.keys.toList();

          return ListView.builder(
            itemCount: branchNames.length,
            itemBuilder: (context, index) {
              final branchName = branchNames[index];
              final branchData = Map<String, dynamic>.from(data[branchName]);

              return ListTile(
                leading: const Icon(Icons.account_tree),
                title: Text(branchName), // Galle / Matara
                subtitle: Text("Branch ID: ${branchData['ARM_branchID']}"),
              );
            },
          );
        },
      ),
    );
  }
}