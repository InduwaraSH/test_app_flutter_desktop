import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/ARM/middle_ARM_Recived.dart';
import 'package:test_code/Home_RM.dart';
import 'package:test_code/RM_sent_provide.dart';
import 'package:test_code/middle_RM.dart';
import 'package:test_code/middle_RM_Create.dart';
import 'package:test_code/middle_RM_Recived.dart';
import 'package:test_code/middle_RM_Send.dart';
import 'package:test_code/selected_provider.dart';

class ARM_Middle extends StatefulWidget {
  final String location;
  final String position;
  const ARM_Middle({super.key, required this.location, required this.position});

  @override
  State<ARM_Middle> createState() => _ARM_MiddleState();
}

class _ARM_MiddleState extends State<ARM_Middle> {
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
        "Recived") {
      Provider.of<RM_Sent>(context, listen: false).setSelected(false);
      return middle_ARM_create(location: location, position: position);
    } else if (Provider.of<SelectionProvider>(context).selected.toString() ==
        "Authorized") {
      Provider.of<RM_Sent>(context, listen: false).setSelected(false);
      return middle_RM_Recived(location: location, position: position);
    } else {
      return Text("Error");
    }
  }
}
