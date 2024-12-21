import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Кіру сәтті өтті!')));
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'Қате! Электрондық пошта немесе құпиясөз дұрыс емес.';
        if (e.code == 'user-not-found') {
          errorMessage = 'Пайдаланушы табылмады.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Құпиясөз қате.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Кіру',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text('Электронды пошта немесе телефон',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Электронды поштаңызды енгізіңіз',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Электронды поштаңызды енгізіңіз';
                  }
                  if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}").hasMatch(value)) {
                    return 'Қате пошта форматы';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text('Құпиясөз',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Құпиясөзіңізді енгізіңіз',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: const Icon(Icons.visibility_off),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Құпиясөзіңізді енгізіңіз';
                  }
                  if (value.length < 6) {
                    return 'Құпиясөз кемінде 6 таңбадан тұруы керек';
                  }
                  return null;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgot-password');
                  },
                  child: const Text('Құпиясөзді ұмыттыңыз ба?',
                      style: TextStyle(color: Colors.blueAccent)),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  backgroundColor: Colors.blueAccent,
                ),
                child: const Text('Кіру',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              const Center(
                  child: Text('немесе әлеуметтік желі арқылы кіріңіз',
                      style: TextStyle(fontSize: 14))),
              const SizedBox(height: 16),
              socialLoginButton('images/google.png', 'Google арқылы кіру'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Аккаунт жоқ па?',
                      style: TextStyle(fontSize: 14)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text('Тіркелу',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget socialLoginButton(String asset, String label) {
    return ElevatedButton.icon(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      icon: Image.asset(asset, width: 24),
      label: Text(
        label,
        style: const TextStyle(color: Colors.black, fontSize: 14),
      ),
    );
  }
}
