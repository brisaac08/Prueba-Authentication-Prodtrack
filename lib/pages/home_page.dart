import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        centerTitle: true,
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
            ),
          ],
        ),
      ),
      body: isLoading
          ? Center(
              child:
                  CircularProgressIndicator()) // Mostrar un indicador de carga
          : Column(
              children: [
                // Encabezado con saludo y versículo
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[300],
                        child: Icon(Icons.person, size: 50),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName != null ? 'Hola,\n$userName' : 'Hola',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Bendito sea Jehová, mi roca,\nquien adiestra mis manos\npara la batalla, y mis dedos\npara la guerra.\n\nSalmo 144:1',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Cuatro botones
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(16.0),
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    children: [
                      menuButton(context, 'INVENTARIO', Icons.warehouse,
                          Colors.blue, null), // Página no disponible
                      menuButton(context, 'INGREDIENTES', Icons.filter_alt,
                          Colors.green, null), // Página no disponible
                      menuButton(context, 'PROVEEDORES', Icons.business,
                          Colors.orange, null), // Página no disponible
                      menuButton(context, 'FACTURAS', Icons.receipt, Colors.red,
                          null), // Página no disponible
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  // Widget para crear los botones del menú
  Widget menuButton(BuildContext context, String title, IconData icon,
      Color color, Widget? page) {
    return GestureDetector(
      onTap: () {
        if (page != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        } else {
          // Mostrar un Snackbar cuando no haya página disponible
          Get.snackbar(
            "Página no disponible",
            "Esta sección aún no está disponible.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
        }
      },
      child: Card(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            SizedBox(height: 10),
            Text(title, style: TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
