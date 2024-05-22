
import 'package:flutter/material.dart';

class MunicipioDetailPage extends StatelessWidget {
  final String municipio;
  final String description;
  final List<Map<String, String>> lugares;
  final List<String> imageUrls;

  const MunicipioDetailPage({super.key, 
    required this.municipio,
    required this.description,
    required this.lugares,
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(municipio),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Lugares a visitar:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Column(
                children: lugares.map((lugar) {
                  return ListTile(
                    title: Text(lugar['name']!),
                    subtitle: Text(lugar['description']!),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text(
                'Fotos:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Column(
                children: imageUrls.map((url) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Image.network(url),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
