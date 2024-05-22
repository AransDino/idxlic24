import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class ClasificacionPage extends StatefulWidget {
  final String categoria;

  const ClasificacionPage({super.key, required this.categoria});

  @override
  _ClasificacionPageState createState() => _ClasificacionPageState();
}

class _ClasificacionPageState extends State<ClasificacionPage> {
  List<dynamic> _teams = [];
  String _error = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final String response = await rootBundle.loadString('assets/ClasificacionBenjamin.json');
      print("Raw JSON data: $response");
      final data = await json.decode(response);
      setState(() {
        _teams = data['teams'];
      });
      print("Parsed data: $_teams");
    } catch (e) {
      setState(() {
        _error = "Error loading data: $e";
      });
      print("Error loading data: $e");
    }
  }

  Color _getRowColor(int index) {
    if (index < 7) {
      return Colors.green[200]!;
    } else if (index < 32) {
      return Colors.yellow[200]!;
    } else {
      return Colors.grey[300]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clasificación ${widget.categoria}'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
          ),
          if (_error.isNotEmpty)
            Center(child: Text(_error))
          else if (_teams.isEmpty)
            const Center(child: CircularProgressIndicator())
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(label: Text('Puesto')),
                    DataColumn(label: Text('Equipo')),
                    DataColumn(label: Text('Puntos')),
                    DataColumn(label: Text('Goles a Favor')),
                    DataColumn(label: Text('Goles en Contra')),
                    DataColumn(label: Text('Diferencia de Goles')),
                    DataColumn(label: Text('Tarjetas Amarillas')),
                    DataColumn(label: Text('Tarjetas Rojas')),
                  ],
                  rows: List<DataRow>.generate(
                    _teams.length,
                    (index) => DataRow(
                      color: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
                        return _getRowColor(index);
                      }),
                      cells: <DataCell>[
                        DataCell(Text(_teams[index]['Puesto'])),
                        DataCell(Text(_teams[index]['Equipo'])),
                        DataCell(Text(_teams[index]['PUNTOS'].toString())),
                        DataCell(Text(_teams[index]['G-A FAVOR'].toString())),
                        DataCell(Text(_teams[index]['G-ENCONTRA'].toString())),
                        DataCell(Text(_teams[index]['DIF-GOLES'].toString())),
                        DataCell(Text(_teams[index]['T-AMARILLA'].toString())),
                        DataCell(Text(_teams[index]['T.ROJA'].toString())),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
