import 'package:crowdvid/components/simple_card.dart';
import 'package:crowdvid/models/user_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crowdvid'),
        backgroundColor: Colors.lightGreen.shade700,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF689F38),
              ),
              child: Text(
                'Bienvenido ${args.name} ${args.lastName}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text(
                'Pronósticos',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.account_circle),
              title: Text(
                'Mi perfil',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SimpleCard(
              title: 'Entrada de la UPIITA',
              subtitle:
                  'Los sensores se encuentran ubicados en la caseta de vigilancia.',
              buttonTitle: 'Ver más',
              colour: const Color(0xff689F38),
              icon: Icons.store,
              onPressed: () {
                debugPrint('Home_screen Pressed');
              }),
          SimpleCard(
              title: 'Edificio de gobierno',
              subtitle:
                  'Los sensores se encuentran ubicados en los laterales de las puertas de cristal.',
              buttonTitle: 'Ver más',
              colour: const Color(0xff689F38),
              icon: Icons.maps_home_work,
              onPressed: () {
                debugPrint('Home_screen Pressed');
              }),
        ],
      ),
    );
  }
}
