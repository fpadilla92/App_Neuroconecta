import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailScreen extends StatelessWidget {
  final String docId; // El identificador único para borrar
  final Map<String, dynamic> data;

  const DetailScreen({super.key, required this.docId, required this.data});

  // Función para borrar con confirmación
  void _borrarEstrategia(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("¿Eliminar Estrategia?"),
        content: const Text("Esta acción no se puede deshacer."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx), // Cancelar
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              // 1. Borramos de Firebase
              await FirebaseFirestore.instance
                  .collection('estrategias')
                  .doc(docId)
                  .delete();
              
              // 2. Cerramos la alerta
              Navigator.pop(ctx);
              
              // 3. Volvemos a la pantalla anterior (Home)
              Navigator.pop(context);
              
              // 4. Avisamos que se borró
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Estrategia eliminada correctamente"))
              );
            },
            child: const Text("ELIMINAR", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data['titulo'] ?? 'Detalle'),
        actions: [
          // BOTÓN DE LIMPIAR / ELIMINAR
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.white),
            tooltip: 'Eliminar esta estrategia',
            onPressed: () => _borrarEstrategia(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.shade50, // Un tono rojizo suave para variar
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.psychology_alt, size: 80, color: Colors.teal),
              ),
            ),
            const SizedBox(height: 30),
            const Text("Título:", style: TextStyle(color: Colors.grey, fontSize: 16)),
            Text(
              data['titulo'] ?? '',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const Divider(height: 40, thickness: 2),
            const Text("Descripción:", style: TextStyle(color: Colors.grey, fontSize: 16)),
            const SizedBox(height: 10),
            Text(
              data['descripcion'] ?? 'Sin descripción',
              style: const TextStyle(fontSize: 18, height: 1.5),
              textAlign: TextAlign.justify,
            ),
            
            const SizedBox(height: 50),
            
            // Opcional: También un botón grande abajo si prefieres
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _borrarEstrategia(context),
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text("ELIMINAR ESTRATEGIA", style: TextStyle(color: Colors.red)),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  side: const BorderSide(color: Colors.red),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}