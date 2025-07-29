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
    Color PrimaryTextColour = Colors.white;
    Color SecondaryTextColour = Colors.white;

    if (Provider.of<SelectionProvider>(context).selected == "Recived") {
      colour_picked = Theme.of(context).colorScheme.onSecondaryContainer;
      PrimaryTextColour = Theme.of(context).colorScheme.onSecondaryFixed;
      ;

      SecondaryTextColour = Theme.of(
        context,
      ).colorScheme.onSecondaryFixedVariant;
      ;
    } else if (Provider.of<SelectionProvider>(context).selected ==
        "Authorized") {
      colour_picked = Theme.of(context).colorScheme.onPrimaryContainer;
      PrimaryTextColour = Theme.of(context).colorScheme.onPrimaryFixed;
      ;

      SecondaryTextColour = Theme.of(context).colorScheme.onPrimaryFixedVariant;
      ;
    } else if (Provider.of<SelectionProvider>(context).selected == "Rejected") {
      colour_picked = Theme.of(context).colorScheme.onSurface;
      PrimaryTextColour = Theme.of(context).colorScheme.onSurfaceVariant;
      ;

      SecondaryTextColour = Theme.of(context).colorScheme.onTertiary;
      ;
    } else {}

    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 5, bottom: 10, left: 15, right: 15),
      width: (MediaQuery.of(context).size.width - 330) * 0.20,
      height: 150,
      decoration: BoxDecoration(
        color: colour_picked,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Alerts['District'],
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'sfpro',
                  color: PrimaryTextColour,
                ),
              ),

              Icon(
                Icons.info_outline_rounded,
                color: PrimaryTextColour,
                size: 25,
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            "Danger Level : " + Alerts['Danger Level'],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'sfpro',
              color: SecondaryTextColour,
            ),
            // or ellipsis if you want cut-off
          ),
          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.forest, color: PrimaryTextColour, size: 20),
                  SizedBox(width: 5),
                  Text(
                    Alerts['Tree Name'],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'sfpro',
                      color: PrimaryTextColour,
                    ),
                  ),
                  SizedBox(width: 15),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.height_rounded,
                    color: PrimaryTextColour,
                    size: 20,
                  ),

                  Text(
                    Alerts['Height of Tree'],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'sfpro',
                      color: PrimaryTextColour,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 40, top: 10),
            padding: EdgeInsets.only(bottom: 10, top: 10),
            width: (MediaQuery.of(context).size.width - 100) * 0.25,
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(26),
            ),
            child: FirebaseAnimatedList(
              // Let outer scroll handle
              reverse: false,
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
