import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pruebas_para_prodtrack/pages/login_page.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase dependiendo de si es web o no
  if (GetPlatform.isWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey:
            "AIzaSyACIL5g22ATUJV0UaGvEfgR0x5I1h_chfg", // Nuevas credenciales
        authDomain: "prueba-authentication-d7773.firebaseapp.com",
        projectId: "prueba-authentication-d7773",
        storageBucket: "prueba-authentication-d7773.appspot.com",
        messagingSenderId: "824989027543",
        appId:
            "1:824989027543:web:e29cae70605de417957492", // Nuevas credenciales
      ),
    );
  } else {
    // Para entornos móviles (Android/iOS), se inicializa de manera automática con el archivo google-services.json/GoogleService-Info.plist
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Authentication',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
