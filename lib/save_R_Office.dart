import 'package:firebase_database/firebase_database.dart';

class Register_RO_Office{

    DatabaseReference Register_RO_Office_ref = FirebaseDatabase.instance.ref().child("R_O_Office");



    Future<void> SaveData(String bID,String location) async {

       try {
           await Register_RO_Office_ref.child(bID).set({
               'branchID': bID,
               'branchLocation': location,
               
               
           });
           print('Data saved successfully');
       } catch (e) {
           print('Error saving data: $e');
       }
    }
}
