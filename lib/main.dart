import 'package:flutter/material.dart';
import 'package:crowdvid/screens/home_screen.dart';
import 'package:crowdvid/screens/more_info_screen.dart';
import 'package:crowdvid/screens/prediction_info_screen.dart';
import 'package:crowdvid/screens/welcome_screen.dart';
import 'package:crowdvid/screens/login_screen.dart';
import 'package:crowdvid/screens/registration_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('es_MX', null).then((_) => runApp(const CrowdVid()));
}

class CrowdVid extends StatelessWidget {
  const CrowdVid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        MoreInfo.id: (context) => const MoreInfo(),
        PredictionInfo.id: (context) => const PredictionInfo(),
      },
    );
  }
}
