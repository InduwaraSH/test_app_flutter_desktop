import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/Home_RM.dart';
import 'package:test_code/RM/middle_RM_Create_New.dart';
import 'package:test_code/RM_sent_provide.dart';
import 'package:test_code/middle_RM.dart';
import 'package:test_code/middle_RM_Create.dart';
import 'package:test_code/middle_RM_Recived.dart';
import 'package:test_code/middle_RM_Send.dart';
import 'package:test_code/selected_provider.dart';

class RM_Middle extends StatefulWidget {
  final String location;
  final String position;
  const RM_Middle({super.key, required this.location, required this.position});

  @override
  State<RM_Middle> createState() => _RM_MiddleState();
}

class _RM_MiddleState extends State<RM_Middle> {
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
      Provider.of<RM_Sent>(context, listen: false).setSelected(false);
      return middle_RM_create_new(location: location, position: position);
    } else if (Provider.of<SelectionProvider>(context).selected.toString() ==
        "RECIVED") {
      Provider.of<RM_Sent>(context, listen: false).setSelected(false);
      return middle_RM_Recived(location: location, position: position);
    } else if (Provider.of<SelectionProvider>(context).selected.toString() ==
        "SEND") {
      return middle_RM_Send_new(location: location, position: position);
    } else {
      return Text("Error");
    }
  }
}
