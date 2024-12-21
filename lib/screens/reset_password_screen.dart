import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> resetPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Firebase не поддерживает OTP через email напрямую
        // Поэтому используется функция сброса пароля
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: widget.email,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Құпиясөз сәтті өзгертілді!')),
        );
        Navigator.pushNamed(context, '/');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Қате! ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Жаңа құпиясөзді енгізіңіз'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Жаңа құпиясөз',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Жаңа құпиясөз енгізіңіз',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Құпиясөзді енгізіңіз';
                  }
                  if (value.length < 6) {
                    return 'Құпиясөз кемінде 6 таңбадан тұруы керек';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: resetPassword,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  backgroundColor: Colors.blueAccent,
                ),
                child: const Text('Құпиясөзді өзгерту',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
