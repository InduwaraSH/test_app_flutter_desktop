import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:test_code/ARM/reviewBeforeARMCreate.dart';

class TreeQuesForm extends StatefulWidget {
  final int treeCount;
  final String sectionNumber;
  final String PlaceOfCoupe;
  final String LetterNo;
  final String Condition;
  final String OfficerName;
  final String OfficerPosition;
  final String Dateinforemed;
  final String location;
  final String position;

  const TreeQuesForm({
    super.key,
    required this.treeCount,
    required this.sectionNumber,
    required this.PlaceOfCoupe,
    required this.LetterNo,
    required this.Condition,
    required this.OfficerName,
    required this.OfficerPosition,
    required this.Dateinforemed,
    required this.location,
    required this.position,
  });

  @override
  State<TreeQuesForm> createState() => _TreeQuesFormState();
}

class _TreeQuesFormState extends State<TreeQuesForm> {
  int currentIndex = 0;
  late PageController _pageController;
  late String new_sectionNumber;
  late String PlaceOfCoupe;
  late String LetterNo;
  late String Condition;
  late String OfficerName;
  late String OfficerPosition;
  late String Dateinforemed;
  late String treeCount;
  late String location;
  late String position;

  final List<String> fields = [
    "ගස් වර්ගය",
    "පංතිය",
    "සත්‍ය උස",
    "වාණීජමය උස",
    "පපු මට්ටමේ වට",
    "පරිමාව",
    "වටිනාකම",
    "වෙනත්",
  ];

  late List<Map<String, TextEditingController>> treeControllers;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    treeControllers = List.generate(
      widget.treeCount,
      (_) => {for (var f in fields) f: TextEditingController()},
    );

    new_sectionNumber = widget.sectionNumber.toString();
    PlaceOfCoupe = widget.PlaceOfCoupe;
    LetterNo = widget.LetterNo;
    Condition = widget.Condition;
    OfficerName = widget.OfficerName;
    OfficerPosition = widget.OfficerPosition;
    Dateinforemed = widget.Dateinforemed;
    treeCount = widget.treeCount.toString();
    location = widget.location;
    position = widget.position;
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var map in treeControllers) {
      for (var c in map.values) {
        c.dispose();
      }
    }
    super.dispose();
  }

  void _review() {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false, // keeps background visible (like dialog)
        barrierDismissible: false,
        pageBuilder: (_, __, ___) {
          return Center(
            child: Dialog(
              insetPadding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ReviewPage(
                  fields: fields,
                  treeControllers: treeControllers,
                  onEdit: (index) {
                    Navigator.pop(context); // close dialog
                    setState(() {
                      currentIndex = index;
                    });
                    _pageController.jumpToPage(index);
                  },
                  onConfirm: _save,
                ),
              ),
            ),
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 0.1); // slide from bottom
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var fadeTween = Tween<double>(begin: 0, end: 1);

          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(
              opacity: animation.drive(fadeTween),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 450),
      ),
    );
  }

  void _next() {
    final currentFields = treeControllers[currentIndex];
    bool allFilled = true;

    for (var f in fields) {
      if (currentFields[f]!.text.trim().isEmpty) {
        allFilled = false;
        // Show a subtle toast message for empty field
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please fill "${f}"',
              style: TextStyle(color: Colors.white),
            ),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.redAccent,
          ),
        );
        break; // only show for the first empty field
      }
    }

    if (!allFilled) return;

    if (currentIndex < widget.treeCount - 1) {
      setState(() => currentIndex++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOutCubic,
      );
    } else {
      //_save();
      _review();
    }
  }

  void _back() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _cancel() => Navigator.pop(context);

  void _save() async {
    final database = FirebaseDatabase.instance.ref();

    // Collect all tree data
    List<Map<String, String>> allTrees = [];
    for (var tree in treeControllers) {
      Map<String, String> treeData = {};
      for (var field in fields) {
        treeData[field] = tree[field]!.text.trim();
      }
      allTrees.add(treeData);
    }
    Map<String, String> timberReportheadlines = {
      "doner_details": new_sectionNumber,
      "PlaceOfCoupe": PlaceOfCoupe,
      "LetterNo": LetterNo,
      "Condition": Condition,
      "OfficerName": OfficerName,
      "OfficerPosition&name": OfficerPosition,
      "TreeCount": treeCount,
      "Date": Dateinforemed,
      "ARM_location": location,
    };

    try {
      await database.child('trees').child(new_sectionNumber).child("tree_details").set(allTrees);
      await database
          .child('trees')
          .child(new_sectionNumber)
          .child('timberReportheadlines')
          .set(timberReportheadlines);

      // Show SnackBar for feedback
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Saved to Firebase successfully!"),
          duration: Duration(seconds: 1),
        ),
      );

      // Wait a bit so user can see the message
      await Future.delayed(const Duration(milliseconds: 800));

      // Close review dialog
      Navigator.pop(context);

      // Close TreeQuesForm page (pop from root navigator, so correct page is closed)
      Navigator.of(context, rootNavigator: true).pop();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to save: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLast = currentIndex == widget.treeCount - 1;

    return Scaffold(
      backgroundColor: const Color(0xFFEBEDFA),
      body: SafeArea(
        child: Column(
          children: [
            // Progress bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                children: List.generate(widget.treeCount, (i) {
                  final filled = i <= currentIndex;
                  return Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      margin: EdgeInsets.only(
                        right: i == widget.treeCount - 1 ? 0 : 6,
                      ),
                      height: 10,
                      decoration: BoxDecoration(
                        color: filled
                            ? Colors.blueAccent
                            : Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tree ${currentIndex + 1} of ${widget.treeCount}",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5C50C5),
                  ),
                ),
              ),
            ),

            // Form Pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.treeCount,
                itemBuilder: (context, i) => _formCard(i),
              ),
            ),

            // Bottom actions
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  TextButton(
                    onPressed: _cancel,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.redAccent,
                    ),
                    child: const Text("Cancel"),
                  ),
                  const Spacer(),
                  if (currentIndex > 0) ...[
                    _AnimatedBoxButton(
                      icon: Icons.arrow_back,
                      onTap: _back,
                      colors: [Colors.lightBlueAccent, Colors.blueAccent],
                    ),
                    const SizedBox(width: 12),
                  ],
                  _AnimatedBoxButton(
                    icon: Icons.arrow_forward,
                    onTap: _next,
                    colors: isLast
                        ? [Colors.greenAccent, Colors.lightGreenAccent]
                        : [Colors.lightBlueAccent, Colors.blueAccent],
                    text: isLast ? "Save" : "Next",
                    reducedWidth: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formCard(int index) {
    final width = MediaQuery.of(context).size.width * 0.75;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: List.generate(fields.length, (i) {
          return Center(
            child: SizedBox(
              width: width,
              child: _FieldCard(
                label: fields[i],
                controller: treeControllers[index][fields[i]]!,
                delay: Duration(milliseconds: 120 * i),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Animated box button with gradient
class _AnimatedBoxButton extends StatefulWidget {
  final VoidCallback onTap;
  final IconData icon;
  final List<Color> colors;
  final String? text;
  final bool reducedWidth;

  const _AnimatedBoxButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.colors,
    this.text,
    this.reducedWidth = false,
  });

  @override
  State<_AnimatedBoxButton> createState() => _AnimatedBoxButtonState();
}

class _AnimatedBoxButtonState extends State<_AnimatedBoxButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          width: widget.reducedWidth ? 120 : null,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _hovered
                  ? widget.colors.reversed.toList()
                  : widget.colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.text != null) ...[
                Text(
                  widget.text!,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(width: 6),
              ],
              Icon(widget.icon, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

/// Field card without changing color, border, or showing error
class _FieldCard extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final Duration delay;

  const _FieldCard({
    super.key,
    required this.label,
    required this.controller,
    required this.delay,
  });

  @override
  State<_FieldCard> createState() => _FieldCardState();
}

class _FieldCardState extends State<_FieldCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offset;
  late Animation<double> _fade;

  bool _visible = false;
  bool _hovered = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _offset = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() => _visible = true);
        _controller.forward();
      }
    });
  }

  IconData _getIcon(String label) {
    switch (label) {
      case "ගස් වර්ගය":
        return Icons.nature;
      case "පංතිය":
        return Icons.category;
      case "සත්‍ය උස":
        return Icons.height;
      case "වාණීජමය උස":
        return Icons.align_vertical_bottom;
      case "පපු මට්ටමේ වට":
        return Icons.circle_outlined;
      case "පරිමාව":
        return Icons.straighten;
      case "වටිනාකම":
        return Icons.attach_money;
      case "වෙනත්":
        return Icons.notes;
      default:
        return Icons.text_fields;
    }
  }

  @override
  Widget build(BuildContext context) {
    final normalBlue = Color(0xFF4A90E2);

    return _visible
        ? FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _offset,
              child: MouseRegion(
                onEnter: (_) => setState(() => _hovered = true),
                onExit: (_) => setState(() => _hovered = false),
                child: GestureDetector(
                  onTap: () => _focusNode.requestFocus(),
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 250),
                    scale: _hovered ? 1.03 : 1.0,
                    curve: Curves.easeOut,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.white, Color(0xFFF4F0FF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: normalBlue.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _getIcon(widget.label),
                                  color: normalBlue,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                widget.label,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5C50C5),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            focusNode: _focusNode,
                            controller: widget.controller,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              hintText: "Enter ${widget.label}",
                              hintStyle: const TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
