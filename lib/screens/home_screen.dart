import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_strategy_screen.dart';
import 'profile_screen.dart';
import 'detail_screen.dart'; // Importamos la nueva pantalla

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Controla qué botón de la barra está activo

  // Lista de pantallas para la barra de navegación
  final List<Widget> _pages = [
    const StrategyList(), // Definida abajo
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Muestra la pantalla según el índice seleccionado
      body: _pages[_selectedIndex],
      
      // LA BARRA DE NAVEGACIÓN (Bottom Navigation Bar)
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

// Widget separado para la lista, así el código queda limpio
class StrategyList extends StatelessWidget {
  const StrategyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Muro de Estrategias")),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddStrategyScreen())),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('estrategias').orderBy('fecha', descending: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          
          if (snapshot.data!.docs.isEmpty) {
             return const Center(child: Text("No hay estrategias aún. ¡Agrega una!"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              var data = doc.data() as Map<String, dynamic>; // Extraer datos

              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal.shade100,
                    child: const Icon(Icons.lightbulb, color: Colors.teal),
                  ),
                  title: Text(doc['titulo'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    doc['descripcion'], 
                    maxLines: 1, 
                    overflow: TextOverflow.ellipsis // Puntos suspensivos si es muy largo
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // AQUÍ CONECTAMOS CON LA PANTALLA DE DETALLE (Pantalla 5)
                    Navigator.push(context, MaterialPageRoute(
                      builder: (_) => DetailScreen(data: data, docId: '',)
                    ));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}