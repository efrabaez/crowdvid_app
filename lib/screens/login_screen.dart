import 'package:crowdvid/services/login_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:crowdvid/components/rounded_button.dart';
import 'package:crowdvid/constants.dart';
import 'package:crowdvid/models/user_model.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Future<User> futureUser;

  bool showSpinner = false;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/login.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Ingresa tu correo'),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Ingresa tu contraseña'),
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Log In',
                colour: Colors.lightGreen.shade700,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    //final user = await _auth.signInWithEmailAndPassword(
                    //    email: email, password: password);
                    final futureUser = await fetchUser();
                    debugPrint(futureUser.toString());
                    //Navigator.pushNamed(context, HomeScreen.id);
                    if (!mounted) return;
                    //Navigator.pushReplacementNamed(context, HomeScreen.id,
                    //  arguments: {'user': futureUser});
                    Navigator.pushReplacementNamed(
                      context,
                      HomeScreen.id,
                      arguments: {'arguments': futureUser},
                    );
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    if (kDebugMode) {
                      print(e);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
