import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:css_colors/css_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:postgres/postgres.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:MerchForce/profile.dart';
import 'package:MerchForce/settings.dart';

class MapPage extends StatefulWidget {
  final String? title;
  final String? taskName;
  final String? latitude;
  final String? longitude;
  final int? taskCode;

  const MapPage(
      {Key? key,
      this.title,
      this.taskName,
      this.taskCode,
      this.latitude,
      this.longitude})
      : super(key: key);

  @override
  MapPageState createState() =>
      MapPageState(this.taskName, this.taskCode, this.latitude, this.longitude);
}

class MapPageState extends State<MapPage> {
  final String? taskName;
  final String? latitude;
  final String? longitude;
  final int? taskCode;

  MapPageState(this.taskName, this.taskCode, this.latitude, this.longitude);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  MapController mapController = MapController(
    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude: -1.2566, longitude: 37.890),
    // areaLimit: BoundingBox(
    //   east: 10.4922941,
    //   north: 47.8084648,
    //   south: 45.817995,
    //   west: 5.9559113,
    // ),
  );

  var distance = 0.0;

  bool hasStarted = false;

  bool confirmattendance = true;

  Future<void> sendData() async {
    var connection = PostgreSQLConnection(
        "databasemerchforce.crsslmuuogyz.us-east-1.rds.amazonaws.com",
        5432,
        "merchforce",
        username: "postgres",
        password: "SAkiniolinga123a");

    await connection.open();

    List<List<dynamic>> results = await connection.query(
        "INSERT INTO attendance() VALUES * FROM mytable",
        substitutionValues: {"emailer": "1"});
  }

  Future<double> calculateDistance(lat2, lon2) async {
    Position? loc = await Geolocator.getCurrentPosition();
    if (loc != null) {
      double val =
          Geolocator.distanceBetween(loc.latitude, loc.longitude, lat2, lon2) /
              1000;
      if (val.round() <= 3) {
        print("Access Allowed");

        _scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: new Text('Location verified.'),
          duration: new Duration(seconds: 10),
        ));

        //This is under testing.....setState makes the app crash
        setState(() {
          confirmattendance = false;
          hasStarted = true;
          distance = val;
        });
      } else {
        print("Access Denied");
        _scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: new Text(
              'Cannot verify location: Reach outlet then confirm attendance.'),
          duration: new Duration(seconds: 10),
        ));
        setState(() {
          hasStarted = false;
          distance = val;
        });
      }
    }
    return 0.9;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: CSSColors.black,
        title: Text(
          "Confirm Attendance",
          style: GoogleFonts.lato(),
        ),
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
      body: ListView(padding: EdgeInsets.all(8.0), children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(width: 50, height: 50, "assets/Business_2_(89).jpg"),
            Text(
              taskName.toString(),
              style: GoogleFonts.lato(fontSize: 30),
            )
          ],
        ),
        Padding(padding: EdgeInsets.all(10)),
        SizedBox(
          width: 300,
          height: 300,
          child: Container(
            color: CSSColors.paleGoldenRod,
          ),
        ),
        Padding(padding: EdgeInsets.all(10)),
        Visibility(
            visible: confirmattendance,
            child: SizedBox(
              width: 300,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    child: Text("Confirm Attendance"),
                    onPressed: () {
                      showAlertDialog(context);
                      calculateDistance(double.parse(longitude.toString()),
                          double.parse(latitude.toString()));
                    },
                  ),
                ],
              ),
            )),
        Padding(padding: EdgeInsets.all(10)),
        Align(
          child:
              Text("More Information", style: GoogleFonts.lato(fontSize: 30)),
          alignment: Alignment.center,
        ),
        Padding(padding: EdgeInsets.all(10)),
        Align(
          child: Text("Distance Away: ${distance.round()} Km",
              style: GoogleFonts.lato()),
          alignment: Alignment.center,
        ),
        Padding(padding: EdgeInsets.all(5)),
        Align(
          child: Text(
              "Estimated Time of Arrival: ${(distance / 15).round()} Hours",
              style: GoogleFonts.lato()),
          alignment: Alignment.center,
        ),
        Padding(padding: EdgeInsets.all(5)),
        Align(
          child:
              Text("Closest Store: Naivas Eastgate", style: GoogleFonts.lato()),
          alignment: Alignment.center,
        ),
        Padding(padding: EdgeInsets.all(7)),
        Center(
            child: Visibility(
                visible: hasStarted,
                child: Text(
                  "Your attendance has been logged.",
                  style: GoogleFonts.lato(fontSize: 23, color: CSSColors.green),
                )))
      ]),
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("Confirm"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  Widget noButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Naivas Utawala"),
    content: Text("Do you want to confirm attendance?"),
    actions: [noButton, okButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
