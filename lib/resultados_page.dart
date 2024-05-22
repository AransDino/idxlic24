import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class ResultadosPage extends StatefulWidget {
  const ResultadosPage({super.key});

  @override
  _ResultadosPageState createState() => _ResultadosPageState();
}

class _ResultadosPageState extends State<ResultadosPage> {
  List<dynamic> _resultados = [];
  String _error = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final String response = await rootBundle.loadString('assets/ResultadosPartidos.json');
      final data = await json.decode(response);
      setState(() {
        _resultados = data['ResultadosPartidos'];
      });
    } catch (e) {
      setState(() {
        _error = "Error loading data: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados Partidos'),
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
          else if (_resultados.isEmpty)
            const Center(child: CircularProgressIndicator())
          else
            ListView.builder(
              itemCount: _resultados.length,
              itemBuilder: (context, index) {
                final resultado = _resultados[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/${resultado['logolocal'] ?? 'default.png'}',
                                  height: 50,
                                  width: 50,
                                ),
                                Text(resultado['Nombre Equipo Local']),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  '${resultado['G. Local']} - ${resultado['G Visit']}',
                                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${resultado['FECHA']} | ${resultado['HORA']}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text('SEDE: ${resultado['SEDE']}'),
                                const Text('FINALIZADO'),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/${resultado['logovisitante'] ?? 'default.png'}',
                                  height: 50,
                                  width: 50,
                                ),
                                Text(resultado['Nombre Equipo Visitante']),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
