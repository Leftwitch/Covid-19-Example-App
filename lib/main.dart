import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_example/api/covid_api.dart';
import 'package:google_maps_example/model/covid_summary_entry.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const CovidHomePage(),
    );
  }
}

class CovidHomePage extends StatelessWidget {
  const CovidHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Covid 19 Zahlen',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<CovidSummaryEntry>>(
        future: getCovidSummary(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.map(_buildEntry).toList(),
          );
        },
      ),
    );
  }

  Widget _buildEntry(CovidSummaryEntry entry) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
          maxRadius: 30,
          child: Flag(
            entry.countryCode,
            height: 25,
            width: 100,
          ),
        ),
        title: Text(entry.country),
        isThreeLine: true,
        subtitle: Text(
            'Neu: ${entry.newConfirmed.toString()}, Gesamt: ${entry.totalConfirmed.toString()}'
            '\n'
            'Neue Tote: ${entry.newDeaths.toString()}, Gesamt: ${entry.totalDeaths.toString()}'),
      ),
    );
  }
}
