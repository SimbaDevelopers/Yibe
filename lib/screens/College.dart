import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../Money/MoneyMatters.dart';
import '../models/user.dart';
import '../services/banner_database.dart';
import '../services/userdatabase.dart';
import 'Notification.dart';
import 'Preferences.dart';
import 'college_section_page.dart';
import 'message/Message.dart';

class College extends StatefulWidget {
  @override
  _CollegeState createState() => _CollegeState();
}

class _CollegeState extends State<College> {
  String devToken = '';
  UserDetails user;
  bool isBannerLoading = true;
  QuerySnapshot _banner ;
     voidLoadBanner() async{
_banner=  await BannerDatabase().getBanner();
  isBannerLoading = false;
  setState(() {
    
  });}

  void initState() {
    super.initState();
    _updateUser();
      voidLoadBanner();
  }

  void _updateUser() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    await FirebaseMessaging().getToken().then((deviceToken) {
      print('DeviceToken : $deviceToken');
      setState(() {
        devToken = deviceToken;
      });
    });
    print(devToken);
    await UserDatabaseService(uid: user.uid).updateUserDataWithDetails(
        position.latitude, position.longitude, devToken);
  }

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 1;
    user = Provider.of<UserDetails>(context);
final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 0) {
        } else if (details.delta.dx < 0) {
          print("Left Swap");
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(46.0),
          child: AppBar(
            backgroundColor: Color(0xFFFFFFFF),
            actions: <Widget>[
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return NotificationPage();
                        }));
                      },
                      child: Icon(
                        Icons.notifications_none,
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                    Spacer(),
                    Spacer(),
                    GestureDetector(
                        onLongPress: () {
                         // widget.hiberPopUp(true);
                        },
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Messages();
                          }));
                        },
                        child: Icon(Icons.send, color: Colors.black, size: 28)),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              // padding: const EdgeInsets.all(12.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Hello,',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 45,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(children: <Widget>[
                    SizedBox(width: 15.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Preferences();
                        }));
                      },
                      child: Container(
                          child: Text(
                        "Simba",
                        style: TextStyle(
                            color: Color(0xff008294),
                            fontSize: 45,
                            fontWeight: FontWeight.bold),
                      )),
                    )
                  ]),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10, left: 15, right: 15),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.4,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      crossAxisCount: 2,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CollegeSectionPage(
                                activepassedvalue: 0,
                              );
                            }));
                          },
                          child: Container(
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Container(
                                height: 200,
                                child: SvgPicture.asset(
                                    'assets/images/Group 545.svg',
                                    fit: BoxFit.contain),
                                // child: Center(
                                //   child: Text(
                                //     'Events',
                                //     style: TextStyle(
                                //         color: Colors.white, fontSize: 25.0),
                                //   ),
                                // ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CollegeSectionPage(
                                activepassedvalue: 1,
                              );
                            }));
                          },
                          child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Container(
                                height: 200,
                                child: SvgPicture.asset(
                                    'assets/images/Frame 96.svg',
                                    fit: BoxFit.contain),
                                // child: Center(
                                //   child: Text(
                                //     'Growth+',
                                //     style: TextStyle(
                                //         color: Colors.white, fontSize: 25.0),
                                //   ),
                                // ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CollegeSectionPage(
                                activepassedvalue: 2,
                              );
                            }));
                          },
                          child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Container(
                                height: 200,
                                child: SvgPicture.asset(
                                    'assets/images/Frame 99.svg',
                                    fit: BoxFit.contain),
                                // child: Center(
                                //   child: Text(
                                //     'Activities',
                                //     style: TextStyle(
                                //         color: Colors.white, fontSize: 25.0),
                                //   ),
                                // ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return MoneyMatters("JkG0HvAYMotUg8rMz6ug");
                            }));
                          },
                          child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Container(
                                height: 200,
                                child: SvgPicture.asset(
                                    'assets/images/Frame 94.svg',
                                    fit: BoxFit.contain),
                                // child: Center(
                                //   child: Column(
                                //     children: [
                                //       Text(
                                //         'Money',
                                //         style: TextStyle(
                                //             color: Colors.white,
                                //             fontSize: 25.0),
                                //       ),
                                //       Text(
                                //         'Matters ',
                                //         style: TextStyle(
                                //             color: Colors.white,
                                //             fontSize: 25.0),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              )),
                        ),
                      ],
                    ),
                  ),

                  //

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Hot ",
                          style: TextStyle(
                            fontSize: 36,
                            color: Color.fromRGBO(9, 128, 145, 1), //Green shade
                          )),
                      TextSpan(
                        text: "'n Happening",
                        style: TextStyle(fontSize: 36, color: Colors.black),
                      )
                    ])),
                  ),
                 isBannerLoading? Container(
                   height: 180,
                   width: double.infinity,
                   child: Center(
                     child: CircularProgressIndicator(),
                   ),
                 ): CarouselSlider(
                    options: CarouselOptions(
                      initialPage: 1,
                      height: 180.0,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 5),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      pauseAutoPlayOnTouch: true,
                      aspectRatio: 2.0,
                      enableInfiniteScroll: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: _banner.docs.map((card) {
                      return Builder(builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      card['imageUrl'],
                                    ),
                                    fit: BoxFit.fill)),
                            height: 180,
                            width: MediaQuery.of(context).size.width,
                            // child: Card(
                            //   color: Colors.white,
                            //   child: card,
                            // ),
                          ),
                        );
                      });
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 8.0),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Vibe ",
                          style: TextStyle(
                            fontSize: 36,
                            color: Color.fromRGBO(9, 128, 145, 1), //Green shade
                          )),
                      TextSpan(
                        text: "with someone",
                        style: TextStyle(fontSize: 36, color: Colors.black),
                      )
                    ])),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        // border: Border.all(
                        //   color: Colors.black,
                        //   width: 1.0,
                        // ),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image:
                                AssetImage("assets/images/collegePage_map.png"),
                            fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 8, bottom: 8),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Everyday ",
                          style: TextStyle(
                            fontSize: 36,
                            color: Colors.black, //Green shade
                          )),
                      TextSpan(
                        text: "Hustle",
                        style: TextStyle(
                          fontSize: 36,
                          color: Color.fromRGBO(9, 128, 145, 1),
                        ),
                      )
                    ])),
                  ),
                  isBannerLoading? Container(
                   height: 180,
                   width: double.infinity,
                   child: Center(
                     child: CircularProgressIndicator(),
                   ),
                 ): CarouselSlider(
                    options: CarouselOptions(
                      initialPage: 1,
                      height: 180.0,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 5),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      pauseAutoPlayOnTouch: true,
                      aspectRatio: 2.0,
                      enableInfiniteScroll: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: _banner.docs.map((card) {
                      return Builder(builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image:  NetworkImage(
                                      card['imageUrl'],
                                    ),
                                    fit: BoxFit.fill)),
                            height: 180,
                            width: MediaQuery.of(context).size.width,
                            // child: Card(
                            //   color: Colors.white,
                            //   child: card,
                            // ),
                          ),
                        );
                      });
                    }).toList(),
                  ),
                  // CarouselSlider(
                  //   options: CarouselOptions(
                  //     height: 200.0,
                  //     autoPlay: true,
                  //     autoPlayInterval: Duration(seconds: 3),
                  //     autoPlayAnimationDuration: Duration(milliseconds: 800),
                  //     autoPlayCurve: Curves.fastOutSlowIn,
                  //     pauseAutoPlayOnTouch: true,
                  //     aspectRatio: 2.0,
                  //     onPageChanged: (index, reason) {
                  //       setState(() {
                  //         _currentIndex = index;
                  //       });
                  //     },
                  //   ),
                  //   items: cardList1.map((card) {
                  //     return Builder(builder: (BuildContext context) {
                  //       return Container(
                  //         height: MediaQuery.of(context).size.height * 0.30,
                  //         width: MediaQuery.of(context).size.width,
                  //         child: Card(
                  //           color: Colors.white,
                  //           child: card,
                  //         ),
                  //       );
                  //     });
                  //   }).toList(),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
