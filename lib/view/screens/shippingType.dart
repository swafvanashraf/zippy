import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/const.dart';
import 'package:flutter_application_1/utils/lists.dart';
import 'package:flutter_application_1/view/screens/checkoutPage.dart';
import 'package:flutter_application_1/viewmodel/providers/checkOutProvider.dart';
import 'package:provider/provider.dart';

class ShippingType extends StatefulWidget {
  const ShippingType({super.key});

  @override
  State<ShippingType> createState() => _ShippingTypeState();
}

class _ShippingTypeState extends State<ShippingType> {
 

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
        final checkoutProviderobj = Provider.of<CheckoutProvider>(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 228, 228),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 30),
        child: Column(
          children: [
            SizedBox(
              height: height * .07,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => checkout()));
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
                  'Choose shipping',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                ),
              ],
            ),
            SizedBox(
              height: height * .7,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 27),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: backgroundColor,
                      ),
                      height: height * .11,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 17, right: 7),
                        child: Row(
                          children: [
                            CircleAvatar(
                                radius: 27,
                                backgroundColor: accentColor,
                                child: Center(child: shippingIcons[index])),
                            SizedBox(
                              width: width * .03,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  shippingTypeName[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  shippingTypeDays[index],
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 16, color: secondarytextColor),
                                ),
                              ],
                            ),
                            Spacer(),
                            Text(
                              '\$${shippingPrices[index]}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Radio(
                              value: index,
                              groupValue:checkoutProviderobj.selectedShippingType,
                              onChanged: (value) {
                                setState(() {
                                  checkoutProviderobj.selectedShippingType = value as int;
                                  Provider.of<CheckoutProvider>(context,
                                          listen: false)
                                      .shippingPrice(value);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => checkout()));
              },
              child: Container(
                height: height * .07,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: accentColor),
                child: Center(
                  child: Text(
                    'Apply',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Color.fromARGB(255, 236, 236, 236)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
