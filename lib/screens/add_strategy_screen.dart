import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddStrategyScreen extends StatefulWidget {
  const AddStrategyScreen({super.key});
  @override
  State<AddStrategyScreen> createState() => _AddStrategyScreenState();
}

class _AddStrategyScreenState extends State<AddStrategyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descController = TextEditingController();
  
  // Guardar en Firestore
  Future<void> _guardarEstrategia() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('estrategias').add({
        'titulo': _tituloController.text,
        'descripcion': _descController.text,
        'categoria': 'General', // Podrías hacerlo un Dropdown
        'fecha': Timestamp.now(),
      });
      Navigator.pop(context); // Volver atrás
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nueva Estrategia")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(labelText: "Título de la estrategia"),
                validator: (val) => val!.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descController,
                maxLines: 5,
                decoration: const InputDecoration(labelText: "Descripción detallada"),
                validator: (val) => val!.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _guardarEstrategia,
                  icon: const Icon(Icons.save),
                  label: const Text("GUARDAR ESTRATEGIA"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}// TODO Implement this library.