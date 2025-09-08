import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/ARM_SelectProvider.dart';
import 'package:test_code/dateTime.dart';
import 'package:test_code/send_button.dart';

/// Removes default glow effect when scrolling
class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}

class form_ARM_Create extends StatefulWidget {
  final String location;
  final String position;
  const form_ARM_Create({
    super.key,
    required this.location,
    required this.position,
  });

  @override
  State<form_ARM_Create> createState() => _form_ARM_CreateState();
}

class _form_ARM_CreateState extends State<form_ARM_Create> {
  final SerialNumberController = TextEditingController();
  final PlaceOfCoupeController = TextEditingController();
  final LetterNoController = TextEditingController();
  final ConditionController = TextEditingController();
  final OfficerNameController = TextEditingController();
  final OfficerPositionController = TextEditingController();
  final DateinforemedController = TextEditingController();
  final TreeCountController = TextEditingController();

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
      setState(() {
        savedValue = provider.selected;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final fields = [
      {
        "label": "දැව භාරදුන් ආයතනය හා කොට්ඨාසය",
        "controller": SerialNumberController,
        "placeholder": "Enter Institution & Section",
        "icon": Icons.account_balance_outlined,
      },
      {
        "label": "දැව භාරදුන් ආයතනයේ ලිපි අංකය හා දිනය",
        "controller": PlaceOfCoupeController,
        "placeholder": "Enter Letter No & Date",
        "icon": Icons.note_alt_outlined,
      },
      {
        "label": "දැව ඇති ස්ථානය",
        "controller": LetterNoController,
        "placeholder": "Enter Location",
        "icon": Icons.place_outlined,
      },
      {
        "label": "දැව පවතින ස්වභාවය",
        "controller": ConditionController,
        "placeholder": "Enter Condition",
        "icon": Icons.info_outline,
      },
      {
        "label": "පරික්ෂා කල නිලධාරියාගේ නම",
        "controller": OfficerNameController,
        "placeholder": "Enter Officer Name",
        "icon": Icons.person_outline,
      },
      {
        "label": "පරික්ෂා කල නිලධාරියාගේ තනතුර",
        "controller": OfficerPositionController,
        "placeholder": "Enter Officer Position",
        "icon": Icons.badge_outlined,
      },
      {
        "label": "පරික්ෂා කල දිනය",
        "controller": DateinforemedController,
        "isDate": true,
        "icon": Icons.date_range_outlined,
      },
      {
        "label": "ගස් ගණන",
        "controller": TreeCountController,
        "placeholder": "Enter Tree Count",
        "icon": Icons.forest_outlined,
      },
    ];

    return ScrollConfiguration(
      behavior: NoGlowBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "From : RM Branch in $location",
                        style: const TextStyle(
                          fontFamily: 'DMSerif',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(92, 112, 202, 1),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "To : ARM Branch in ${Provider.of<ARM_Selection_provider>(context).selected.toString()}",
                        style: const TextStyle(
                          fontFamily: 'DMSerif',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(92, 112, 202, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                SendButton_animated(
                  SerialNumberController,
                  PlaceOfCoupeController,
                  LetterNoController,
                  DateinforemedController,
                  position,
                  location,
                ),
              ],
            ),
            const SizedBox(height: 30),

            /// Animated Fields as Cards
            Column(
              children: List.generate(fields.length, (index) {
                final data = fields[index];
                return _SequentialDropCardField(
                  label: data["label"] as String,
                  controller: data["controller"] as TextEditingController,
                  placeholder: data["placeholder"]?.toString(),
                  delay: Duration(milliseconds: 180 * index),
                  isDate: data["isDate"] == true,
                  icon: data["icon"] as IconData?,
                  onDateChanged: (date) {
                    setState(() {
                      DateinforemedController.text = date.toString();
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

/// Sequential drop animation for input fields (from bottom → top + fade)
class _SequentialDropCardField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? placeholder;
  final Duration delay;
  final bool isDate;
  final Function(DateTime)? onDateChanged;
  final IconData? icon;

  const _SequentialDropCardField({
    Key? key,
    required this.label,
    required this.controller,
    this.placeholder,
    required this.delay,
    this.isDate = false,
    this.onDateChanged,
    this.icon,
  }) : super(key: key);

  @override
  State<_SequentialDropCardField> createState() =>
      _SequentialDropCardFieldState();
}

class _SequentialDropCardFieldState extends State<_SequentialDropCardField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;

  bool _visible = false;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.6), // drop from bottom to top
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

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

  Widget _buildCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
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
      child: Row(
        children: [
          if (widget.icon != null)
            CircleAvatar(
              radius: 24,
              backgroundColor: const Color(0xFFEAE6FF),
              child: Icon(
                widget.icon,
                color: const Color(0xFF5C50C5),
                size: 26,
              ),
            ),
          if (widget.icon != null) const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: "AbhayaLibre",
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                widget.isDate
                    ? SimpleDatePicker(
                        initialDate: DateTime.now(),
                        onDateChanged: widget.onDateChanged!,
                      )
                    : TextField(
                        controller: widget.controller,
                        decoration: InputDecoration(
                          hintText: widget.placeholder ?? "",
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontSize: 18,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return _visible
        ? FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _offsetAnimation,
              child: MouseRegion(
                onEnter: (_) => setState(() => _hovered = true),
                onExit: (_) => setState(() => _hovered = false),
                child: AnimatedScale(
                  scale: _hovered ? 1.02 : 1.0,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  child: _buildCard(context),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
