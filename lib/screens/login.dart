import 'package:mokshyauser/helpers/style.dart';
import 'package:mokshyauser/provider/user.dart';
import 'package:mokshyauser/screens/home.dart';
import 'package:mokshyauser/screens/signup.dart';
import 'package:mokshyauser/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mokshyauser/helpers/common.dart';
import 'package:hexcolor/hexcolor.dart';
//import 'package:hexcolor/hexcolor.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      body: user.status == Status.Authenticating
          ? Loading()
          : Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment(0.8,
                          0.0), // 10% of the width, so there are ten blinds.
                      colors: [HexColor("#6B01A0"), HexColor("#B459E1")],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        children: [
                          Image(
                            image: AssetImage("images/orange.png"),
                            alignment: Alignment.topLeft,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 55, left: 30.0),
                            child: Text("Welcome Back,\n Login!",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
                                  color: Colors.white,
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 150.0),
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 70.0,
                              backgroundImage:
                                  AssetImage("images/logowhite.jpg"),
                            ),
                          ),
                        ],
                      ),
                      Image(
                        image: AssetImage("images/white_Bottom.png"),
                        alignment: Alignment.bottomLeft,
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 250.0),
                    child: Center(
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(50.0),
                                color: Colors.white.withOpacity(0.20),
                                elevation: 0.0,
                                borderOnForeground: true,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: TextFormField(
                                    controller: _email,
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      icon: Icon(Icons.alternate_email),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        Pattern pattern =
                                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                        RegExp regex = new RegExp(pattern);
                                        if (!regex.hasMatch(value))
                                          return 'Please make sure your email address is valid';
                                        else
                                          return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white.withOpacity(0.4),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: TextFormField(
                                    controller: _password,
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      icon: Icon(Icons.lock_outline),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "The password field cannot be empty";
                                      } else if (value.length < 6) {
                                        return "the password has to be at least 6 characters long";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.red.shade700,
                                  elevation: 0.0,
                                  child: MaterialButton(
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        if (!await user.signIn(
                                            _email.text, _password.text))
                                          _key.currentState.showSnackBar(
                                              SnackBar(
                                                  content:
                                                      Text("Sign in failed")));
                                      }
                                    },
                                    minWidth: MediaQuery.of(context).size.width,
                                    child: Text(
                                      "Login",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.white,
                                  elevation: 0.0,
                                  child: OutlineButton(
                                    splashColor: Colors.grey,
                                    onPressed: () {},
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    highlightElevation: 0,
                                    borderSide: BorderSide(color: Colors.grey),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Image(
                                              image: AssetImage(
                                                  "images/google_logo.png"),
                                              height: 35.0),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Sign in with Google',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Forgot password ?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
//                          Expanded(child: Container()),

                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SignUp()));
                                    },
                                    child: Text(
                                      "Sign up",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ))),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
