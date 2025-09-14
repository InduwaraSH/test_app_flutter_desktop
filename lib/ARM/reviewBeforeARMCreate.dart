import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  final List<String> fields;
  final List<Map<String, TextEditingController>> treeControllers;
  final Function(int) onEdit;
  final VoidCallback onConfirm;
  final String treeCount;
  final String new_sectionNumber;
  final String PlaceOfCoupe;
  final String LetterNo;
  final String Condition;
  final String OfficerName;
  final String OfficerPosition;
  final String Dateinforemed;
  final String location;
  final String serialnum;
  final String dateinformed_from_rm;
  final String placeofcoupe;
  final String position;

  const ReviewPage({
    super.key,
    required this.fields,
    required this.treeControllers,
    required this.onEdit,
    required this.onConfirm,
    required this.location,
    required this.treeCount,
    required this.new_sectionNumber,
    required this.PlaceOfCoupe,
    required this.LetterNo,
    required this.Condition,
    required this.OfficerName,
    required this.OfficerPosition,
    required this.Dateinforemed,
    required this.serialnum,
    required this.dateinformed_from_rm,
    required this.placeofcoupe,
    required this.position,
  });

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  /// store hovered row for each tree separately
  final Map<int, int> _hoveredIndices = {};
  int _hoveredSummary = -1; // summary hover

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  IconData _getIconForField(String field) {
    if (field.contains("වර්ගය")) return Icons.person;
    if (field.contains("පරමිතිය")) return Icons.science;
    if (field.contains("උස")) return Icons.height;
    if (field.contains("මානමය උස")) return Icons.straighten;
    return Icons.notes;
  }

  Widget _buildSummaryCard() {
    final infoItems = [
      {
        "label": "Serial No                           :",
        "value": widget.serialnum,
      },
      {
        "label": "Date Informed               :",
        "value": widget.dateinformed_from_rm,
      },
      {"label": "Area of Coupe                :", "value": widget.placeofcoupe},
      {
        "label": "Position                            :",
        "value": widget.position,
      },
      {"label": "location_office              :", "value": widget.location},
      {
        "label": "Section No                       :",
        "value": widget.new_sectionNumber,
      },
      {"label": "Place of Coupe               :", "value": widget.PlaceOfCoupe},
      {
        "label": "Letter No                          :",
        "value": widget.LetterNo,
      },
      {
        "label": "Condition                        :",
        "value": widget.Condition,
      },
      {"label": "Officer Name                  :", "value": widget.OfficerName},
      {
        "label": "Officer Position             :",
        "value": widget.OfficerPosition,
      },
      {"label": "Date Informed               :", "value": widget.Dateinforemed},
      {"label": "Tree Count                     :", "value": widget.treeCount},
    ];

    return ScaleTransition(
      scale: Tween<double>(begin: 0.9, end: 1.0).animate(_animation),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.white, Color(0xFFF7F7FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: infoItems.asMap().entries.map((entry) {
            int index = entry.key;
            var item = entry.value;

            return MouseRegion(
              onEnter: (_) => setState(() => _hoveredSummary = index),
              onExit: (_) => setState(() => _hoveredSummary = -1),
              child: AnimatedScale(
                scale: _hoveredSummary == index ? 1.02 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(vertical: 6.0),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: _hoveredSummary == index
                        ? Colors.blueAccent.withOpacity(0.1)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: _hoveredSummary == index
                        ? [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.2),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          item["label"]!,
                          style: const TextStyle(
                            fontFamily: "abhayaLibre",
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Text(
                          item["value"]!,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontFamily: "AbhayaLibre",
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTreeCard(int treeIndex) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.9, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            (treeIndex / widget.treeControllers.length),
            1.0,
            curve: Curves.easeOutBack,
          ),
        ),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.white, Color(0xFFF7F7FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Tree ${treeIndex + 1} of ${widget.treeControllers.length}",
                    style: const TextStyle(
                      fontFamily: "sfproRoundSemiB",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => widget.onEdit(treeIndex),
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(Icons.edit, color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            ...widget.fields.asMap().entries.map((entry) {
              int fieldIndex = entry.key;
              String f = entry.value;
              final isHovered =
                  _hoveredIndices[treeIndex] != null &&
                  _hoveredIndices[treeIndex] == fieldIndex;

              return MouseRegion(
                onEnter: (_) =>
                    setState(() => _hoveredIndices[treeIndex] = fieldIndex),
                onExit: (_) => setState(() => _hoveredIndices[treeIndex] = -1),
                child: AnimatedScale(
                  scale: isHovered ? 1.02 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(vertical: 6.0),
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: isHovered
                          ? Colors.blueAccent.withOpacity(0.1)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: isHovered
                          ? [
                              BoxShadow(
                                color: Colors.blueAccent.withOpacity(0.2),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ]
                          : [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.08),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            _getIconForField(f),
                            color: Colors.black,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 3,
                          child: Text(
                            f,
                            style: const TextStyle(
                              fontFamily: "abhayaLibre",
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            widget.treeControllers[treeIndex][f]!.text.trim(),
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontFamily: "AbhayaLibre",
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showRoundDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // round corner
          ),
          content: const Text(
            "This is a rounded dialog box!",
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                "Please review the details before saving",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: "sfproRoundSemiB",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            _buildSummaryCard(),
            const SizedBox(height: 16),

            ...List.generate(widget.treeControllers.length, (index) {
              return _buildTreeCard(index);
            }),

            const SizedBox(height: 80),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          widget.onConfirm();
          _showRoundDialog(); // just demo, remove if not needed
        },
        label: const Text(
          "Save",
          style: TextStyle(
            fontSize: 18,
            fontFamily: "sfproRoundSemiB",
            color: Colors.white,
          ),
        ),
        splashColor: Colors.amber,
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
