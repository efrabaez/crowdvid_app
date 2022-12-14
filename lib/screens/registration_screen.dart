import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:crowdvid/components/rounded_button.dart';
import 'package:crowdvid/constants.dart';
import 'package:crowdvid/services/register_service.dart';
import 'package:crowdvid/screens/login_screen.dart';
import 'package:crowdvid/models/user_model.dart';
import 'home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static const String id = 'chat_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  bool showSpinner = false;
  late Future<User> futureUser;
  late String email;
  late String password;
  late String name;
  late String lastname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        '┬íRegistrate ahora!',
                        style: kTextTitleStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 50.0),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      name = value.trim();
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Ingresa tu(s) nombre(s)',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu nombre.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      lastname = value.trim();
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Ingresa tu(s) apellido(s)',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu apellido.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value.trim();
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Ingresa tu correo electr├│nico',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu correo electr├│nico.';
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
                      hintText: 'Ingresa tu contrase├▒a',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu contrase├▒a.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    title: 'Registro',
                    colour: Colors.lightGreen.shade700,
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        try {
                          final futureUser =
                              await createUser(email, password, name, lastname);
                          if (!mounted) return;
                          if (futureUser.code == 200) {
                            Navigator.pushReplacementNamed(
                              context,
                              HomeScreen.id,
                              arguments: futureUser,
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
                        '┬┐Ya tienes una cuenta?',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      InkWell(
                        child: const Text(
                          'Inicia sesi├│n',
                          style: TextStyle(
                            color: Color(0xFF689F38),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        onTap: () => Navigator.pushReplacementNamed(
                            context, LoginScreen.id),
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
