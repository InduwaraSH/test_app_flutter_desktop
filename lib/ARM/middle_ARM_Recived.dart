import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/RM_sent_provide.dart';
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
        .child("ARM_branch_data_saved")
        .child(location)
        .child("Recived");

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

  Widget branchItem({required Map branchData, required int index}) {
    return _AnimatedSendCard(
      alerts: branchData,
      isActive: selectedBranch == branchData['Serial Number'],
      onSelect: () {
        setState(() {
          selectedBranch = branchData['Serial Number'];
        });

        final rmSent = Provider.of<RM_Sent>(context, listen: false);
        rmSent.setSNum(branchData['Serial Number']?.toString() ?? '');
        rmSent.setPOC(branchData['placeOfCoupe']?.toString() ?? '');
        rmSent.setLetterNo(branchData['LetterNo']?.toString() ?? '');
        rmSent.setDateInformed(branchData['DateInformed']?.toString() ?? '');
        rmSent.setARMBranchName(
          branchData['ARM_Branch_Name']?.toString() ?? '',
        );
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
                      final branchData = items[index];
                      return branchItem(branchData: branchData, index: index);
                    },
                  ),
                ),
        ),
        if (_isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.transparent,
              child: const Center(
                child: CupertinoActivityIndicator(
                  radius: 15,
                  color: Color(0xFF687FE5), // same as RM loader
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// 🔹 Drop + Fade Animated Card Wrapper
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

/// 🔹 SendCard (same color style as BranchCard in RM)
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

class _SendCardState extends State<SendCard>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;

  late ColorTween color1Tween;
  late ColorTween color2Tween;
  late AnimationController gradientController;
  late Animation<Color?> color1Animation;
  late Animation<Color?> color2Animation;

  @override
  void initState() {
    super.initState();

    color1Tween = ColorTween(
      begin: const Color(0xFFE2ECFF),
      end: const Color(0xFF687FE5),
    );
    color2Tween = ColorTween(
      begin: const Color(0xFFD6E4FA),
      end: const Color(0xFF5065D8),
    );

    gradientController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    color1Animation = color1Tween.animate(gradientController);
    color2Animation = color2Tween.animate(gradientController);

    if (widget.isActive) {
      gradientController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant SendCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        gradientController.forward();
      } else {
        gradientController.reverse();
      }
    }
  }

  @override
  void dispose() {
    gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onSelect,
        child: AnimatedScale(
          scale: isHovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: AnimatedBuilder(
            animation: gradientController,
            builder: (context, child) {
              return Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color1Animation.value!, color2Animation.value!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: widget.isActive
                          ? const Color(0xFF687FE5).withOpacity(0.5)
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
                    /// Top row
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
                                  : const Color(0xFF5065D8),
                              overflow: TextOverflow.ellipsis,
                            ),
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

                    /// Serial Number
                    Text(
                      "Serial Number: ${widget.alerts['Serial Number'] ?? 'Unknown'}",
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
              );
            },
          ),
        ),
      ),
    );
  }
}
