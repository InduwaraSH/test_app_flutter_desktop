import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/Home_RM.dart';
import 'package:test_code/form_RM.dart';
import 'package:test_code/middle_RM.dart';
import 'package:test_code/middle_RM_Create.dart';
import 'package:test_code/middle_RM_Recived.dart';
import 'package:test_code/selected_provider.dart';

class DetailPanel extends StatefulWidget {
  final String location;
  final String position;
  const DetailPanel({
    super.key,
    required this.location,
    required this.position,
  });

  @override
  State<DetailPanel> createState() => _DetailPanelState();
}

class _DetailPanelState extends State<DetailPanel> {
  late String location;
  late String position;
  String _selected = "";

  @override
  void initState() {
    super.initState();
    location = widget.location;
    position = widget.position;
  }

  @override
  Widget build(BuildContext context) {

    if (Provider.of<SelectionProvider>(context).selected.toString() ==
        "CREATE") {
      return form_RM(location: location, position: position);
    } else if (Provider.of<SelectionProvider>(context).selected.toString() ==
        "RECIVED") {
      return middle_RM_Recived(location: location, position: position);
    } else if (Provider.of<SelectionProvider>(context).selected.toString() ==
        "SEND") {
      return middle_RM_create(location: location, position: position);
    } else {
      return Text("Error");
    }

  }
}
