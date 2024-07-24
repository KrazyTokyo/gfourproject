// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gfourproject/widgets/field.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/util_barrel.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  // ignore: unused_field
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  String? emailErrorText;
  String? passwordErrorText;

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
      return 'Minimum 8 characters, must contain at least one lowercase letter, one uppercase letter, one digit and one special character';
    }
    return null;
  }

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _emailField.dispose();
    _passwordField.dispose();
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
                                  'Log Into JamSpot',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Field(
                                  fErrorText: emailErrorText,
                                  fField: _emailField,
                                  validator: _emailValidator,
                                  label: 'Email*',
                                  hint: 'Enter your email',
                                  kbtype: TextInputType.emailAddress,
                                  obscure: false,
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
                                const SizedBox(height: 20.0),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                          context, '/signup');
                                    },
                                    child: const Row(
                                      children: [
                                        Text(
                                          'Don\'t have an account?',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Sign up',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 33, 243, 198)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      String? emailError =
                                          _emailValidator(_emailField.text);
                                      String? passwordError =
                                          _passwordValidator(
                                              _passwordField.text);
                                      emailErrorText = emailError;
                                      passwordErrorText = passwordError;

                                      _signIn();
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromARGB(255, 0, 29, 43),
                                      minimumSize: const Size(110, 50)),
                                  child: const Text('Log In',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.0,
                                      )),
                                ),
                                const SizedBox(height: 20.0),
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
                                    width: 230.0,
                                    child: ListTile(
                                      onTap: () {
                                        signInWithGoogle();
                                      },
                                      leading: Image.asset(
                                        'lib/assets/images/GLogo.png',
                                        height: 40,
                                      ),
                                      title: const Text(
                                        'Sign In with Google',
                                        style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 230.0,
                                ),
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

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailField.text;
    String password = _passwordField.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null && mounted) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("userEmail", user.email.toString());
      showToast(message: "User is successfully signed in");
      Navigator.pushReplacementNamed(context, "/mainhome", arguments: email);
    } else {
      showToast(message: "some error occured");
    }
  }

  // android: 1000242128101-8foqe2q5alk28akjm5r6q4aptb2iut7l.apps.googleusercontent.com

  _init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString("userEmail");
    if (email != null) {
      debugPrint('Email: $email');
      debugPrint('login if');
      Navigator.pushReplacementNamed(context, '/mainhome', arguments: {
        'email': email,
        'additionalString': 'You are already logged in'
      });
    } else if (email == 'No email provided') {
      Get.offAll(const Login());
      debugPrint('login else');
    }
  }

  signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId:
          '1015649823289-2u5nggd118gcj30rrv588474553q60o0.apps.googleusercontent.com',
    );

    try {
      // Sign out from Google to ensure the user gets prompted to choose an account
      await googleSignIn.signOut();

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
