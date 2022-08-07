import 'package:flutter/material.dart';
import 'package:MerchForce/page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:css_colors/css_colors.dart';
import 'package:MerchForce/profile.dart';
import 'package:MerchForce/settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<SettingsPage> {
  bool isdarkmode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: isdarkmode ? Colors.black : Colors.black,
          title: Text(
            "Settings",
            style: GoogleFonts.lato(),
          ),
          actions: [
            // InkWell(
            //   child: Icon(Icons.settings),
            //   onTap: () {
            //     Navigator.push(
            //         context, MaterialPageRoute(builder: (_) => SettingsPage()));
            //   },
            // ),
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
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                SwitchListTile(
                    title: Text(
                      "Dark Mode",
                      style: GoogleFonts.lato(),
                    ),
                    value: isdarkmode,
                    onChanged: (bool value) {
                      setState(() {
                        isdarkmode = value;
                      });
                    }),
                SwitchListTile(
                    title: Text("Offline Mode", style: GoogleFonts.lato()),
                    value: isdarkmode,
                    onChanged: (bool value) {
                      setState(() {
                        isdarkmode = value;
                      });
                    }),
                ListTile(
                  title:
                      Text("Contact for Assistance", style: GoogleFonts.lato()),
                ),
                ListTile(
                  title: Text("Report Problem", style: GoogleFonts.lato()),
                ),
                Divider(
                  height: 10,
                  color: Colors.black,
                ),
                ListTile(
                  title: Text("Request for feature"),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        Text("Rarelane Analytica", style: GoogleFonts.lato()),
                        Padding(padding: EdgeInsets.all(2)),
                        Text("All Rights Reserved | 2022",
                            style: GoogleFonts.lato()),
                        Padding(padding: EdgeInsets.all(2)),
                        Text("Built by Rarelane Design.",
                            style: GoogleFonts.lato()),
                      ],
                    ))
              ],
            )));
  }
}
