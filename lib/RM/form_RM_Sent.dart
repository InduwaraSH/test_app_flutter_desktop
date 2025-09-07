import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/ARM_SelectProvider.dart';
import 'package:test_code/RM_sent_provide.dart';
import 'package:test_code/pdf.dart';

class Sent_Form_RM_new extends StatefulWidget {
  final String location;
  final String position;
  const Sent_Form_RM_new({
    super.key,
    required this.location,
    required this.position,
  });

  @override
  State<Sent_Form_RM_new> createState() => _Sent_Form_RMState();
}

class _Sent_Form_RMState extends State<Sent_Form_RM_new> {
  String? savedValue;
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

    provider.addListener(() {
      if (mounted) {
        setState(() {
          savedValue = provider.selected;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final rmSent = Provider.of<RM_Sent>(context);

    // Collect data cards
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

    return Scaffold(
      backgroundColor: const Color(0xFFF4F2FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Visibility(
            visible: rmSent.selected ?? true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [Spacer(), _HoverPrintButton()],
                ),
                const SizedBox(height: 20),
                Text(
                  "TO : ARM Branch in ${rmSent.arm_branch_name.toString()}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                Text(
                  "From : RM Branch in $location",
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
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
                  child: Center(
                    child: Text(
                      "Enumeration And Wayside Deport Register\nFor Donated Timber",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25,
                        fontFamily: "DMSerif",
                        fontWeight: FontWeight.w800,
                        color: Color.fromARGB(255, 45, 39, 169),
                      ),
                    ),
                  ),
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
                      delay: Duration(
                        milliseconds: 150 * index,
                      ), // stagger effect
                    );
                  }),
                ),
              ],
            ),
          ),
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
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -0.8),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    // Trigger the animation with delay
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
    // if (oldWidget.value != widget.value) {
    //   // Reset visibility for new data

    // }
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

/// Hoverable print button
class _HoverPrintButton extends StatefulWidget {
  const _HoverPrintButton({Key? key}) : super(key: key);

  @override
  State<_HoverPrintButton> createState() => _HoverPrintButtonState();
}

class _HoverPrintButtonState extends State<_HoverPrintButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final rmSent = Provider.of<RM_Sent>(context, listen: false);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: _hovered
                ? [const Color(0xFF6C63FF), const Color(0xFF928DFF)]
                : [const Color(0xFF928DFF), const Color(0xFFB8B5FF)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: _hovered ? 16 : 8,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: IconButton(
          icon: const Icon(Icons.print_outlined, color: Colors.white, size: 24),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PdfStyledPage(
                  rmSent.s_num.toString(),
                  rmSent.poc.toString(),
                  rmSent.letter_no.toString(),
                  rmSent.date_informed.toString(),
                ),
              ),
            );
          },
          tooltip: 'Print',
        ),
      ),
    );
  }
}
