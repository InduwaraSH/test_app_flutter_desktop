import 'package:firebase_auth/firebase_auth.dart';

class Login {
  late final credential;
  Future<void> signIn(String employeeId, String password) async {
    print("Trying to sign in with: $employeeId / $password");

    try {
      // await FirebaseAuth.instance.setPersistence(Persistence.NONE);

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: employeeId.trim(),
        password: password.trim(),
      );

      print("✅ Login successful for: ${credential.user?.email}");
    } on FirebaseAuthException catch (e) {
      print("❌ FirebaseAuthException: ${e.code}");
      // print("❌ FirebaseAuthException: ${credential.user?.email}");
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print("❌ Unexpected error: $e");
    }
  }
}
