import 'package:css_colors/css_colors.dart';
import 'package:flutter/material.dart';
import 'package:MerchForce/landingpage.dart';
import 'package:MerchForce/home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:postgres/postgres.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDemo extends StatefulWidget {
  const LoginDemo({Key? key}) : super(key: key);

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? employeecode;
  bool? successful = false;

  // Future<void> loginFunc(email, employeecode) async {
  // var connection = PostgreSQLConnection(
  //     "databasemerchforce.crsslmuuogyz.us-east-1.rds.amazonaws.com",
  //     5432,
  //     "merchforce",
  //     username: "postgres",
  //     password: "SAkiniolinga123a");
  // await connection.open();
  //
  // List<List<dynamic>> results = await connection.query(
  //     "SELECT employeeid, email FROM merchandisers WHERE email=@emailer",
  //     substitutionValues: {
  //       "emailer": email.trim(),
  //       "employeecode": employeecode
  //     });
  //
  // try {
  //   for (final row in results) {
  //     if (row[0].toString() == employeecode.toString()) {
  //       print(employeecode);
  //
  //       // Obtain shared preferences.
  //       final prefs = await SharedPreferences.getInstance();
  //       // Save an integer value to 'counter' key.
  //       await prefs.setString('employeecode', employeecode);
  //       await prefs.setString('firstname', row[1]);
  //       await prefs.setBool('isLoggedin', true);
  //       setState(() {
  //         successful = true;
  //       });
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (_) => HomePage()));
  //     } else {
  //       print("The whole thing is a sham");
  //     }
  //   }
  //   //Database returned null.
  // } on RangeError {
  //   print("Database returned empty");
  // }
  //
  // for (final row in results) {
  //   var a = row[0];
  //   var b = row[1];
  //   print(a);
  //   print(b);
  // }
  // }

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final String? employeecode = prefs.getString('employeecode');
    if ((employeecode.toString()).length > 0) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
    } else {
      print("Blicky");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CSSColors.lavenderBlush,
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0, bottom: 40.0),
                      child: Center(
                        child: Container(
                            width: 200,
                            height: 150,
                            /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                            child: Image.asset("assets/applogodesign.png")),
                      ),
                    ),
                    Padding(
                      //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        onSaved: (value) {
                          email = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your org email';
                          }
                          return null;
                        },
                        style: GoogleFonts.lato(fontSize: 20),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Org Email',
                            hintText: 'Enter valid email id as abc@gmail.com'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15, bottom: 0),
                      //padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        onSaved: (value) {
                          employeecode = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Org password';
                          }
                          return null;
                        },
                        obscureText: true,
                        style: GoogleFonts.lato(fontSize: 20),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Employee Code',
                            hintText: 'Enter employee code'),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        //TODO FORGOT PASSWORD SCREEN GOES HERE
                      },
                      child: Text('Forgot Password',
                          style: GoogleFonts.lato(
                              color: Colors.orange, fontSize: 15)),
                    ),
                    Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          color: CSSColors.black,
                          borderRadius: BorderRadius.circular(20)),
                      child: FlatButton(
                        color: CSSColors.purple,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Logging you in')),
                            );

                            var connection = PostgreSQLConnection(
                                "databasemerchforce.crsslmuuogyz.us-east-1.rds.amazonaws.com",
                                5432,
                                "merchforce",
                                username: "postgres",
                                password: "SAkiniolinga123a");
                            await connection.open();

                            List<
                                List<
                                    dynamic>> results = await connection.query(
                                "SELECT employeeid, email FROM merchandisers WHERE email=@emailer",
                                substitutionValues: {
                                  "emailer": email!.trim(),
                                  "employeecode": employeecode
                                });

                            try {
                              for (final row in results) {
                                if (row[0].toString() ==
                                    employeecode.toString()) {
                                  print(employeecode);

                                  // Obtain shared preferences.
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  // Save an integer value to 'counter' key.
                                  await prefs.setString(
                                      'employeecode', employeecode.toString());
                                  await prefs.setString('firstname', row[1]);
                                  await prefs.setBool('isLoggedin', true);
                                  setState(() {
                                    successful = true;
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => FrontPage()));
                                } else {
                                  print("The whole thing is a sham");
                                }
                              }
                              //Database returned null.
                            } on RangeError {
                              print("Database returned empty");
                            }

                            for (final row in results) {
                              var a = row[0];
                              var b = row[1];
                              print(a);
                              print(b);
                            }
                          }
                        },
                        child: Text('Login',
                            style: GoogleFonts.lato(
                                color: Colors.white, fontSize: 20)),
                      ),
                    ),
                    SizedBox(
                      height: 130,
                    ),
                  ],
                ),
              ),
            ))));
  }
}
