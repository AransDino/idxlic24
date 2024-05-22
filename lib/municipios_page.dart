import 'package:flutter/material.dart';
import 'municipio_detail_page.dart'; // Importa la nueva pantalla de detalles

class MunicipiosPage extends StatelessWidget {
  const MunicipiosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> municipios = [
      {'name': 'Arrecife', 'image': 'assets/images/arrecife.png'},
      {'name': 'Haría', 'image': 'assets/images/haría.png'},
      {'name': 'San Bartolomé', 'image': 'assets/images/san_bartolomé.png'},
      {'name': 'Teguise', 'image': 'assets/images/teguise.png'},
      {'name': 'Tías', 'image': 'assets/images/tías.png'},
      {'name': 'Tinajo', 'image': 'assets/images/tinajo.png'},
      {'name': 'Yaiza', 'image': 'assets/images/yaiza.png'},
      {'name': 'La Graciosa', 'image': 'assets/images/la_graciosa.png'}
    ];

    final Map<String, dynamic> detallesMunicipios = {
      'Arrecife': {
        'description': 'Arrecife es la capital de Lanzarote, famosa por su puerto y playas.',
        'lugares': [
          {'name': 'Charco de San Ginés', 'description': 'Una laguna de agua salada rodeada de casas de pescadores.'},
          {'name': 'Castillo de San Gabriel', 'description': 'Un castillo histórico en una pequeña isla cerca de la costa.'},
          {'name': 'Playa del Reducto', 'description': 'Una hermosa playa de arena dorada en el centro de la ciudad.'},
        ],
        'imageUrls': [
          'https://upload.wikimedia.org/wikipedia/commons/6/64/Arrecife_-_San_Gin%C3%A9s.jpg',
          'https://upload.wikimedia.org/wikipedia/commons/3/3a/Castillo_de_San_Gabriel_en_Arrecife.jpg',
          'https://upload.wikimedia.org/wikipedia/commons/5/5c/Playa_Del_Reducto%2C_Arrecife.jpg',
        ],
      },
      // Añade descripciones y lugares para otros municipios
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Municipios de Lanzarote'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1.0,
          ),
          itemCount: municipios.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: InkWell(
                onTap: () {
                  final municipio = municipios[index]['name']!;
                  final detalles = detallesMunicipios[municipio];
                  if (detalles != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MunicipioDetailPage(
                          municipio: municipio,
                          description: detalles['description'],
                          lugares: List<Map<String, String>>.from(detalles['lugares']),
                          imageUrls: List<String>.from(detalles['imageUrls']),
                        ),
                      ),
                    );
                  }
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        municipios[index]['image']!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        municipios[index]['name']!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
