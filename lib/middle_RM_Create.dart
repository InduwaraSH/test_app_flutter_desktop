import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/ARM_SelectProvider.dart';
import 'package:test_code/Home.dart';
import 'package:test_code/firstpage.dart';
import 'package:test_code/selected_provider.dart';

class middle_RM_create extends StatefulWidget {
  final String location;
  final String position;
  const middle_RM_create({super.key, required this.location, required this.position});

  @override
  State<middle_RM_create> createState() => _homeState();
}

class _homeState extends State<middle_RM_create> {
  late String location;
  late String position;
  String? selectedBranch;
  String branchName = "Galle";

  @override
  void initState() {
    super.initState();
    location = widget.location;
    position = widget.position;

    selectedBranch = branchName;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Provider.of<ARM_Selection_provider>(
      //   context,
      //   listen: false,
      // ).setSelected(branchName);

      Provider.of<ARM_Selection_provider>(
        context,
        listen: false,
      ).setSelected(branchName);
    });

    // Provider.of<ARM_Selection_provider>(
    //       context,
    //       listen: false,
    //     ).setSelected(branchName);
  }

  late Query dbrefRM_related_ARM_Offices = FirebaseDatabase.instance
      .ref()
      .child("Connection RM_ARM")
      .child(location);

  // 🔹 Branch Container Widget (Clickable)
  Widget branchItem({required String branchName, required Map branchData}) {
    bool isActive = selectedBranch == branchName;

    Color bgColor = isActive ? Colors.blueAccent : Colors.white;
    Color textColor = isActive ? Colors.white : Colors.black;
    Color borderColor = isActive
        ? Colors.blueAccent
        : const Color.fromARGB(255, 248, 248, 248);

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBranch = branchName;
        });
        Provider.of<ARM_Selection_provider>(
          context,
          listen: false,
        ).setSelected(branchName);

        Provider.of<ARM_Selection_provider>(
          context,
          listen: false,
        ).setType("ARM");
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: isActive
                  ? Colors.blueAccent.withOpacity(0.6)
                  : Colors.grey.withOpacity(0.3),
              blurRadius: isActive ? 15 : 6,
              spreadRadius: isActive ? 2 : 0,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  branchName, // Galle / Matara
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Icon(Icons.apartment, color: textColor),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "Branch ID: ${branchData['ARM_branchID']}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 40, top: 10),
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            width: (MediaQuery.of(context).size.width - 100) * 0.25,
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(26),
            ),
            child: FirebaseAnimatedList(
              query: dbrefRM_related_ARM_Offices,
              itemBuilder:
                  (
                    BuildContext context,
                    DataSnapshot datasnapshot,
                    Animation<double> animation,
                    int index,
                  ) {
                    if (datasnapshot.value == null) {
                      return const SizedBox();
                    }

                    Map branchData = Map<String, dynamic>.from(
                      datasnapshot.value as Map,
                    );
                    String branchName = datasnapshot.key ?? "Unknown";

                    return branchItem(
                      branchName: branchName,
                      branchData: branchData,
                    );
                  },
            ),
          ),
        ],
      ),
    );
  }
}
