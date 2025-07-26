import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_code/selected_provider.dart';

class alerts extends StatefulWidget {
  const alerts({super.key});

  @override
  State<alerts> createState() => _homeState();
}

class _homeState extends State<alerts> {
  Query dbref_alerts = FirebaseDatabase.instance.ref().child("tree details");

  Widget listItem({required Map Alerts}) {
    final String ageOfTree = Alerts['Age of Tree'];
    final String cirOfTree = Alerts['Circumference of Tree'];
    final String district = Alerts['District'];
    final String heightOfTree = Alerts['Height of Tree'];
    final String nameOftree = Alerts['Tree Name'];
    final String dangerLevel = Alerts['Danger Level'];

    Color colour_picked = Colors.pinkAccent;

    if (Provider.of<SelectionProvider>(context).selected == "Rejected") {
      colour_picked = Theme.of(context).colorScheme.onPrimary;
    } else if (Provider.of<SelectionProvider>(context).selected ==
        "Authorized") {
      colour_picked = Theme.of(context).colorScheme.onSecondary;
    } else if (Provider.of<SelectionProvider>(context).selected == "Recived") {
      colour_picked = const Color.fromARGB(255, 251, 33, 33);
    } else {}

    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      width: (MediaQuery.of(context).size.width - 330) * 0.25,
      height: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.notifications, color: colour_picked, size: 25),
              SizedBox(width: 2),
              Text(
                Alerts['Tree Name'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'sfpro',
                  color: colour_picked,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            Alerts['District'],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'sfpro',
              color: const Color.fromARGB(255, 107, 107, 107),
            ),
            // or ellipsis if you want cut-off
          ),
          SizedBox(width: 2),
          Text(
            Alerts['Height of Tree'],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'sfpro',
              color: colour_picked,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20, top: 10),
            padding: EdgeInsets.only(bottom: 30),
            width: (MediaQuery.of(context).size.width - 100) * 0.25,
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(26),
            ),
            child: FirebaseAnimatedList(
              shrinkWrap: true, // Important!
              physics:
                  NeverScrollableScrollPhysics(), // Let outer scroll handle
              reverse: true,
              query: dbref_alerts,
              itemBuilder:
                  (
                    BuildContext context,
                    DataSnapshot datasnapshot,
                    Animation<double> animation,
                    int index,
                  ) {
                    Map alerts = datasnapshot.value as Map;
                    alerts['key'] = datasnapshot.key;
                    return listItem(Alerts: alerts);
                  },
            ),
          ),
        ],
      ),
    );
  }
}
