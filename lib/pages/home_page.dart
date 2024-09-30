import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pruebas_para_prodtrack/pages/login_page.dart';
import 'package:pruebas_para_prodtrack/services/firebase_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userName; // Inicialmente nulo
  bool isLoading = true; // Indicador de carga
  final FirebaseService _firebaseService =
      FirebaseService(); // Instancia de FirebaseService

  @override
  void initState() {
    super.initState();
    _loadUserName(); // Cargar el nombre del usuario al iniciar la página
  }

  Future<void> _loadUserName() async {
    String? name =
        await _firebaseService.getUserName(); // Obtener el nombre del usuario
    setState(() {
      userName = name;
      isLoading = false; // Ocultar el indicador de carga
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('PRODTRACK'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Acción para la campana (por ahora puede estar vacía)
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Text(
                'Menú de navegación',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: Text('Opción 1'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Opción 2'),
              onTap: () {},
            ),
            Spacer(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar sesión'),
              onTap: () async {
                await _firebaseService.signOut();
                Get.offAll(() => LoginPage());
              },
            )
          ],
        ),
      ),
      body: isLoading
          ? Center(
              child:
                  CircularProgressIndicator()) // Mostrar un indicador de carga
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey,
                        child:
                            Icon(Icons.person, size: 40, color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      Text(
                        userName != null
                            ? 'Hola, $userName'
                            : 'Hola', // Mostrar el nombre del usuario si está disponible
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(16.0),
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    children: [
                      _buildGridItem(context, 'Inventario'),
                      _buildGridItem(context, 'Ingredientes'),
                      _buildGridItem(context, 'Proveedores'),
                      _buildGridItem(context, 'Facturas'),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildGridItem(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OutOfServicePage(title: title),
          ),
        );
      },
      child: Card(
        color: Colors.teal,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

// Página de "Fuera de servicio"
class OutOfServicePage extends StatelessWidget {
  final String title;

  OutOfServicePage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'La sección $title está fuera de servicio',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Regresar a la HomePage
              },
              child: Text('Regresar'),
            ),
          ],
        ),
      ),
    );
  }
}
