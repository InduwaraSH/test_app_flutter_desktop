import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  final List<String> fields;
  final List<Map<String, TextEditingController>> treeControllers;
  final Function(int) onEdit;
  final VoidCallback onConfirm;

  const ReviewPage({
    super.key,
    required this.fields,
    required this.treeControllers,
    required this.onEdit,
    required this.onConfirm,
  });

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

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
    if (field.contains("වර්ගය")) return Icons.person; // example: name
    if (field.contains("පරමිතිය")) return Icons.science; // science/chemistry
    if (field.contains("උස")) return Icons.height; // height
    if (field.contains("මානමය උස")) return Icons.straighten; // measurement
    return Icons.notes;
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Column(
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Please review the details before saving",
              style: const TextStyle(
                fontSize: 25,
                fontFamily: "sfproRoundSemiB",
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          // Tree list with smooth scroll
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              itemCount: widget.treeControllers.length,
              itemBuilder: (context, index) {
                return ScaleTransition(
                  scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: Interval(
                        (index / widget.treeControllers.length),
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
                        // Tree title
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
                                "Tree ${index + 1} of ${widget.treeControllers.length}",
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
                              onTap: () => widget.onEdit(index),
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Field values
                        ...widget.fields.map((f) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                // Icon
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.08),
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(
                                    _getIconForField(f),
                                    color: Colors.black,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 12),

                                // Field name
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    f,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),

                                // Field value
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    widget.treeControllers[index][f]!.text
                                        .trim(),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontFamily: "AbhayaLibre",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text("Cancel"),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: widget.onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 3,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
