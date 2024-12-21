import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isEmailVerified = false;
  bool isResendEmail = false;

  @override
  void initState() {
    super.initState();
    _checkEmailVerified();
    _startEmailVerificationCheck();
  }

  // Проверка верификации email
  Future<void> _checkEmailVerified() async {
    User? user = _auth.currentUser;
    await user?.reload(); // Перезагрузка пользователя
    setState(() {
      isEmailVerified = user?.emailVerified ?? false;
    });

    if (isEmailVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email сәтті расталды!')),
      );
      Navigator.pushReplacementNamed(context, '/'); // Перенаправляем на главную
    }
  }

  // Таймер для автоматической проверки
  void _startEmailVerificationCheck() {
    Future.delayed(const Duration(seconds: 3), () async {
      await _checkEmailVerified();
      if (!isEmailVerified) {
        _startEmailVerificationCheck(); // Повторяем, пока не будет верификации
      }
    });
  }

  // Повторная отправка email
  Future<void> _resendVerificationEmail() async {
    try {
      final user = _auth.currentUser;
      await user?.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Растау коды қайта жіберілді!')),
      );
      setState(() {
        isResendEmail = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Қате: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Растау'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.email, size: 100, color: Colors.blueAccent),
            const SizedBox(height: 16),
            const Text(
              'Электрондық поштаға растау коды жіберілді.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              _auth.currentUser?.email ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            if (!isEmailVerified)
              ElevatedButton(
                onPressed: _resendVerificationEmail,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.blueAccent,
                ),
                child: const Text('Қайта жіберу'),
              ),
            if (isResendEmail)
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'Қайта жіберілді. Поштаңызды тексеріңіз.',
                  style: TextStyle(color: Colors.green),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
