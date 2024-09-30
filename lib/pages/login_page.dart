import 'package:pruebas_para_prodtrack/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  final AuthController _authController =
      Get.put(AuthController()); // Crear una instancia del controlador.
  final TextEditingController _emailController =
      TextEditingController(); // Controlador para el email.
  final TextEditingController _passwordController =
      TextEditingController(); // Controlador para la contraseña.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text(
                'Login',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              SizedBox(height: 40),
              _buildTextField(context, 'Email', _emailController),
              SizedBox(height: 20),
              _buildTextField(context, 'Contraseña', _passwordController,
                  obscureText: true),
              SizedBox(height: 40),
              Obx(() => _authController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator()) // Mostrar cargando.
                  : _buildLoginButton(context)), // Mostrar botón de login.
              Spacer(),
              Center(
                child: GestureDetector(
                  onTap: () => Get.to(
                      RegisterPage()), // Navegar a la página de registro.
                  child: Text(
                    '¿No tienes cuenta? Regístrate',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget para los campos de texto (email y contraseña).
  Widget _buildTextField(
      BuildContext context, String hintText, TextEditingController controller,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: hintText,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  // Botón para iniciar sesión.
  Widget _buildLoginButton(BuildContext context) {
    return Center(
      child: FilledButton(
        onPressed: () {
          String email = _emailController.text.trim();
          String password = _passwordController.text.trim();
          _authController.login(
              email, password); // Llamar al método de login en el controlador.
        },
        child: Text(
          'Iniciar Sesión',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
