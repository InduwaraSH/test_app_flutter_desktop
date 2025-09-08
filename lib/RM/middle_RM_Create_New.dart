import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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

  bool _isLoading = true; // loader flag
  final ScrollController _scrollController = ScrollController();

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

  late DatabaseReference dbrefRM_related_ARM_Offices = FirebaseDatabase.instance
      .ref()
      .child("Connection RM_ARM")
      .child(location);

  Widget branchItem({
    required String branchName,
    required Map branchData,
    required int index,
  }) {
    return _AnimatedBranchCard(
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
      delay: Duration(milliseconds: 80 * index),
      onAnimationStart: () {
        if (_isLoading && mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      },
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
          child: StreamBuilder<DatabaseEvent>(
            stream: dbrefRM_related_ARM_Offices.onValue,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
                return const Center(child: Text("No Branches Found"));
              }

              Map data = Map<String, dynamic>.from(
                snapshot.data!.snapshot.value as Map,
              );

              List<MapEntry> entries = data.entries.toList();

              return ListView.builder(
                controller: _scrollController,
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  String branchName = entries[index].key;
                  Map branchData = Map<String, dynamic>.from(
                    entries[index].value,
                  );

                  return branchItem(
                    branchName: branchName,
                    branchData: branchData,
                    index: index,
                  );
                },
              );
            },
          ),
        ),
        if (_isLoading)
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(0, 255, 255, 255),
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

/// 🔹 Drop + Fade Animated Card Wrapper
class _AnimatedBranchCard extends StatefulWidget {
  final String branchName;
  final Map branchData;
  final bool isActive;
  final VoidCallback onSelect;
  final Duration delay;
  final VoidCallback onAnimationStart;

  const _AnimatedBranchCard({
    super.key,
    required this.branchName,
    required this.branchData,
    required this.isActive,
    required this.onSelect,
    required this.delay,
    required this.onAnimationStart,
  });

  @override
  State<_AnimatedBranchCard> createState() => _AnimatedBranchCardState();
}

class _AnimatedBranchCardState extends State<_AnimatedBranchCard>
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
      begin: const Offset(0, -1.2), // start from above
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
        child: BranchCard(
          branchName: widget.branchName,
          branchData: widget.branchData,
          isActive: widget.isActive,
          onSelect: widget.onSelect,
        ),
      ),
    );
  }
}

/// 🔹 BranchCard with smooth gradient + hover animation
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

class _BranchCardState extends State<BranchCard>
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
  void didUpdateWidget(covariant BranchCard oldWidget) {
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
              );
            },
          ),
        ),
      ),
    );
  }
}
