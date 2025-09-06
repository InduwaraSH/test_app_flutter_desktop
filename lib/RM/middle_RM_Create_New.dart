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

class middle_RM_create_new extends StatefulWidget {
  final String location;
  final String position;
  const middle_RM_create_new({
    super.key,
    required this.location,
    required this.position,
  });

  @override
  State<middle_RM_create_new> createState() => _homeState();
}

class _homeState extends State<middle_RM_create_new> {
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
      Provider.of<ARM_Selection_provider>(
        context,
        listen: false,
      ).setSelected(branchName);
    });
  }

  late Query dbrefRM_related_ARM_Offices = FirebaseDatabase.instance
      .ref()
      .child("Connection RM_ARM")
      .child(location);

  // 🔹 Branch Item Widget (separate for hover animation)
  Widget branchItem({required String branchName, required Map branchData}) {
    return BranchCard(
      branchName: branchName,
      branchData: branchData,
      isActive: selectedBranch == branchName,
      onSelect: () {
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

/// 🔹 Separate Stateful Card Widget with hover effect + animation
class BranchCard extends StatefulWidget {
  final String branchName;
  final Map branchData;
  final bool isActive;
  final VoidCallback onSelect;

  const BranchCard({
    super.key,
    required this.branchName,
    required this.branchData,
    required this.isActive,
    required this.onSelect,
  });

  @override
  State<BranchCard> createState() => _BranchCardState();
}

class _BranchCardState extends State<BranchCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    Color activeColor1 = const Color(0xFF687FE5);
    Color activeColor2 = const Color(0xFF5065D8);
    Color inactiveColor1 = const Color(0xFFE2ECFF);
    Color inactiveColor2 = const Color(0xFFD6E4FA);

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onSelect,
        child: AnimatedScale(
          scale: isHovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              gradient: widget.isActive
                  ? LinearGradient(
                      colors: [activeColor1, activeColor2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : LinearGradient(
                      colors: [inactiveColor1, inactiveColor2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: widget.isActive
                      ? activeColor1.withOpacity(0.5)
                      : Colors.black12,
                  blurRadius: isHovered ? 20 : 10,
                  spreadRadius: isHovered ? 2 : 0,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Title Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.branchName,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'sfproRoundSemiB',
                        color: widget.isActive
                            ? Colors.white
                            : const Color(0xFF5065D8),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: widget.isActive
                            ? Colors.white.withOpacity(0.2)
                            : const Color(0xFF5065D8).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.apartment_rounded,
                        size: 22,
                        color: widget.isActive
                            ? Colors.white
                            : const Color(0xFF5065D8),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // 🔹 Branch ID
                Text(
                  "Branch ID: ${widget.branchData['ARM_branchID']}",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'sfproRoundSemiB',
                    fontWeight: FontWeight.w400,
                    color: widget.isActive
                        ? Colors.white.withOpacity(0.9)
                        : const Color(0xFF5065D8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
