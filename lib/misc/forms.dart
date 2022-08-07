import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:css_colors/css_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:MerchForce/profile.dart';
import 'package:MerchForce/settings.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
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
      body: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SignUpForm()),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState>();

  String _name = '';
  String _email = '';
  int _age = -1;
  String _maritalStatus = 'single';
  int _selectedGender = 0;
  String _password = '';
  bool _termsChecked = true;

  List<DropdownMenuItem<int>> genderList = [];

  void loadGenderList() {
    genderList = [];
    genderList.add(const DropdownMenuItem(
      child: Text('Male'),
      value: 0,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('Female'),
      value: 1,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('Others'),
      value: 2,
    ));
  }

  @override
  Widget build(BuildContext context) {
    loadGenderList();
    // Build a Form widget using the _formKey we created above
    return Form(
        key: _formKey,
        child: ListView(
          children: getFormWidget(),
        ));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
    ));

    formWidget.add(TextFormField(
      decoration:
          const InputDecoration(labelText: 'Enter your name', hintText: 'Name'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a name';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _name = value.toString();
        });
      },
    ));

    validateEmail(String? value) {
      if (value!.isEmpty) {
        return 'Please enter mail';
      }

      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = RegExp(pattern.toString());
      if (!regex.hasMatch(value.toString())) {
        return 'Enter Valid Email';
      } else {
        return null;
      }
    }

    formWidget.add(Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
    ));

    formWidget.add(TextFormField(
      decoration: const InputDecoration(
        labelText: 'Provide phone number',
        hintText: '07XX...',
      ),
      keyboardType: TextInputType.phone,
      validator: validateEmail,
      onSaved: (value) {
        setState(() {
          _email = value.toString();
        });
      },
    ));

    formWidget.add(Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
    ));

    formWidget.add(DropdownButton(
      hint: const Text('Select Gender'),
      items: genderList,
      value: _selectedGender,
      onChanged: (value) {
        setState(() {
          _selectedGender = int.parse(value.toString());
        });
      },
      isExpanded: true,
    ));

    formWidget.add(Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
    ));

    formWidget.add(Column(
      children: <Widget>[
        RadioListTile<String>(
          title: const Text('Merchandiser'),
          value: 'merchandiser',
          groupValue: _maritalStatus,
          onChanged: (value) {
            setState(() {
              _maritalStatus = value.toString();
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Admin'),
          value: 'admin',
          groupValue: _maritalStatus,
          onChanged: (value) {
            setState(() {
              _maritalStatus = value.toString();
            });
          },
        ),
      ],
    ));

    formWidget.add(Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
    ));

    formWidget.add(TextField(
      decoration: InputDecoration(
          labelText: "Please tell us your problem right here..."),
      maxLines: 6,
    ));

    formWidget.add(Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
    ));

    formWidget.add(CheckboxListTile(
      value: _termsChecked,
      onChanged: (value) {
        setState(() {
          _termsChecked = value.toString().toLowerCase() == 'true';
        });
      },
      subtitle: !_termsChecked
          ? const Text(
              'Please accept our terms and conditions',
              style: TextStyle(color: Colors.red, fontSize: 12.0),
            )
          : null,
      title: const Text(
        'I agree to the terms and condition',
      ),
      controlAffinity: ListTileControlAffinity.leading,
    ));

    formWidget.add(Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
    ));

    void onPressedSubmit() {
      if (_formKey.currentState!.validate() && _termsChecked) {
        _formKey.currentState?.save();

        print("Name " + _name);
        print("Email " + _email);
        print("Age " + _age.toString());
        switch (_selectedGender) {
          case 0:
            print("Gender Male");
            break;
          case 1:
            print("Gender Female");
            break;
          case 3:
            print("Gender Others");
            break;
        }
        print("Marital Status " + _maritalStatus);
        print("Password " + _password);
        print("Termschecked " + _termsChecked.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Form Submitted')));
      }
    }

    formWidget.add(ElevatedButton(
        style: ButtonStyle(),
        child: const Text('Report Problem'),
        onPressed: onPressedSubmit));

    return formWidget;
  }
}
