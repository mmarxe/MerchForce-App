import 'package:flutter/material.dart';
import 'package:MerchForce/page.dart';
import 'package:MerchForce/misc/indevelopment.dart';
import 'package:MerchForce/misc/contacts.dart';
import 'package:MerchForce/misc/forms.dart';
import 'package:MerchForce/landingpage.dart';
import 'package:MerchForce/profile.dart';
import 'package:MerchForce/mappage.dart';
import 'package:MerchForce/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:css_colors/css_colors.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({Key? key}) : super(key: key);

  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.home),
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
          title: Text(
            "Home",
            style: GoogleFonts.lato(),
          ),
        ),
        body: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff000000), Color(0xff434343)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        tileMode: TileMode.mirror),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(6),
                        bottomRight: Radius.circular(6)),
                    color: Colors.black),
                // color: Colors.black,
                width: MediaQuery.of(context).size.width,
                height: (MediaQuery.of(context).size.height) * 0.25,
                child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [],
                    )),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  height: (MediaQuery.of(context).size.height) * 0.65,
                  child: GridView.count(
                      physics: BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      children: List.generate(choices.length, (index) {
                        return Center(
                          child: SelectCard(choice: choices[index]),
                        );
                      })))
            ])));
  }
}

class Choice {
  final String? title;
  final IconData? icon;
  final Widget widget;

  const Choice({this.title, this.icon, required this.widget});
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Merchandising', icon: Icons.home, widget: HomePage()),
  const Choice(title: 'Scan QR', icon: Icons.qr_code, widget: IndevPage()),
  const Choice(title: 'Outlets', icon: Icons.map, widget: OutletsPage()),
  const Choice(
      title: 'Contact Sales', icon: Icons.phone, widget: ContactPage()),
  const Choice(
      title: 'Report Problem',
      icon: Icons.comment,
      widget: FormPage(
        title: "Report Problem",
      )),
  const Choice(title: 'Settings', icon: Icons.settings, widget: SettingsPage()),
  // const Choice(title: 'Album', icon: Icons.photo_album),
  // const Choice(title: 'WiFi', icon: Icons.wifi),
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => choice.widget));
        },
        child: Card(
            elevation: 0,
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.25),
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                      colors: [CSSColors.lavender, Colors.white],
                      begin: Alignment.topLeft,
                      end: Alignment.centerRight,
                      tileMode: TileMode.mirror),
                ),
                child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: Icon(choice.icon,
                                size: 50.0, color: CSSColors.black)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                            child: Text(choice.title.toString(),
                                style: GoogleFonts.lato())),
                      ]),
                ))));
  }
}
