import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class RegisterPage extends StatelessWidget {
  final AuthController _authController =
      Get.put(AuthController()); // Crear una instancia del controlador.
  final TextEditingController _nameController =
      TextEditingController(); // Controlador para el nombre.
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
                'Registro',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              SizedBox(height: 40),
              _buildTextField(context, 'Nombre', _nameController),
              SizedBox(height: 20),
              _buildTextField(context, 'Email', _emailController),
              SizedBox(height: 20),
              _buildTextField(context, 'Contraseña', _passwordController,
                  obscureText: true),
              SizedBox(height: 40),
              Obx(() => _authController.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : _buildRegisterButton(context)), // Botón para registrarse.
              Spacer(),
              Center(
                child: GestureDetector(
                  onTap: () => Get.back(), // Volver a la página de login.
                  child: Text(
                    '¿Ya tienes cuenta? Inicia sesión',
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

  // Widget para los campos de texto.
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

  // Botón para registrarse.
  Widget _buildRegisterButton(BuildContext context) {
    return Center(
      child: FilledButton(
        onPressed: () {
          String name = _nameController.text.trim();
          String email = _emailController.text.trim();
          String password = _passwordController.text.trim();
          _authController.register(email, password,
              name); // Llamar al método de registro en el controlador.
        },
        child: Text(
          'Registrarse',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
