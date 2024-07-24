// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gfourproject/widgets/field.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/util_barrel.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    super.key,
  });

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final TextEditingController _cpasswordField = TextEditingController();
  String? emailErrorText;
  String? passwordErrorText;
  String? cpasswordErrorText;
  bool isSigningUp = false;

  String? _emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return 'Oops! Please enter your email';
    } else if (!RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$")
        .hasMatch(email)) {
      return 'Oops! Please enter a valid email';
    }
    return null;
  }

  String? _passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Oops! Please enter your password';
    } else if (!RegExp(
            r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,32}$")
        .hasMatch(password)) {
      return 'Minimum 8 characters, must contain at least \none lowercase letter, \none uppercase letter, \none digit and \none special character';
    }
    return null;
  }

  String? _cpasswordValidator(String? cpassword) {
    if (cpassword == null || cpassword.isEmpty) {
      return 'Oops! Please re-enter your password';
    } else if (cpassword != _passwordField.text) {
      return 'Oops! Passwords do not match';
    } else if (!RegExp(
            r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,32}$")
        .hasMatch(cpassword)) {
      return 'Minimum 8 characters, must contain at least \none lowercase letter, \none uppercase letter, \none digit and \none special character';
    }
    return null;
  }

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _signUp() async {
    setState(() {
      isSigningUp = true;
    });

    String email = _emailField.text;
    String password = _passwordField.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    setState(() {
      isSigningUp = false;
    });
    if (user != null && mounted) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("userEmail", user.email.toString());
      showToast(message: "User is successfully created");
      Navigator.pushReplacementNamed(context, "/mainhome", arguments: email);
    } else {
      //showToast(message: "Some error happened");
    }
  }

  @override
  void dispose() {
    _emailField.dispose();
    _passwordField.dispose();
    _cpasswordField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Flexible(child: Container()),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Card(
                        color: const Color.fromARGB(141, 1, 172, 252),
                        shadowColor: const Color.fromARGB(223, 1, 172, 252),
                        elevation: 10,
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                const Text(
                                  'Sign Up in Application',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Field(
                                  fErrorText: emailErrorText,
                                  fField: _emailField,
                                  validator: _emailValidator,
                                  label: 'Email*',
                                  hint: 'Enter your email',
                                  obscure: false,
                                  kbtype: TextInputType.emailAddress,
                                  prefix: const Icon(Icons.alternate_email,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 20.0),
                                Field(
                                  fErrorText: passwordErrorText,
                                  fField: _passwordField,
                                  validator: _passwordValidator,
                                  label: 'Password*',
                                  hint: 'Enter your password',
                                  obscure: false,
                                  prefix: const Icon(Icons.vpn_key,
                                      color: Colors.white),
                                  suffix: IconButton(
                                      onPressed: _toggle,
                                      icon: Icon(
                                          _obscureText == true
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.white)),
                                ),
                                const SizedBox(height: 10.0),
                                Field(
                                  fErrorText: cpasswordErrorText,
                                  fField: _cpasswordField,
                                  validator: _cpasswordValidator,
                                  label: 'Re-enter Password*',
                                  hint: 'Re-enter your password',
                                  obscure: _obscureText,
                                  prefix: const Icon(Icons.vpn_key,
                                      color: Colors.white),
                                  suffix: IconButton(
                                      onPressed: _toggle,
                                      icon: Icon(
                                          _obscureText == true
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.white)),
                                ),
                                const SizedBox(height: 10.0),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                          context, '/');
                                    },
                                    child: const Row(
                                      children: [
                                        Text(
                                          'Already have an account?',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Log in',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 33, 243, 198)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      String? emailError =
                                          _emailValidator(_emailField.text);
                                      String? passwordError =
                                          _passwordValidator(
                                              _passwordField.text);
                                      String? cpasswordError =
                                          _cpasswordValidator(
                                              _cpasswordField.text);
                                      emailErrorText = emailError;
                                      passwordErrorText = passwordError;
                                      cpasswordErrorText = cpasswordError;

                                      if (emailErrorText == null &&
                                          passwordErrorText == null &&
                                          cpasswordErrorText == null) {
                                        _signUp();
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromARGB(255, 0, 29, 43),
                                      minimumSize: const Size(110, 50)),
                                  child: const Text('Sign Up',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.0,
                                      )),
                                ),
                                const SizedBox(height: 10.0),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        backgroundColor: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        minimumSize: const Size(105, 45)),
                                    onPressed: () {
                                      signInWithGoogle();
                                    },
                                    child: SizedBox(
                                      width: 240.0,
                                      child: ListTile(
                                        contentPadding: const EdgeInsets.all(0),
                                        onTap: () {
                                          signInWithGoogle();
                                        },
                                        leading: Image.asset(
                                          'lib/assets/images/GLogo.png',
                                          height: 40,
                                        ),
                                        title: const Text(
                                          'Sign Up with Google',
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId:
            '1015649823289-2u5nggd118gcj30rrv588474553q60o0.apps.googleusercontent.com');

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null && mounted) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("userEmail", user.email.toString());
          showToast(message: "Successfully signed in with Google");
          Navigator.pushReplacementNamed(context, "/mainhome",
              arguments: user.email);
        }
      }
    } catch (e) {
      showToast(
          message: "Some error occurred with Google sign-in: ${e.toString()}");
    }
  }
}
