import 'package:flutter/material.dart';
import 'package:MerchForce/profile.dart';
import 'package:MerchForce/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:css_colors/css_colors.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contact Team",
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
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
              physics: BouncingScrollPhysics(),
              // crossAxisCount: 2,
              // crossAxisSpacing: 10.0,
              // mainAxisSpacing: 10.0,
              children: List.generate(contacts.length, (index) {
                return Center(
                  child: ContactCard(contact: contacts[index]),
                );
              }))),
    );
  }
}

class Contacts {
  final int id;
  final String firstname;
  final String lastname;
  final String role;
  final String contact;
  final String email;

  const Contacts(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.role,
      required this.contact,
      required this.email});
}

const List<Contacts> contacts = [
  Contacts(
      id: 1,
      firstname: "Imran",
      lastname: "Director",
      role: "Admin",
      contact: "0720364510",
      email: "imran@jubille.com"),
  Contacts(
      id: 1,
      firstname: "Joseph",
      lastname: "Sales",
      role: "Admin",
      contact: "+254 730 789 083",
      email: "joseph@jubille.com")
];

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key, required this.contact}) : super(key: key);
  final Contacts contact;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(4, 0, 4, 10),
        child: Card(
          elevation: 5,
          child: Container(
              padding: EdgeInsets.all(12.0),
              height: MediaQuery.of(context).size.height / 4.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(
                                'https://www.w3schools.com/howto/img_avatar2.png')),
                        Padding(padding: EdgeInsets.all(10)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("${contact.firstname} ${contact.lastname}",
                                style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18)),
                            Padding(padding: EdgeInsets.all(4.0)),
                            Text(contact.role,
                                style: GoogleFonts.openSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300))
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                      child: Column(children: [
                    Row(
                      children: [
                        Icon(Icons.phone),
                        Padding(padding: EdgeInsets.all(4.0)),
                        Text(contact.contact,
                            style: GoogleFonts.lato(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ))
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(4.0)),
                    Row(
                      children: [
                        Icon(Icons.email),
                        Padding(padding: EdgeInsets.all(4.0)),
                        Text(contact.email,
                            style: GoogleFonts.lato(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ))
                      ],
                    )
                  ]))
                ],
              )),
        ));
  }
}
