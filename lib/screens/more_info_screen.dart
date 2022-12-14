import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:graphic/graphic.dart';

class MoreInfo extends StatefulWidget {
  const MoreInfo({Key? key}) : super(key: key);
  static const String id = 'more_info_screen';

  @override
  State<MoreInfo> createState() => _MoreInfoState();
}

class _MoreInfoState extends State<MoreInfo> {
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    debugPrint('More info: ${arguments['arguments'].toString()}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrada de UPIITA'),
        backgroundColor: Colors.lightGreen.shade700,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TableCalendar(
            calendarFormat: _calendarFormat,
            locale: 'es_MX',
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 350,
            height: 300,
            child: Chart(
              data: [
                {
                  'fecha': DateFormat.jm().format(DateTime.now()),
                  'concurrencia': 275
                },
                {
                  'fecha': DateFormat.jm().format(
                    DateTime.now().add(Duration(minutes: 10)),
                  ),
                  'concurrencia': 115
                },
                {
                  'fecha': DateFormat.jm().format(
                    DateTime.now().add(Duration(minutes: 20)),
                  ),
                  'concurrencia': 120
                },
                {
                  'fecha': DateFormat.jm().format(
                    DateTime.now().add(Duration(minutes: 30)),
                  ),
                  'concurrencia': 350
                },
                {
                  'fecha': DateFormat.jm().format(
                    DateTime.now().add(Duration(minutes: 40)),
                  ),
                  'concurrencia': 150
                },
              ],
              variables: {
                'fecha': Variable(
                  accessor: (Map map) => map['fecha'] as String,
                ),
                'concurrencia': Variable(
                  accessor: (Map map) => map['concurrencia'] as num,
                ),
              },
              elements: [IntervalElement()],
              axes: [
                Defaults.horizontalAxis,
                Defaults.verticalAxis,
              ],
            ),
          )
        ],
      ),
    );
  }
}
