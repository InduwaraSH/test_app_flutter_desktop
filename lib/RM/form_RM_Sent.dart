import 'package:flutter/cupertino.dart';
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

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFF3F2FD), // soft lavender background
            Color(0xFFE9E8FB),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SingleChildScrollView(
        child: Visibility(
          visible: rmSent.selected ?? true,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Print button row
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [_HoverPrintButton(), SizedBox(width: 20)],
                ),

                const SizedBox(height: 30),

                // Title
                Center(
                  child: Text(
                    "Enumeration And Wayside \n Deport Register For Donated Timber.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'DMSerif',
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(101, 89, 182, 1),
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                // From - To Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "From :   RM Branch in $location",
                        style: const TextStyle(
                          fontFamily: 'DMSerif',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(117, 106, 182, 1),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "To      :   ARM Branch in ${rmSent.arm_branch_name.toString()}",
                        style: const TextStyle(
                          fontFamily: 'DMSerif',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(117, 106, 182, 1),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // Focused Info Card
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(232, 230, 255, 0.5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color.fromRGBO(145, 142, 214, 0.8),
                      width: 1.8,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromRGBO(145, 142, 214, 0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _InfoRowTile(
                        label: "Serial No",
                        value: rmSent.s_num.toString(),
                      ),
                      _InfoRowTile(
                        label: "Place of Coupe",
                        value: rmSent.poc.toString(),
                      ),
                      _InfoRowTile(
                        label: "Letter No",
                        value: rmSent.letter_no.toString(),
                      ),
                      _InfoRowTile(
                        label: "Date informed",
                        value: rmSent.date_informed.toString(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Hoverable info row
class _InfoRowTile extends StatefulWidget {
  final String label;
  final String value;
  const _InfoRowTile({Key? key, required this.label, required this.value})
    : super(key: key);

  @override
  State<_InfoRowTile> createState() => _InfoRowTileState();
}

class _InfoRowTileState extends State<_InfoRowTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        tween: Tween(begin: 1.0, end: _hovered ? 1.02 : 1.0),
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: _hovered
                    ? const Color.fromRGBO(210, 206, 255, 0.6)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "${widget.label} :   ${widget.value}",
                style: const TextStyle(
                  color: Color.fromRGBO(74, 64, 134, 1),
                  fontFamily: 'RoboSerif',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
          );
        },
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
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        tween: Tween(begin: 1.0, end: _hovered ? 1.12 : 1.0),
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: _hovered
                      ? const [
                          Color.fromRGBO(125, 110, 210, 1),
                          Color.fromRGBO(160, 155, 230, 1),
                        ]
                      : const [
                          Color.fromRGBO(145, 142, 214, 1),
                          Color.fromRGBO(177, 175, 255, 1),
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(117, 106, 182, 0.35),
                    blurRadius: _hovered ? 18 : 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.local_print_shop_outlined,
                  color: Colors.white,
                  size: 24,
                ),
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
        },
      ),
    );
  }
}
