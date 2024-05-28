

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/commun_widgets.dart';
import 'package:flutter_application_1/utils/const.dart';
import 'package:flutter_application_1/utils/lists.dart';
import 'package:flutter_application_1/view/screens/signin.dart';
import 'package:flutter_application_1/viewmodel/providers/authProvider.dart';
import 'package:provider/provider.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(
              height: height * .07,
            ),
            Row(
              children: [
                logo(),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Profile',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                ),
              ],
            ),
            SizedBox(
              height: height * .035,
            ),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  height: height * .2,
                  width: width * .42,
                  child: CircleAvatar(
                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL!)
                        : null,
                  ),
                ),
                Positioned(
                  bottom: 13,
                  right: 13,
                  child: Container(
                    height: height * .03,
                    width: width * .06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 17,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Text(
                user?.displayName ?? 'Guest',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(),
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        index != 5
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => pages[index]))
                            : dialogeBox(context, height, width);
                      },
                      child: Container(
                        height: height * .05,
                        width: width * .1,
                        child: Row(
                          children: [
                            icons[index],
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              profileNames[index],
                              style: TextStyle(
                                  color:
                                      index == 5 ? Colors.red : Colors.black),
                            ),
                            Spacer(),
                            if (index != 5)
                              Icon(
                                Icons.arrow_forward_ios_sharp,
                              )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<dynamic> dialogeBox(context, height, double width) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          surfaceTintColor: primaryColor,
          title: Center(
              child: Text(
            'Logout',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.red),
          )),
          content: Container(
            height: height / 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Are you sure you want to log out?'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: height * .05,
                      width: width * .28,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromARGB(255, 197, 197, 197)),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Dismiss the dialog
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Container(
                      height: height * .05,
                      width: width * .28,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.black),
                      child: TextButton(
                        onPressed: () async {
                          // await Authentication.signOut(context: context);
                          Provider.of<AuthenticationProvider>(context,listen: false)
                              .signOutWithEmail(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => signin()));
                        },
                        child: Text(
                          'Yes, Logout',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ));
    },
  );
}
