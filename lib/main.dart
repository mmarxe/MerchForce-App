import 'package:MerchForce/landingpage.dart';
import 'package:MerchForce/login.dart';
import 'package:flutter/material.dart';
import 'package:MerchForce/page.dart';
import 'package:MerchForce/home.dart';
import 'package:MerchForce/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getBool('isLoggedin') ?? false;
  print(status);
  runApp(MaterialApp(home: status == true ? FrontPage() : LoginDemo()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MerchForce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginDemo(),
    );
  }
}
