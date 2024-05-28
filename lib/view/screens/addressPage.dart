import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/commun_widgets.dart';
import 'package:flutter_application_1/utils/const.dart';
import 'package:flutter_application_1/view/screens/checkoutPage.dart';
import 'package:flutter_application_1/viewmodel/providers/checkOutProvider.dart';
import 'package:provider/provider.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController apt = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController zipCode = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  saveAddress() {
    final user = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);

    {
      final data = {
        'firstName': firstName.text,
        'lastName': lastName.text,
        'phoneNumber': phoneNumber.text,
        'E-mail': mail.text,
        'street': street.text,
        'apt': apt.text,
        'addressType': selectedOption,
        'city': city.text,
        'state': state.text,
        'zipCode': zipCode.text,
      };

      user.update(data);
    }
    showToast('Address updated');
  }

  String selectedOption = 'Home';
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 222, 222, 222),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => checkout()));
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Shipping Address',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * .05,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter the first name';
                          }

                          return null;
                        },
                        controller: firstName,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 241, 241, 241),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          // errorStyle: TextStyle(
                          //   color: Colors.red,
                          //   fontSize: 14,
                          //   fontStyle: FontStyle.italic,
                          // ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          contentPadding: EdgeInsets.only(left: 10, bottom: 6),
                          hintText: 'First name',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width / 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter the last name';
                          }

                          return null;
                        },
                        controller: lastName,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 241, 241, 241),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          contentPadding: EdgeInsets.only(left: 10, bottom: 6),
                          hintText: 'Last name',
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your phone number';
                      }

                      return null;
                    },
                    controller: phoneNumber,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 241, 241, 241),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      contentPadding: EdgeInsets.only(left: 10, bottom: 6),
                      hintText: 'Phone number',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the E-mail';
                      }

                      return null;
                    },
                    controller: mail,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 241, 241, 241),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      contentPadding: EdgeInsets.only(left: 10, bottom: 6),
                      hintText: 'E-mail',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, bottom: 5),
                  child: Text(
                    'Address',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your address';
                    }

                    return null;
                  },
                  controller: street,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 241, 241, 241),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    contentPadding: EdgeInsets.only(left: 10, bottom: 6),
                    hintText: 'Street address or P.O.Box',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 4),
                  child: TextField(
                    controller: apt,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 241, 241, 241),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      contentPadding: EdgeInsets.only(left: 10, bottom: 6),
                      hintText: 'Apt, Suite, Building (Optional)',
                    ),
                  ),
                ),
                Container(
                  height: height * .06,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 241, 241, 241),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: DropdownButton<String>(
                      value: selectedOption,
                      items: [
                        'Home',
                        'Office',
                        'Business',
                        'Vacation Home',
                        'Temporary',
                        'Worksite',
                        'School',
                        'Hospital',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                color: Color.fromARGB(255, 94, 94, 94)),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedOption = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your city';
                    }

                    return null;
                  },
                  controller: city,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 241, 241, 241),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    contentPadding: EdgeInsets.only(left: 10, bottom: 6),
                    hintText: 'City',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your state';
                            }

                            return null;
                          },
                          controller: state,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 241, 241, 241),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            contentPadding:
                                EdgeInsets.only(left: 10, bottom: 6),
                            hintText: 'State',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width / 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your zipCode';
                            }

                            return null;
                          },
                          controller: zipCode,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 241, 241, 241),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            contentPadding:
                                EdgeInsets.only(left: 10, bottom: 6),
                            hintText: 'Zip Code',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      saveAddress();
                      Provider.of<CheckoutProvider>(context, listen: false)
                          .getAddress();

                      Navigator.pop(context);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 30),
                    child: Container(
                      height: height * .07,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: accentColor),
                      child: Center(
                        child: Text(
                          'Use this address',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
