// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_4/model/User.dart';
import 'package:flutter_application_4/pages/user_info_page.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({Key? key}) : super(key: key);

  @override
  _RegisterFormPageState createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  bool _hidePass = true;
  bool _hideConPass = true;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> _countries = [
    'Russia',
    'Ukraine',
    'USA',
    'France',
    'Choose your country'
  ];
  String _selectedCountry = 'Choose your country';

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _liveController = TextEditingController();
  final _passController = TextEditingController();
  final _conPassController = TextEditingController();

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passFocus = FocusNode();

  User newUser = User();

  @override
  void dispose() {
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _passFocus.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _liveController.dispose();
    _passController.dispose();
    _conPassController.dispose();

    super.dispose();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Register Form"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            RaisedButton(
                color: Colors.green,
                onPressed: () {
                  _nameController.text = "Dmitry Vinogradov";
                  _phoneController.text = "(063)687-4198";
                  _emailController.text = "vindim24@gmail.com";
                  _liveController.text = "Go little rockstar";
                  _passController.text = "123";
                  _conPassController.text = "123";
                  //_selectedCountry = "Ukraine";
                },
                child: Text(
                  "Default",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
            SizedBox(
              height: 30,
            ),
            //Name TextFormField
            TextFormField(
              focusNode: _nameFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _nameFocus, _phoneFocus);
              },
              validator: _validateName,
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Full name *",
                hintText: "What do people called?",
                prefixIcon: Icon(Icons.person),
                suffixIcon: GestureDetector(
                    onTap: () {
                      _nameController.clear();
                    },
                    child: Icon(Icons.delete_outline, color: Colors.red)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                ),
              ),
              onSaved: (val) => newUser.name = val,
            ),
            SizedBox(height: 10),
            //Phone TextFormField
            TextFormField(
              focusNode: _phoneFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _phoneFocus, _passFocus);
              },
              validator: (value) => _validatePhone(value!)
                  ? null
                  : 'Phone number must be entered as (###)###-####.',
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: "Phone number",
                hintText: "Where can we reach you?",
                helperText: "Phone format: (XXX)XXX-XXXX",
                prefixIcon: Icon(Icons.phone),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _phoneController.clear();
                  },
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                ),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter(RegExp(r'^[()\d -]{1,15}$'),
                    allow: true),
              ],
              onSaved: (val) => newUser.phone = val,
            ),
            SizedBox(height: 20),
            //Email TextFormField
            TextFormField(
              validator: _validateEmail,
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "E-mail address *",
                hintText: "Enter your e-mail address",
                icon: Icon(Icons.mail),
              ),
              keyboardType: TextInputType.emailAddress,
              onSaved: (val) => newUser.email = val,
            ),
            SizedBox(height: 20),
            //Country DropdownButtonFormField
            DropdownButtonFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.map),
                  labelText: "Country"),
              items: _countries.map((country) {
                return DropdownMenuItem(
                  child: Text(country),
                  value: country,
                );
              }).toList(),
              onChanged: (country) {
                print(country);
                setState(() {
                  _selectedCountry = country as String;
                  newUser.country = country;
                });
              },
              value: _selectedCountry,
              onSaved: (data) {
                newUser.country = _selectedCountry;
              },
            ),
            SizedBox(height: 20),
            //Live Story TextFormField
            TextFormField(
              inputFormatters: [LengthLimitingTextInputFormatter(100)],
              controller: _liveController,
              decoration: InputDecoration(
                labelText: "Life story",
                hintText: "Tell us about yourself",
                helperText: "Keep it short, it`s just a demo",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onSaved: (val) => newUser.story = val,
            ),
            SizedBox(height: 20),
            //Password TextFormField
            TextFormField(
              focusNode: _passFocus,
              validator: _validatePass,
              controller: _passController,
              decoration: InputDecoration(
                labelText: "Password *",
                hintText: "Create the password",
                prefixIcon: Icon(Icons.security),
                suffixIcon: IconButton(
                  icon:
                      Icon(_hidePass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                ),
              ),
              obscureText: _hidePass,
              maxLength: 8,
            ),
            SizedBox(height: 20),
            //Confirm password TextFormField
            TextFormField(
              validator: _validatePass,
              controller: _conPassController,
              obscureText: _hideConPass,
              decoration: InputDecoration(
                labelText: "Confirm password *",
                hintText: "Confirm the password",
                prefixIcon: Icon(Icons.security),
                suffixIcon: IconButton(
                  icon: Icon(
                      _hideConPass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _hideConPass = !_hideConPass;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            RaisedButton(
                onPressed: _submitForm,
                color: Colors.green,
                child:
                    Text("Submit Form", style: TextStyle(color: Colors.white)))
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _showDialog(name: _nameController.text);
      print('Form is valid!');
      print('Name: ${_nameController.text}');
      print('Phone: ${_phoneController.text}');
      print('E-mail: ${_emailController.text}');
      print('Country: ${_selectedCountry}');
      print('Live story: ${_liveController.text}');
    } else {
      _showMessage(message: 'Form is not valid. Please review and correct');
    }
  }

  String? _validateName(String? value) {
    final _nameExp = RegExp(r'^[A-Za-z ]+$');

    if (value!.isEmpty) {
      return 'Name is required';
    } else if (!_nameExp.hasMatch(value)) {
      return 'Please enter a alphabetical characters.';
    } else {
      return null;
    }
  }

  bool _validatePhone(String? value) {
    if (value!.isEmpty) {
      return true;
    } else {
      final _phoneExp = RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\d\d$');
      return _phoneExp.hasMatch(value);
    }
  }

  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      return null;
    } else if (!_emailController.text.contains('@')) {
      return 'E-mail must contains character \"@\"';
    } else {
      return null;
    }
  }

  String? _validatePass(String? value) {
    if (_passController.text != _conPassController.text) {
      return 'Passwords does not match';
    } else {
      return null;
    }
  }

  void _showMessage({String? message}) {
    _scaffoldKey.currentState!.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.grey,
        content: Text(
          message!,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
    );
  }

  void _showDialog({String? name}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Registration successful",
                style: TextStyle(
                  color: Colors.green,
                )),
            content: Text(
              '$name is now a verified register form',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserInfoPage(
                          userInfo: newUser,
                        ),
                      ));
                },
                child: Text('Verified',
                    style: TextStyle(color: Colors.green, fontSize: 18)),
              )
            ],
          );
        });
  }
}
