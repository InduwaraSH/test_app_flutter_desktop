import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/ARM/form_ARM_Create.dart';
import 'package:test_code/ARM_SelectProvider.dart';
import 'package:test_code/RM_sent_provide.dart';
import 'package:flutter/cupertino.dart';

class form_ARM_Recived extends StatefulWidget {
  final String location;
  final String position;
  const form_ARM_Recived({
    super.key,
    required this.location,
    required this.position,
  });

  @override
  State<form_ARM_Recived> createState() => _form_ARM_RecivedState();
}

class _form_ARM_RecivedState extends State<form_ARM_Recived> {
  String? savedValue;
  late String location;
  late String position;

  // We track a "version" to force bottom section to reanimate
  int updateVersion = 0;

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

    provider.addListener(() {
      if (mounted) {
        setState(() {
          savedValue = provider.selected;
          updateVersion++; // increment to notify bottom section to reanimate
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final rmSent = Provider.of<RM_Sent>(context);

    final cardData = [
      {
        "icon": Icons.confirmation_number_outlined,
        "label": "Serial No",
        "value": rmSent.s_num.toString(),
      },
      {
        "icon": Icons.place_outlined,
        "label": "Place of Coupe",
        "value": rmSent.poc.toString(),
      },
      {
        "icon": Icons.numbers_outlined,
        "label": "Letter No",
        "value": rmSent.letter_no.toString(),
      },
      {
        "icon": Icons.date_range_outlined,
        "label": "Date informed",
        "value": rmSent.date_informed.toString(),
      },
    ];

    return SingleChildScrollView(
      child: Visibility(
        visible: rmSent.selected ?? true,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white, const Color(0xFFF1EEFF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Text(
                    "Enumeration And Wayside Deport Register\nFor Donated Timber",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontFamily: "DMSerif",
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 45, 39, 169),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Text(
                    "From : RM Branch in $location",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "To : ARM Branch in $location",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              /// Animated cards section
              Column(
                children: List.generate(cardData.length, (index) {
                  final data = cardData[index];
                  return _SequentialDropCard(
                    icon: data["icon"] as IconData,
                    label: data["label"] as String,
                    value: data["value"] as String,
                    delay: Duration(milliseconds: 150 * index),
                  );
                }),
              ),

              const SizedBox(height: 50),

              /// Divider + Form that slides up from bottom with delay on top updates
              _AnimatedFallingSection(
                key: ValueKey(
                  updateVersion,
                ), // forces rebuild on top card update
                location: location,
                position: position,
                delay: Duration(milliseconds: 150 * cardData.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Bottom section slides UP from bottom with delay on top card updates
class _AnimatedFallingSection extends StatefulWidget {
  final String location;
  final String position;
  final Duration delay;

  const _AnimatedFallingSection({
    Key? key,
    required this.location,
    required this.position,
    required this.delay,
  }) : super(key: key);

  @override
  State<_AnimatedFallingSection> createState() =>
      _AnimatedFallingSectionState();
}

class _AnimatedFallingSectionState extends State<_AnimatedFallingSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _fall;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fall = Tween<Offset>(
      begin: const Offset(0, 0.1), // from bottom
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart));

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // Start animation after specified delay
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void didUpdateWidget(covariant _AnimatedFallingSection oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Reset and restart animation after delay every update
    _controller.reset();
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _fall,
        child: Column(
          children: [
            Divider(thickness: 2, color: Colors.deepPurple.shade100),
            const SizedBox(height: 20),
            form_ARM_Create(
              location: widget.location,
              position: widget.position,
            ),
          ],
        ),
      ),
    );
  }
}

/// Card that drops sequentially with delay
class _SequentialDropCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final Duration delay;

  const _SequentialDropCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    required this.delay,
  }) : super(key: key);

  @override
  State<_SequentialDropCard> createState() => _SequentialDropCardState();
}

class _SequentialDropCardState extends State<_SequentialDropCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() => _visible = true);
        _controller.forward();
      }
    });
  }

  @override
  void didUpdateWidget(covariant _SequentialDropCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.reset();
    setState(() => _visible = false);
    Future.delayed(widget.delay, () {
      if (mounted) {
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
    return _visible
        ? SlideTransition(
            position: _offsetAnimation,
            child: _DataCard(
              icon: widget.icon,
              label: widget.label,
              value: widget.value,
            ),
          )
        : const SizedBox.shrink();
  }
}

/// Data card with hover effect
class _DataCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DataCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  State<_DataCard> createState() => _DataCardState();
}

class _DataCardState extends State<_DataCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, const Color(0xFFF4F0FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: const Color(0xFFEAE6FF),
                child: Icon(
                  widget.icon,
                  color: const Color(0xFF5C50C5),
                  size: 26,
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.value,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: "AbhayaLibre",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
