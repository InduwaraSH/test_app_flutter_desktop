import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/ARM_SelectProvider.dart';
import 'package:test_code/RM_sent_provide.dart';

class middle_RM_Send_new extends StatefulWidget {
  final String location;
  final String position;
  const middle_RM_Send_new({
    super.key,
    required this.location,
    required this.position,
  });

  @override
  State<middle_RM_Send_new> createState() => _homeState();
}

class _homeState extends State<middle_RM_Send_new> {
  late String location;
  late String position;
  String? selectedBranch;
  String branchName = "";

  bool _isLoading = true;
  List<Map<String, dynamic>> items = [];
  final ScrollController _scrollController = ScrollController();

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    location = widget.location;
    position = widget.position;
    selectedBranch = branchName;

    dbRef = FirebaseDatabase.instance
        .ref()
        .child("RM_branch_data_saved")
        .child(location)
        .child("Sent");

    loadData();
  }

  Future<void> loadData() async {
    final snapshot = await dbRef.get();
    if (snapshot.exists) {
      final List<Map<String, dynamic>> temp = [];
      snapshot.children.forEach((child) {
        final data = Map<String, dynamic>.from(child.value as Map);
        data['key'] = child.key;
        temp.add(data);
      });

      setState(() {
        items = temp.reversed.toList(); // Last saved first
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget SENDItem({required Map Alerts, required int index}) {
    return _AnimatedSendCard(
      alerts: Alerts,
      isActive: selectedBranch == Alerts['Serial Number'],
      onSelect: () {
        setState(() {
          selectedBranch = Alerts['Serial Number'];
        });

        final rmSent = Provider.of<RM_Sent>(context, listen: false);

        rmSent.setSNum(Alerts['Serial Number'].toString());
        rmSent.setPOC(Alerts['placeOfCoupe'].toString());
        rmSent.setLetterNo(Alerts['LetterNo'].toString());
        rmSent.setDateInformed(Alerts['DateInformed'].toString());
        rmSent.setARMBranchName(Alerts['ARM_Branch_Name'].toString());
        rmSent.setSelected(true);
      },
      delay: Duration(milliseconds: 80 * index),
      onAnimationStart: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
          child: _isLoading
              ? const SizedBox.shrink()
              : ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: const ClampingScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final alerts = items[index];
                      return SENDItem(Alerts: alerts, index: index);
                    },
                  ),
                ),
        ),
        if (_isLoading)
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(0, 0, 0, 0),
              child: const Center(
                child: CupertinoActivityIndicator(
                  radius: 15,
                  color: Color(0xFFB1AFFF),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Animated card wrapper with bottom-to-top drop + fade
class _AnimatedSendCard extends StatefulWidget {
  final Map alerts;
  final bool isActive;
  final VoidCallback onSelect;
  final Duration delay;
  final VoidCallback onAnimationStart;

  const _AnimatedSendCard({
    Key? key,
    required this.alerts,
    required this.isActive,
    required this.onSelect,
    required this.delay,
    required this.onAnimationStart,
  }) : super(key: key);

  @override
  State<_AnimatedSendCard> createState() => _AnimatedSendCardState();
}

class _AnimatedSendCardState extends State<_AnimatedSendCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    Future.delayed(widget.delay, () {
      if (mounted) {
        widget.onAnimationStart();
        setState(() => _visible = true);
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) return const SizedBox.shrink();

    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SendCard(
          alerts: widget.alerts,
          isActive: widget.isActive,
          onSelect: widget.onSelect,
        ),
      ),
    );
  }
}

/// SendCard UI
class SendCard extends StatefulWidget {
  final Map alerts;
  final bool isActive;
  final VoidCallback onSelect;

  const SendCard({
    super.key,
    required this.alerts,
    required this.isActive,
    required this.onSelect,
  });

  @override
  State<SendCard> createState() => _SendCardState();
}

class _SendCardState extends State<SendCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    Color activeColor1 = const Color(0xFFB1AFFF);
    Color activeColor2 = const Color(0xFF857CFF);
    Color inactiveColor1 = const Color(0xFFEDEBFF);
    Color inactiveColor2 = const Color(0xFFDAD6FF);

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.alerts["placeOfCoupe"] ?? "Unknown",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'sfproRoundSemiB',
                          color: widget.isActive
                              ? Colors.white
                              : const Color(0xFF756AB6),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: widget.isActive
                            ? Colors.white.withOpacity(0.2)
                            : const Color(0xFF756AB6).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.apartment_rounded,
                        size: 22,
                        color: widget.isActive
                            ? Colors.white
                            : const Color(0xFF756AB6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  "Serial Number: ${widget.alerts['Serial Number']}",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'sfproRoundSemiB',
                    fontWeight: FontWeight.w400,
                    color: widget.isActive
                        ? Colors.white.withOpacity(0.9)
                        : const Color(0xFF756AB6),
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
