import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:crowdvid/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 60.0,
                    child: Image.asset('images/covid-icon.png'),
                  ),
                ),
                const Spacer(flex: 1),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Crowdvid',
                      textStyle: const TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff689F38),
                      ),
                      speed: const Duration(milliseconds: 500),
                    ),
                  ],
                  totalRepeatCount: 4,
                  pause: const Duration(milliseconds: 750),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
                const Spacer(flex: 3),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Iniciar sesión',
              colour: Colors.lightGreen.shade700,
              onPressed: () {
                Navigator.pushReplacementNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              title: 'Registro',
              colour: Colors.lightGreen.shade700,
              onPressed: () {
                Navigator.pushReplacementNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
