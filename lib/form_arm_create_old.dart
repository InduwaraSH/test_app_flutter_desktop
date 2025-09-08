import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/ARM_SelectProvider.dart';
import 'package:test_code/dateTime.dart';
import 'package:test_code/send_button.dart';

class form_ARM_Create_old extends StatefulWidget {
  final String location;
  final String position;
  const form_ARM_Create_old({
    super.key,
    required this.location,
    required this.position,
  });

  @override
  State<form_ARM_Create_old> createState() => _form_ARM_Create_oldState();
}

class _form_ARM_Create_oldState extends State<form_ARM_Create_old> {
  final SerialNumberController = TextEditingController();
  final PlaceOfCoupeController = TextEditingController();
  final LetterNoController = TextEditingController();
  final DateinforemedController = TextEditingController();

  String? savedValue;

  // default
  late String location;
  late String position;

  @override
  void initState() {
    super.initState();
    location = widget.location;
    position = widget.position;

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
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 50),
                          Text(
                            "From : RM Branch in $location",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'DMSerif',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(92, 112, 202, 1),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          SizedBox(width: 50),
                          Text(
                            "To : ARM Branch in ${Provider.of<ARM_Selection_provider>(context).selected.toString() ?? "Select Branch"}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'DMSerif',
                              fontSize: 18,

                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(92, 112, 202, 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SendButton_animated(
                  SerialNumberController,
                  PlaceOfCoupeController,
                  LetterNoController,
                  DateinforemedController,
                  position,
                  location,
                ),
                SizedBox(width: 10),
              ],
            ),

            SizedBox(height: 30),
            Form(
              child: CupertinoFormSection.insetGrouped(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(104, 127, 229, 0.12),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Color.fromRGBO(104, 127, 229, 0.591),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(
                        255,
                        204,
                        217,
                        233,
                      ).withOpacity(0.6),
                      blurRadius: 100,
                      spreadRadius: 0.1,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                children: <Widget>[
                  CupertinoTextFormFieldRow(
                    prefix: Text(
                      "දැව භාරදුන් ආයතනය හා කොට්ඨාසය   :   ",
                      style: TextStyle(
                        color: Color.fromRGBO(71, 61, 129, 1),
                        fontFamily: 'RoboSerif',
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    placeholder: 'Enter Serial Number',
                    controller: SerialNumberController,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'RoboSerif',
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Text(
                      'දැව භාරදුන් ආයතනයේ ලිපි අංකය හා දිනය  :   ',
                      style: TextStyle(
                        color: Color.fromRGBO(71, 61, 129, 1),
                        fontFamily: 'AbhayaLibre',

                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                    controller: PlaceOfCoupeController,
                    placeholder: 'Enter Place of Coupe',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'RoboSerif',
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                    cursorColor: Colors.black,
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Text(
                      'දැව ඇති ස්ථානය :   ',
                      style: TextStyle(
                        color: Color.fromRGBO(71, 61, 129, 1),
                        fontFamily: 'RoboSerif',
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    placeholder: 'Enter Letter No',
                    controller: LetterNoController,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'RoboSerif',
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Text(
                      'දැව පවතින ස්වභාවය :   ',
                      style: TextStyle(
                        color: Color.fromRGBO(71, 61, 129, 1),
                        fontFamily: 'RoboSerif',
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    placeholder: 'Enter Letter No',
                    controller: LetterNoController,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'RoboSerif',
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Text(
                      'දැව පරික්ෂා කල නිලධාරියාගේ නම :',
                      style: TextStyle(
                        color: Color.fromRGBO(71, 61, 129, 1),
                        fontFamily: 'RoboSerif',
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    placeholder: 'Enter Letter No',
                    controller: LetterNoController,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'RoboSerif',
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Text(
                      'දැව පරික්ෂා කල නිලධාරියාගේ තනතුර :   ',
                      style: TextStyle(
                        color: Color.fromRGBO(71, 61, 129, 1),
                        fontFamily: 'RoboSerif',
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    placeholder: 'Enter Letter No',
                    controller: LetterNoController,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'RoboSerif',
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Row(
                      children: [
                        Text(
                          'පරික්ෂා කල දිනය:',
                          style: TextStyle(
                            color: Color.fromRGBO(71, 61, 129, 1),
                            fontWeight: FontWeight.w900,
                            fontFamily: 'RoboSerif',
                            fontSize: 20,
                          ),
                        ),
                        SimpleDatePicker(
                          initialDate: DateTime.now(),
                          onDateChanged: (date) {
                            print("Selected Date: $date");
                            setState(() {
                              DateinforemedController.text = date.toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Text(
                      'ගස් ගණන  :',
                      style: TextStyle(
                        color: Color.fromRGBO(71, 61, 129, 1),
                        fontWeight: FontWeight.w900,
                        fontFamily: 'RoboSerif',
                        fontSize: 20,
                      ),
                    ),
                    placeholder: 'Enter Letter No',
                    controller: LetterNoController,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'RoboSerif',
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:test_code/ARM_SelectProvider.dart';
// import 'package:test_code/Home.dart';
// import 'package:test_code/RM_sent_provide.dart';
// import 'package:test_code/firstpage.dart';
// import 'package:test_code/selected_provider.dart';

// class middle_ARM_create_old extends StatefulWidget {
//   final String location;
//   final String position;
//   const middle_ARM_create_old({
//     super.key,
//     required this.location,
//     required this.position,
//   });

//   @override
//   State<middle_ARM_create_old> createState() => _homeState();
// }

// class _homeState extends State<middle_ARM_create_old> {
//   late String location;
//   late String position;
//   String? selectedBranch;
//   String branchName = "Galle";

//   @override
//   void initState() {
//     super.initState();
//     location = widget.location;
//     position = widget.position;

//     selectedBranch = branchName;
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // Provider.of<ARM_Selection_provider>(
//       //   context,
//       //   listen: false,
//       // ).setSelected(branchName);

//       Provider.of<ARM_Selection_provider>(
//         context,
//         listen: false,
//       ).setSelected(branchName);
//     });

//     // Provider.of<ARM_Selection_provider>(
//     //       context,
//     //       listen: false,
//     //     ).setSelected(branchName);
//   }

//   late Query dbrefRM_related_ARM_Offices = FirebaseDatabase.instance
//       .ref()
//       .child("ARM_branch_data_saved")
//       .child(location)
//       .child("Recived");

//   // 🔹 Branch Container Widget (Clickable)
//   Widget branchItem({
//     required String branchName,
//     required Map branchData,
//     required String letterNo,
//     required String dateInformed,
//     required String placeOfCoupe,
//     required String serialNumber,
//   }) {
//     bool isActive = selectedBranch == branchName;

//     Color bgColor = isActive
//         ? Color.fromRGBO(104, 127, 229, 1)
//         : const Color.fromRGBO(222, 236, 255, 1);
//     Color textColor = isActive
//         ? Colors.white
//         : Color.fromRGBO(104, 127, 229, 1);
//     Color borderColor = isActive
//         ? Color.fromRGBO(104, 127, 229, 1)
//         : const Color.fromRGBO(222, 236, 255, 1);
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedBranch = branchName;
//         });

//         final rmSent = Provider.of<RM_Sent>(context, listen: false);

//         rmSent.setSNum(serialNumber);
//         rmSent.setPOC(placeOfCoupe);
//         rmSent.setLetterNo(letterNo); // if exists in DB
//         rmSent.setDateInformed(dateInformed); // if exists in DB
//         rmSent.setARMBranchName(branchName); // if exists in DB
//         rmSent.setSelected(true);
//       },

//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 400),
//         curve: Curves.easeInOut,
//         padding: const EdgeInsets.all(12),
//         margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//         decoration: BoxDecoration(
//           color: bgColor,
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(color: borderColor, width: 2),
//           boxShadow: [
//             BoxShadow(
//               color: isActive
//                   ? Color.fromRGBO(104, 127, 229, 1)
//                   : Colors.grey.withOpacity(0.3),
//               blurRadius: isActive ? 15 : 6,
//               spreadRadius: isActive ? 2 : 0,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   placeOfCoupe, // Galle / Matara
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                     fontFamily: 'sfproRoundSemiB',
//                     color: textColor,
//                   ),
//                 ),
//                 Icon(Icons.apartment, color: textColor),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Text(
//               "Date informed: ${branchData['DateInformed']}",
//               style: TextStyle(
//                 fontSize: 12,
//                 fontFamily: 'sfproRoundSemiB',
//                 fontWeight: FontWeight.w400,
//                 color: textColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Container(
//             margin: const EdgeInsets.only(bottom: 40, top: 10),
//             padding: const EdgeInsets.only(bottom: 10, top: 10),
//             width: (MediaQuery.of(context).size.width - 100) * 0.25,
//             height: MediaQuery.of(context).size.height * 0.9,
//             decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.primary,
//               borderRadius: BorderRadius.circular(26),
//             ),
//             child: FirebaseAnimatedList(
//               query: dbrefRM_related_ARM_Offices,
//               itemBuilder:
//                   (
//                     BuildContext context,
//                     DataSnapshot datasnapshot,
//                     Animation<double> animation,
//                     int index,
//                   ) {
//                     if (datasnapshot.value == null) {
//                       return const SizedBox();
//                     }

//                     Map branchData = Map<String, dynamic>.from(
//                       datasnapshot.value as Map,
//                     );
//                     String branchName =
//                         datasnapshot['Serial Number']?.toString() ?? "Unknown";
//                     String LetterNo =
//                         datasnapshot['LetterNo']?.toString() ?? "Unknown";
//                     String DateInformed =
//                         datasnapshot['DateInformed']?.toString() ?? "Unknown";
//                     String placeOfCoupe =
//                         datasnapshot['placeOfCoupe']?.toString() ?? "Unknown";
//                     String SerialNumber =
//                         datasnapshot['Serial Number']?.toString() ?? "Unknown";

//                     return branchItem(
//                       branchName: branchName,
//                       branchData: branchData,
//                       letterNo: LetterNo,
//                       dateInformed: DateInformed,
//                       placeOfCoupe: placeOfCoupe,
//                       serialNumber: SerialNumber,
//                     );
//                   },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// extension on DataSnapshot {
//   dynamic operator [](String key) {
//     return (value as Map)[key];
//   }
// }
