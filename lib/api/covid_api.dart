// API URL: https://api.covid19api.com/summary

import 'dart:convert';

import 'package:google_maps_example/model/covid_summary_entry.dart';
import 'package:http/http.dart' as http;

Future<List<CovidSummaryEntry>> getCovidSummary() async {
  final url = Uri.parse('https://api.covid19api.com/summary');

  final response = await http.get(url);

  return List<CovidSummaryEntry>.from(json
      .decode(response.body)["Countries"]
      .map((x) => CovidSummaryEntry.fromJson(x)));
}
