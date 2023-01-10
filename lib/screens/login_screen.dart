import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:crowdvid/components/rounded_button.dart';
import 'package:crowdvid/constants.dart';
import 'package:crowdvid/services/login_service.dart';
import 'package:crowdvid/screens/registration_screen.dart';
import 'package:crowdvid/models/user_model.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool showSpinner = false;
  late Future<User> futureUser;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 200.0,
                      child: Image.asset('images/login.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value.trim();
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Ingresa tu correo electrónico',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu correo electrónico.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value.trim();
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Ingresa tu contraseña',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu contraseña.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    title: 'Iniciar Sesión',
                    colour: Colors.lightGreen.shade700,
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        try {
                          final futureUser = await fetchUser(email, password);
                          if (!mounted) return;
                          if (futureUser.code == 200) {
                            Navigator.pushReplacementNamed(
                              context,
                              HomeScreen.id,
                              arguments: futureUser,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 3),
                                content: Text(
                                  'Usuario y/o contraseña incorrectos',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            );
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      } else {
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        '¿Aún no tienes una cuenta?',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      InkWell(
                        child: const Text(
                          'Registrate',
                          style: TextStyle(
                            color: Color(0xFF689F38),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        onTap: () => Navigator.pushReplacementNamed(
                            context, RegistrationScreen.id),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
