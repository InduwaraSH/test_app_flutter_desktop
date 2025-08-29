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

class middle_RM_Send extends StatefulWidget {
  final String location;
  final String position;
  const middle_RM_Send({
    super.key,
    required this.location,
    required this.position,
  });

  @override
  State<middle_RM_Send> createState() => _homeState();
}

class _homeState extends State<middle_RM_Send> {
  late String location;
  late String position;
  String? selectedBranch;
  String branchName = "";

  @override
  void initState() {
    super.initState();
    location = widget.location;
    position = widget.position;

    selectedBranch = branchName;
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<RM_Sent>(context, listen: false).setSNum(branchName);
    // });
  }

  late Query dbrefRM_related_ARM_Offices = FirebaseDatabase.instance
      .ref()
      .child("RM_branch_data_saved")
      .child(location)
      .child("Sent");

  Widget SENDItem({required Map Alerts}) {
    bool isActive = selectedBranch == Alerts['Serial Number'];

    Color bgColor = isActive
        ? Color.fromRGBO(177, 175, 255, 1)
        : Color.fromRGBO(201, 203, 255, 0.107);
    Color textColor = isActive
        ? Colors.white
        : Color.fromRGBO(117, 106, 182, 1);
    Color borderColor = isActive
        ? Color.fromRGBO(177, 175, 255, 1)
        : Color.fromRGBO(201, 203, 255, 0);

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBranch = Alerts['Serial Number'];
        });

        final rmSent = Provider.of<RM_Sent>(context, listen: false);

        rmSent.setSNum(Alerts['Serial Number'].toString());
        rmSent.setPOC(Alerts['placeOfCoupe'].toString());
        rmSent.setLetterNo(Alerts['LetterNo'].toString()); // if exists in DB
        rmSent.setDateInformed(
          Alerts['DateInformed'].toString(),
        ); // if exists in DB
        rmSent.setARMBranchName(
          Alerts['ARM_Branch_Name'].toString(),
        ); // if exists in DB
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
                  ? Color.fromRGBO(177, 175, 255, 1)
                  : Color.fromRGBO(201, 203, 255, 0.152),
              blurRadius: isActive ? 20 : 1,
              spreadRadius: isActive ? 0 : 0,
              offset: const Offset(0, 2),
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
                  Alerts["placeOfCoupe"], // Galle / Matara
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                    fontFamily: 'sfproRoundSemiB',
                  ),
                ),
                Icon(Icons.apartment, color: textColor),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "Serial Number: ${Alerts['Serial Number']}",
              style: TextStyle(
                fontSize: 12,

                color: textColor,
                fontFamily: 'sfproRoundSemiB',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              final alerts = Map<String, dynamic>.from(
                datasnapshot.value as Map,
              );
              alerts['key'] = datasnapshot.key;
              return SENDItem(Alerts: alerts);
            },
      ),
    );
  }
}
