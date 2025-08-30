import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/ARM_SelectProvider.dart';
import 'package:test_code/Home.dart';
import 'package:test_code/RM_sent_provide.dart';
import 'package:test_code/firstpage.dart';
import 'package:test_code/selected_provider.dart';

class middle_ARM_create extends StatefulWidget {
  final String location;
  final String position;
  const middle_ARM_create({
    super.key,
    required this.location,
    required this.position,
  });

  @override
  State<middle_ARM_create> createState() => _homeState();
}

class _homeState extends State<middle_ARM_create> {
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
      .child("ARM_branch_data_saved")
      .child(location)
      .child("Recived");

  // 🔹 Branch Container Widget (Clickable)
  Widget branchItem({
    required String branchName,
    required Map branchData,
    required String letterNo,
    required String dateInformed,
    required String placeOfCoupe,
    required String serialNumber,
  }) {
    bool isActive = selectedBranch == branchName;

    Color bgColor = isActive
        ? Color.fromRGBO(104, 127, 229, 1)
        : const Color.fromRGBO(222, 236, 255, 1);
    Color textColor = isActive
        ? Colors.white
        : Color.fromRGBO(104, 127, 229, 1);
    Color borderColor = isActive
        ? Color.fromRGBO(104, 127, 229, 1)
        : const Color.fromRGBO(222, 236, 255, 1);
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBranch = branchName;
        });

        final rmSent = Provider.of<RM_Sent>(context, listen: false);

        rmSent.setSNum(serialNumber);
        rmSent.setPOC(placeOfCoupe);
        rmSent.setLetterNo(letterNo); // if exists in DB
        rmSent.setDateInformed(dateInformed); // if exists in DB
        rmSent.setARMBranchName(branchName); // if exists in DB
        rmSent.setSelected(true);
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
                  ? Color.fromRGBO(104, 127, 229, 1)
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
                  placeOfCoupe, // Galle / Matara
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'sfproRoundSemiB',
                    color: textColor,
                  ),
                ),
                Icon(Icons.apartment, color: textColor),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "Date informed: ${branchData['DateInformed']}",
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'sfproRoundSemiB',
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
                    String branchName =
                        datasnapshot['Serial Number']?.toString() ?? "Unknown";
                    String LetterNo =
                        datasnapshot['LetterNo']?.toString() ?? "Unknown";
                    String DateInformed =
                        datasnapshot['DateInformed']?.toString() ?? "Unknown";
                    String placeOfCoupe =
                        datasnapshot['placeOfCoupe']?.toString() ?? "Unknown";
                    String SerialNumber =
                        datasnapshot['Serial Number']?.toString() ?? "Unknown";

                    return branchItem(
                      branchName: branchName,
                      branchData: branchData,
                      letterNo: LetterNo,
                      dateInformed: DateInformed,
                      placeOfCoupe: placeOfCoupe,
                      serialNumber: SerialNumber,
                    );
                  },
            ),
          ),
        ],
      ),
    );
  }
}

extension on DataSnapshot {
  dynamic operator [](String key) {
    return (value as Map)[key];
  }
}
