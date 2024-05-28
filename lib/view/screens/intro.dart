import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/screens/signup.dart';

class introPage extends StatefulWidget {
  const introPage({super.key});

  @override
  State<introPage> createState() => _introPageState();
}

class _introPageState extends State<introPage> {
  final CarouselController _controller = CarouselController();
  int dotIndex = 0;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onHorizontalDragUpdate: (_) {},
            child: CarouselSlider(
              carouselController: _controller,
              items: [
                Container(
                  height: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        height: height * .6,
                        width: double.infinity,
                        child: Image.asset(
                          'asset/ad_one.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: height * .04,
                      ),
                      Text(
                        'We provide high \nquality products just \nfor you',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 35),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          _controller.nextPage();
                          setState(() {
                            dotIndex++;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            height: height * .07,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(27),
                                color: Colors.black),
                            child: Center(
                              child: Text(
                                'Next',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        height: height * .6,
                        width: double.infinity,
                        child: Image.asset(
                          'asset/ad_two.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: height * .04,
                      ),
                      Text(
                        'Your satisfaction is\nour number one\npriority',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 35),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          _controller.nextPage();
                          setState(() {
                            dotIndex++;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            height: height * .07,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(27),
                                color: Colors.black),
                            child: Center(
                              child: Text(
                                'Next',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        height: height * .6,
                        width: double.infinity,
                        child: Image.asset(
                          'asset/ad_three.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: height * .04,
                      ),
                      Text(
                        "Let's fulfill your\nhouse needs with\nZippy right now!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 35),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Signup()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            height: height * .07,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(27),
                                color: Colors.black),
                            child: Center(
                              child: Text(
                                'Get started',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
              options: CarouselOptions(
                height: double.infinity,
                initialPage: 0,
                enableInfiniteScroll: false,
                reverse: false,
                autoPlay: false,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: false,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    dotIndex = index;
                  });
                },
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 100,
            child: DotsIndicator(
              dotsCount: 3,
              position: dotIndex,
              decorator: DotsDecorator(
                color: Colors.grey, // Inactive dot color
                activeColor: Colors.black,
                size: Size(7.0, 7.0), // Dot size
                activeSize: Size(9.0, 9.0), // Active dot size
                spacing: EdgeInsets.all(4.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
