import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:test_code/Home.dart';
import 'package:test_code/Home_ARM.dart';
import 'package:test_code/Home_RM.dart';
import 'package:test_code/firstpage.dart';

class Login {
  late final credential;
  Future<void> signIn(
    String employeeId,
    String password,
    BuildContext context,
  ) async {
    bool result = await InternetConnection().hasInternetAccess;

    if (result == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No internet connection',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'sfpro',
              fontWeight: FontWeight.bold,
            ),
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.grey,
        ),
      );

      return;
    } else if (employeeId.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill all fields correctly.',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'sfpro',
              fontWeight: FontWeight.bold,
            ),
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: '${employeeId.trim()}@gmail.com',
              password: password.trim(),
            );
        DatabaseReference dbref = FirebaseDatabase.instance
            .ref()
            .child("employee_data_saved")
            .child(employeeId);

        final snapshot = await dbref.child('employeePosition').get();

        final snapshot_office = await dbref.child('employeeOffice').get();
        if (snapshot.exists) {
          if (snapshot.value == 'RM') {
            String position = "RM_branch_data_saved";
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Home_RM(location: snapshot_office.value.toString(), position: position),
              ),
            );
          } else if (snapshot.value == 'ARM') {
            String position = "ARM_branch_data_saved";
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Home_ARM(location: snapshot_office.value.toString(), position: position),
              ),
            );
          } else if (snapshot.value == 'EMP') {
            String position = "EMP_branch_data_saved";
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Homepg(location: snapshot_office.value.toString(), position: position),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Something went wrong',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'sfpro',
                  fontWeight: FontWeight.bold,
                ),
              ),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.red,
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        print("FirebaseAuthException: ${e.code}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.code,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'sfpro',
                fontWeight: FontWeight.bold,
              ),
            ),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red,
          ),
        );
        // print("FirebaseAuthException: ${credential.user?.email}");
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'No user found for that email.',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'sfpro',
                  fontWeight: FontWeight.bold,
                ),
              ),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.red,
            ),
          );
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Wrong password provided for that user.',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'sfpro',
                  fontWeight: FontWeight.bold,
                ),
              ),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        print("Unexpected error: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Unexpected error: $e",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'sfpro',
                fontWeight: FontWeight.bold,
              ),
            ),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
