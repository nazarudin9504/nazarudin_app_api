import 'dart:convert';
import 'package:http/http.dart' as http;

// Function to fetch sun data for a specific month
Future<List<dynamic>> fetchSunDataForMonth(String month) async {
  final url = Uri.parse(
    'https://api.sunrisesunset.io/json?lat=-0.02056&lng=109.34139&date_start=2024-$month-01&date_end=2024-$month-30',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['results'];
  } else {
    throw Exception('Failed to load data');
  }
}
