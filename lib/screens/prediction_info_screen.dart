import 'package:crowdvid/models/place_model.dart';
import 'package:crowdvid/models/statistics_model.dart';
import 'package:crowdvid/services/get_place_prediction_statistics.dart';
import 'package:crowdvid/services/get_place_statistics_by_date.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PredictionInfo extends StatefulWidget {
  const PredictionInfo({Key? key}) : super(key: key);
  static const String id = 'prediction_info_screen';

  @override
  State<PredictionInfo> createState() => _PredictionInfoState();
}

class _PredictionInfoState extends State<PredictionInfo> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  final DateTime _currentTime = DateTime.now();
  final DateFormat _dateFormat = DateFormat('MM/dd/yyyy');

  late DateTime _focusedDay = _currentTime;
  late DateTime _selectedDay = _currentTime;
  late String selectedDayFormatted = _dateFormat.format(_currentTime);
  List<Statistics> statistics = [];
  late Place args;
  late TooltipBehavior _tooltip;

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)!.settings.arguments as Place;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    // TODO: implement initState
    super.initState();
    _loadStatistics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predicción en: ${args.name}'),
        backgroundColor: Colors.lightGreen.shade700,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TableCalendar(
            calendarFormat: _calendarFormat,
            locale: 'es_MX',
            firstDay: _currentTime.subtract(Duration(days: 10)),
            lastDay: DateTime.now().add(const Duration(days: 4)),
            focusedDay: _focusedDay,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                selectedDayFormatted = _dateFormat.format(_selectedDay);
                _loadStatistics();
              });
            },
          ),
          Container(
              margin: const EdgeInsets.only(top: 10),
              width: 350,
              height: 300,
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  tooltipBehavior: _tooltip,
                  series: <ChartSeries<Statistics, String>>[
                    ColumnSeries<Statistics, String>(
                        dataSource: statistics,
                        xValueMapper: (Statistics data, _) =>
                            DateFormat('HH:mm').format(data.datetime),
                        yValueMapper: (Statistics data, _) => data.ocupability,
                        name: 'Gold',
                        color: Colors.lightGreen.shade700)
                  ])),
        ],
      ),
    );
  }

  _loadStatistics() async {
    final int placeId = args.placeId;
    debugPrint(placeId.toString());
    statistics = await fetchPlacePredictionStatistics(placeId, _selectedDay);
    debugPrint('$statistics');
    setState(() {
      statistics;
    });
  }
}
