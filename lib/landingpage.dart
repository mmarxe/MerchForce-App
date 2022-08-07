import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:css_colors/css_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:MerchForce/login.dart';
import 'package:MerchForce/page.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:postgres/postgres.dart';
import 'package:geolocator/geolocator.dart';

import 'package:MerchForce/data/schedules.dart';
import 'package:MerchForce/profile.dart';
import 'package:MerchForce/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? firstname;

  late final Future? myFuture = this.getData();

  var data;

  bool freeday = false;

  Future<List> getData() async {
    List results = await returnOutlets();

    if (results.length == 0) {
      this.setState(() {
        freeday = true;
      });
    }
    this.setState(() {
      data = results;
    });
    return data;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    this._determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            "Schedules",
            style: GoogleFonts.lato(),
          ),
          backgroundColor: Colors.black,
          actions: [
            InkWell(
              child: Icon(Icons.settings),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SettingsPage()));
              },
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 0)),
            InkWell(
              child: Icon(Icons.person_sharp),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => ProfilePage()));
              },
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(
                    color: CSSColors.black,
                  ),
                  child: Image.asset("assets/logodesigna.png")),
              ListTile(
                title: const Text('Schedules'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Report Absence'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Report Expiry'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                color: CSSColors.lavender,
                padding: EdgeInsets.all(12.0),
                margin: EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Row(children: [
                      CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(
                              'https://www.w3schools.com/howto/img_avatar2.png')),
                      Padding(
                        child: Text(
                          "Hello Merchandiser"
                          "",
                          style: GoogleFonts.lato(fontSize: 25),
                        ),
                        padding: EdgeInsets.all(10.0),
                      )
                    ]),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Center(
                      child: Text("Your schedule for today is: ",
                          style: GoogleFonts.lato(fontSize: 20)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                  ],
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.67,
                  child: FutureBuilder(
                    future: myFuture,
                    builder: (context, snapshot) {
                      // Checking if future is resolved or not
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            '${snapshot.error} occurred',
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                        // if we got our data
                      } else if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: CSSColors.purple,
                            strokeWidth: 5.0,
                            backgroundColor: CSSColors.lavenderBlush,
                          ),
                        );
                        // Extracting data from snapshot object
                      }
                      if (!freeday) {
                        return ListView.builder(
                            padding: EdgeInsets.all(8.0),
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  height: 100,
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => MapPage(
                                                    taskName: data[index][1],
                                                    taskCode: data[index][0],
                                                    latitude: data[index][2],
                                                    longitude: data[index]
                                                        [3])));
                                      },
                                      child: Card(
                                          elevation: 3,
                                          shape: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(7),
                                              ),
                                              Image.asset(
                                                  width: 50,
                                                  height: 50,
                                                  "assets/Business_2_(89).jpg"),
                                              Padding(
                                                padding: EdgeInsets.all(7),
                                              ),
                                              Text(
                                                data[index][1],
                                                style: GoogleFonts.lato(),
                                              ),
                                            ],
                                          ))));
                            });
                      } else {
                        return Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/free.jpg",
                                width: MediaQuery.of(context).size.width / 1.5,
                              ),
                              Padding(padding: EdgeInsets.all(5)),
                              Center(
                                  child: Text(
                                "It appears you have no pending tasks. Do check back tomorrow. Have a lovely day.",
                                style: GoogleFonts.openSans(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                                textAlign: TextAlign.center,
                              )),
                            ],
                          )),
                        );
                      }
                    },
                  )),
            ])));
  }
}
