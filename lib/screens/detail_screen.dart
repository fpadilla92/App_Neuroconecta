import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  // Recibimos los datos de la estrategia al abrir la pantalla
  const DetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data['titulo'] ?? 'Detalle'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icono grande decorativo
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.psychology, size: 80, color: Colors.teal),
              ),
            ),
            const SizedBox(height: 30),
            
            // Título
            const Text(
              "Estrategia:",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            Text(
              data['titulo'] ?? '',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const Divider(height: 40, thickness: 2),
            
            // Descripción
            const Text(
              "Descripción:",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              data['descripcion'] ?? 'Sin descripción',
              style: const TextStyle(fontSize: 18, height: 1.5),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}