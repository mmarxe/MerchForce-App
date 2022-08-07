import 'package:flutter/material.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:css_colors/css_colors.dart';
import 'package:MerchForce/profile.dart';
import 'package:MerchForce/settings.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'dart:math';

class OutletsPage extends StatefulWidget {
  const OutletsPage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<OutletsPage> {
  @override
  void dispose() {
    super.dispose();
  }

  late MapboxMapController controller;
  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Outlets",
      //     style: GoogleFonts.lato(),
      //   ),
      //   backgroundColor: Colors.black,
      //   actions: [
      //     InkWell(
      //       child: Icon(Icons.settings),
      //       onTap: () {
      //         Navigator.push(
      //             context, MaterialPageRoute(builder: (_) => SettingsPage()));
      //       },
      //     ),
      //     Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 0)),
      //     InkWell(
      //       child: Icon(Icons.person_sharp),
      //       onTap: () {
      //         Navigator.push(
      //             context, MaterialPageRoute(builder: (_) => ProfilePage()));
      //       },
      //     ),
      //     Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
      //   ],
      // ),
      body: SafeArea(
          child: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: MapboxMap(
              onMapCreated: _onMapCreated,
              logoViewMargins: Point(1, 1),
              compassViewMargins: Point(1, 1),
              myLocationEnabled: true,
              myLocationTrackingMode: MyLocationTrackingMode.TrackingCompass,
              myLocationRenderMode: MyLocationRenderMode.NORMAL,
              trackCameraPosition: true,
              initialCameraPosition: const CameraPosition(
                  target: LatLng(-1.2916507459474167, 36.89470512072173),
                  zoom: 8),
              accessToken:
                  "pk.eyJ1IjoibWFjc2FraW5pIiwiYSI6ImNsNjczZ2phYjFkdGozanA0bjVwZTV1anYifQ.G2ZZwwuZCjw9Pz9706RyaQ"),
        ),
        SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(color: Colors.green, spreadRadius: 1),
                      ],
                      color: Colors.purple),
                  width: 300,
                  height: 200,
                ),
                Padding(padding: EdgeInsets.all(10)),
                Container(
                  width: 300,
                  height: 200,
                  color: Colors.black,
                ),
                Padding(padding: EdgeInsets.all(10)),
                Container(
                  width: 300,
                  height: 200,
                  color: Colors.pink,
                )
              ],
            ))
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          null;
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
