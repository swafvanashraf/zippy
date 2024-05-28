

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/screens/ForgottPass.dart';
import 'package:flutter_application_1/view/screens/bottomNavigationbar.dart';
import 'package:flutter_application_1/view/screens/signup.dart';
import 'package:flutter_application_1/viewmodel/providers/authProvider.dart';

class signin extends StatefulWidget {
  const signin({super.key});

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  bool _obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * .15,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Image.asset(
                    'asset/logo.png',
                    width: 150, // Adjust the width as needed
                    height: 100, // Adjust the height as needed
                    fit: BoxFit.cover, // Adjust the fit as needed
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                Text(
                  'Login to Your Account',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: height * .04,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.mail,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 233, 233, 233),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 0, 0, 0)), // Change border color
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                TextFormField(
                  obscureText: _obscureText,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 233, 233, 233),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 0, 0, 0)), // Change border color
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .05,
                ),
                GestureDetector(
                  onTap: () {
                    _signIn(context);
                  },
                  child: Container(
                    height: height * .07,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(27),
                        color: Colors.black),
                    child: Center(
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .01,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen()));
                    },
                    child: Text(
                      'Forgott the password?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    )),
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1.0,
                        color: const Color.fromARGB(255, 207, 207, 207),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'or continue with',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 1.0,
                        color: const Color.fromARGB(255, 207, 207, 207),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * .04,
                ),
                GestureDetector(
                  onTap: () async {
                    User? user = await AuthenticationProvider()
                        .signInWithGoogle(context);

                    if (user != null) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => bottumNavigationbar()));
                    }
                  },
                  child: Container(
                    height: height * .06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'asset/google.png',
                          ),
                        ),
                        Text('Continue with google'),
                        SizedBox(
                          width: 15,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup()));
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn(BuildContext context) {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    AuthenticationProvider authProvider = AuthenticationProvider();
    authProvider.signIn(email, password).then((result) {
      if (result == true) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    bottumNavigationbar())); // Navigate to the home screen or another authenticated screen
      } else {
        // Show error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid email or password. Please try again.'),
          ),
        );
      }
    });
  }
}
