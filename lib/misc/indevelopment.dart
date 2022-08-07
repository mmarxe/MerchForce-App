import 'package:flutter/material.dart';
import 'package:MerchForce/profile.dart';
import 'package:MerchForce/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:css_colors/css_colors.dart';

class IndevPage extends StatefulWidget {
  const IndevPage({Key? key}) : super(key: key);

  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<IndevPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Coming Soon",
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
        backgroundColor: Colors.black,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/placeholder.jpg",
              width: MediaQuery.of(context).size.width / 1.5,
            ),
            Padding(padding: EdgeInsets.all(20)),
            Center(
                child: Text(
              "The feature is still in testing. We are working tirelessly to get it to you.",
              style: GoogleFonts.lato(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            )),
          ],
        )),
      ),
    );
  }
}
