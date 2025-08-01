import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Picker extends StatefulWidget {
  final TextEditingController controller; 
  const Picker({super.key, required this.controller});

  @override
  State<Picker> createState() => _PickerState();
}

class _PickerState extends State<Picker> {



  int _selectedTown = 0;
  int _selectedTown_Drop = 0;
  static const double _kItemExtent = 32.0;
  static const List<String> _townName = <String>[
    'Maharagama',
    'Embilipitya',
    'Matara',
    'Galle',
    'Colombo',
    'Trinco',
    'Walasmulla',
    'Negambo',
  ];

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(top: false, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Expanded(
            child: DefaultTextStyle(
              style: TextStyle(
                color: CupertinoColors.label.resolveFrom(context),
                fontSize: 22.0,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        // Display a CupertinoPicker with list of Stands.
                        onPressed: () => _showDialog(
                          CupertinoPicker(
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: _kItemExtent,
                            // This sets the initial item.
                            scrollController: FixedExtentScrollController(
                              initialItem: _selectedTown,
                            ),
                            // This is called when selected item is changed.
                            onSelectedItemChanged: (int selectedItem) {
                              setState(() {
                                _selectedTown = selectedItem;
                                widget.controller.text = _townName[selectedItem];
                              });
                            },
                            children: List<Widget>.generate(_townName.length, (
                              int index,
                            ) {
                              return Center(child: Text(_townName[index]));
                            }),
                          ),
                        ),
                        // This displays the selected fruit name.
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Container(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            padding: EdgeInsets.only(
                              left: 20.0,
                              right: 20.0,
                              top: 5.0,
                              bottom: 5.0,
                            ),
                            child: Text(
                              _townName[_selectedTown],
                              
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
