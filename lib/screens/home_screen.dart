import 'package:crowdvid/components/simple_card.dart';
import 'package:crowdvid/models/place_model.dart';
import 'package:crowdvid/models/user_model.dart';
import 'package:crowdvid/screens/more_info_screen.dart';
import 'package:crowdvid/services/get_pip_data_service.dart';
import 'package:flutter/material.dart';

import 'package:crowdvid/services/get_places_service.dart';
import 'package:crowdvid/services/constants.dart' as constants;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Place> places = [];
  int schoolEntranceSensor = 0;
  int schoolExitSensor = 0;
  int govtBuildingEntranceSensor = 0;
  int govtBuildingExitSensor = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPlaces();
    _fetchPipData();
  }

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
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          return SimpleCard(
            title: places[index].name,
            subtitle:
                'Los sensores se encuentran ubicados en la entrada y salida correspondiente.',
            entrance:
                'Entradas: ${places[index].placeId == 1 ? schoolEntranceSensor : govtBuildingEntranceSensor}',
            exit:
                'Salidas: ${places[index].placeId == 1 ? schoolExitSensor : govtBuildingExitSensor}',
            buttonTitle: 'Ir a histórico',
            colour: const Color(0xff689F38),
            icon: Icons.store,
            onPressed: () {
              Navigator.pushNamed(
                context,
                MoreInfo.id,
                arguments: places[index],
              );
            },
          );
        },
      ),
    );
  }

  _loadPlaces() async {
    places = await fetchPlaces();
    setState(() {
      places;
    });
  }

  _fetchPipData() async {
    schoolEntranceSensor = await fetchPipData(constants.pipSchoolEntrance);
    schoolExitSensor = await fetchPipData(constants.pipSchoolExit);
    govtBuildingEntranceSensor =
        await fetchPipData(constants.pipGovBuildingEntrance);
    govtBuildingExitSensor = await fetchPipData(constants.pipGovBuildingExit);

    setState(() {
      schoolEntranceSensor;
      schoolExitSensor;
      govtBuildingEntranceSensor;
      govtBuildingExitSensor;
    });
  }
}
