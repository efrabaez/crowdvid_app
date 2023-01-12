import 'package:crowdvid/components/simple_card.dart';
import 'package:crowdvid/models/place_model.dart';
import 'package:crowdvid/models/user_model.dart';
import 'package:crowdvid/screens/login_screen.dart';
import 'package:crowdvid/screens/more_info_screen.dart';
import 'package:crowdvid/screens/prediction_info_screen.dart';
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightGreen.shade700,
      ),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          return SimpleCard(
            title: places[index].name,
            subtitle:
                'Los sensores se encuentran ubicados en la entrada y salida correspondiente.',
            entrance:
                'Entradas: ${places[index].placeId > 2 ? 'Sin información' : _getSensorEntranceData(places[index].placeId)}',
            exit:
                'Salidas: ${places[index].placeId > 2 ? 'Sin información' : _getSensorExitData(places[index].placeId)}',
            primaryButtonTitle: 'Ir a histórico',
            secondaryButtonTitle: 'Ir a predicción',
            colour: const Color(0xff689F38),
            icon: Icons.store,
            onPressedPrimaryButton: () {
              Navigator.pushNamed(
                context,
                MoreInfo.id,
                arguments: places[index],
              );
            },
            onPressedSecondaryButton: () {
              Navigator.pushNamed(
                context,
                PredictionInfo.id,
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

  int _getSensorEntranceData(int idPlace) {
    return idPlace == 1 ? schoolEntranceSensor : govtBuildingEntranceSensor;
  }

  int _getSensorExitData(int idPlace) {
    return idPlace == 1 ? schoolExitSensor : govtBuildingExitSensor;
  }
}
