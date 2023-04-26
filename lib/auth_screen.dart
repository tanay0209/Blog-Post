import 'package:blog_post/authentication.dart';
import 'package:blog_post/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Authentication authentication = Authentication();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoginPage = true;
  late String _email;
  late String _password;
  late String _username;

  startAuthentication() {
    final validity = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (validity) {
      formKey.currentState!.save();
    }
    if (isLoginPage) {
      authentication.logInWithEmailAndPassword(_email, _password);
    } else {
      authentication.createAUserWithEmailAndPassword(
          _email, _password, _username);
    }
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: h,
            width: w,
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Image.asset("assets/authentication.jpg"),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      !isLoginPage
                          ? TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || value.length < 6) {
                                  return 'Incorrect Username';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                _username = value!;
                              },
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide()),
                                  labelText: "Enter Username",
                                  labelStyle: GoogleFonts.roboto()),
                            )
                          : Container(),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Invalid Email';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _email = value!;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(),
                          ),
                          labelText: "Enter Email",
                          labelStyle: GoogleFonts.roboto(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Incorrect Password ';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _password = value!;
                        },
                        keyboardType: TextInputType.emailAddress,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide()),
                            labelText: "Enter Password",
                            labelStyle: GoogleFonts.roboto()),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              backgroundColor: Theme.of(context).primaryColor,
                              padding: const EdgeInsets.all(12)),
                          onPressed: () {
                            startAuthentication();
                          },
                          child: isLoginPage
                              ? Text(
                                  "Login",
                                  style: GoogleFonts.roboto(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                )
                              : Text(
                                  "Sign Up",
                                  style: GoogleFonts.roboto(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isLoginPage = !isLoginPage;
                          });
                        },
                        child: isLoginPage
                            ? Text(
                                "Not a member? Sign Up",
                                style: GoogleFonts.roboto(
                                    fontSize: 14, color: Colors.black),
                              )
                            : Text(
                                "Already a Member? Log In",
                                style: GoogleFonts.roboto(
                                    fontSize: 14, color: Colors.black),
                              ),
                      ),
                      isLoginPage
                          ? Container()
                          : SizedBox(
                              child: TextButton.icon(
                                icon: const FaIcon(FontAwesomeIcons.google),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(12),
                                ),
                                onPressed: () {
                                  authentication.signInWithGoogle();
                                },
                                label: const Text("Sign In With Google"),
                              ),
                            )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
