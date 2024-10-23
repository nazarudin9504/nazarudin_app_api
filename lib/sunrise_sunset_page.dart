import 'package:flutter/material.dart';
import 'sunrise_sunset_service.dart';

class SunriseSunsetPage extends StatefulWidget {
  @override
  _SunriseSunsetPageState createState() => _SunriseSunsetPageState();
}

class _SunriseSunsetPageState extends State<SunriseSunsetPage> {
  List<dynamic> _sunData = [];
  bool _isLoading = false;
  String _selectedMonth = '10'; // Default to October

  final Map<String, String> _months = {
    '01': 'January',
    '02': 'February',
    '03': 'March',
    '04': 'April',
    '05': 'May',
    '06': 'June',
    '07': 'July',
    '08': 'August',
    '09': 'September',
    '10': 'October',
    '11': 'November',
    '12': 'December',
  };

  Future<void> _fetchSunData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await fetchSunDataForMonth(_selectedMonth);
      setState(() {
        _sunData = data;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSunData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sunrise & Sunset'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Sunrise and Sunset Time in Pontianak',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 71, 71, 71),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text('Select Month: '),
                      SizedBox(width: 10),
                      DropdownButton<String>(
                        value: _selectedMonth,
                        items: _months.keys.map((String key) {
                          return DropdownMenuItem<String>(
                            value: key,
                            child: Text(_months[key]!),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedMonth = newValue!;
                          });
                          _fetchSunData(); // Fetch data for the selected month
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _sunData.isEmpty
                      ? Center(child: Text('No data available'))
                      : SingleChildScrollView(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('Date')),
                                DataColumn(label: Text('Dawn')),
                                DataColumn(label: Text('Sunrise')),
                                DataColumn(label: Text('Solar Noon')),
                                DataColumn(label: Text('Sunset')),
                                DataColumn(label: Text('Dusk')),
                                DataColumn(label: Text('Day Length')),
                              ],
                              rows: _sunData.map<DataRow>((dayData) {
                                return DataRow(
                                  cells: [
                                    DataCell(Text(dayData['date'])),
                                    DataCell(Text(dayData['dawn'])),
                                    DataCell(Text(dayData['sunrise'])),
                                    DataCell(Text(dayData['solar_noon'])),
                                    DataCell(Text(dayData['sunset'])),
                                    DataCell(Text(dayData['dusk'])),
                                    DataCell(Text(dayData['day_length'])),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                ),
              ],
            ),
    );
  }
}
