import 'package:flutter/material.dart';
import 'package:MerchForce/page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:css_colors/css_colors.dart';
import 'package:MerchForce/profile.dart';
import 'package:MerchForce/settings.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Profile Details",
          style: GoogleFonts.lato(fontSize: 20),
        ),
        actions: [
          Center(
              child: Text(
            "Save",
            style: GoogleFonts.lato(fontSize: 20),
          )),
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 0))
        ],
      ),
      body: Container(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Column(
            children: [
              Card(
                elevation: 2,
                child: Container(
                    padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          child: Text(
                            "Registration Details",
                            style: GoogleFonts.lato(
                                color: Colors.purple,
                                fontWeight: FontWeight.w700),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Text(
                          "Name",
                          style: GoogleFonts.openSans(
                              color: Colors.black, fontWeight: FontWeight.w300),
                        ),
                        Padding(padding: EdgeInsets.all(3)),
                        Text(
                          "Mark Maxwell",
                          style: GoogleFonts.lato(fontSize: 15),
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Text(
                          "Company/ Organization",
                          style: GoogleFonts.openSans(
                              color: Colors.black, fontWeight: FontWeight.w300),
                        ),
                        Padding(padding: EdgeInsets.all(3)),
                        Text(
                          "Mill Bakers",
                          style: GoogleFonts.lato(fontSize: 15),
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Text(
                          "Employee Code",
                          style: GoogleFonts.openSans(
                              color: Colors.black, fontWeight: FontWeight.w300),
                        ),
                        Padding(padding: EdgeInsets.all(3)),
                        Text(
                          "Mill201",
                          style: GoogleFonts.lato(fontSize: 15),
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Text(
                          "Region",
                          style: GoogleFonts.openSans(
                              color: Colors.black, fontWeight: FontWeight.w300),
                        ),
                        Padding(padding: EdgeInsets.all(3)),
                        Text(
                          "Nairobi Area",
                          style: GoogleFonts.lato(fontSize: 15),
                        )
                      ],
                    )),
              ),
              // Center(
              //   child: Container(
              //       width: 200,
              //       height: 150,
              //       /*decoration: BoxDecoration(
              //               color: Colors.red,
              //               borderRadius: BorderRadius.circular(50.0)),*/
              //       child: Image.asset("assets/applogodesign.png")),
              // ),
              // Center(
              //     child: Text(
              //   "Mark Maxwell",
              //   style: GoogleFonts.lato(fontSize: 20),
              // )),
              // Padding(padding: EdgeInsets.all(20)),
              // Center(
              //     child: Text(
              //   "Mill Bakers",
              //   style: GoogleFonts.lato(fontSize: 20),
              // )),
              // Padding(padding: EdgeInsets.all(20)),
              // Center(
              //     child: Text(
              //   "EMP001",
              //   style: GoogleFonts.lato(fontSize: 20),
              // )),
            ],
          )),
    );
  }
}
