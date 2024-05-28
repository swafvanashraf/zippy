// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/viewmodel/providers/APIprovider.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:provider/provider.dart';

// class Authentication {
//   static Future<FirebaseApp> initializeFirebase() async {
//     FirebaseApp firebaseApp = await Firebase.initializeApp();

//     // TODO: Add auto login logic

//     return firebaseApp;
//   }

//   static Future<User?> signInWithGoogle({required BuildContext context}) async {
//     // Provider.of<APIprovider>(context, listen: false).isloading = true;
//     FirebaseAuth auth = FirebaseAuth.instance;
//     User? user;

//     final GoogleSignIn googleSignIn = GoogleSignIn();

//     final GoogleSignInAccount? googleSignInAccount =
//         await googleSignIn.signIn();

//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );

//       try {
//         final UserCredential userCredential =
//             await auth.signInWithCredential(credential);

//         user = userCredential.user;
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'account-exists-with-different-credential') {
//           ScaffoldMessenger.of(context).showSnackBar(
//             Authentication.customSnackBar(
//               content: 'The account already exists with a different credential',
//             ),
//           );
//         } else if (e.code == 'invalid-credential') {
//           ScaffoldMessenger.of(context).showSnackBar(
//             Authentication.customSnackBar(
//               content: 'Error occurred while accessing credentials. Try again.',
//             ),
//           );
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           Authentication.customSnackBar(
//             content: 'Error occurred using Google Sign In. Try again.',
//           ),
//         );
//       }
//     }
//     // Provider.of<APIprovider>(context, listen: false).isloading = false;
//     return user;
//   }

//   static SnackBar customSnackBar({required String content}) {
//     return SnackBar(
//       backgroundColor: Colors.black,
//       content: Text(
//         content,
//         style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
//       ),
//     );
//   }

//   static Future<void> signOut({required BuildContext context}) async {
//     final GoogleSignIn googleSignIn = GoogleSignIn();

//     try {
//       if (!kIsWeb) {
//         await googleSignIn.signOut();
//     }
//     await FirebaseAuth.instance.signOut();
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       Authentication.customSnackBar(
//         content: 'Error signing out. Try again.',
//       ),
//     );
//   }
// }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/screens/signin.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user != null;
    } catch (e) {
      print("Error signing in: $e");
      return false;
    }
  }

  /////////////////////////////////////////////////////////////////////////////////////////////

  Future<bool> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user != null;
    } catch (e) {
      print("Error signing up: $e");
      return false;
    }
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////

  void signOutWithEmail(context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to the sign-in page or any other page as needed.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => signin()),
      );
    } catch (e) {
      print("Error signing out with email/password: $e");
      // Handle sign-out error if needed.
    }
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////

  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    // TODO: Add auto login logic

    return firebaseApp;
  }

  Future<User?> signInWithGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        return userCredential.user;
      } catch (e) {
        print("Error signing in with Google: $e");
        return null;
      }
    }
    return null;
  }

  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        AuthenticationProvider.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }

///////////////////////////////////////////////////////////////////////////////////////////////////

 static Future<User?> signUpWithGoogle(BuildContext context) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Prompt the user to select a Google account
  final GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();

  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    try {
      // Sign out any existing user
      await _auth.signOut();

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Check if the user is new (created during sign-up) or existing
      if (userCredential.additionalUserInfo!.isNewUser ?? false) {
        // New user, perform sign-up logic here (e.g., storing user data)
        // You can navigate to a sign-up screen to collect additional user information if needed
      } else {
        // Existing user, handle it accordingly (e.g., show a message indicating that the account already exists)
        ScaffoldMessenger.of(context).showSnackBar(
          AuthenticationProvider.customSnackBar(
            content: 'The account already exists.',
          ),
        );
      }

      return userCredential.user;
    } catch (e) {
      print("Error signing up with Google: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        AuthenticationProvider.customSnackBar(
          content: 'Error occurred during sign-up. Please try again.',
        ),
      );
      return null;
    }
  }
  return null;
}
}
