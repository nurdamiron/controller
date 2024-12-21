import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Подключаем сгенерированный файл
import 'package:controller_app/screens/login_screen.dart';
import 'package:controller_app/screens/signup_screen.dart';
import 'package:controller_app/screens/verify_screen.dart';
import 'package:controller_app/screens/forgot_password_screen.dart';
import 'package:controller_app/screens/reset_password_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Кіру және Тіркелу',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      // Генератор маршрутов
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => const LoginScreen(),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          case '/signup':
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => const SignUpScreen(),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          case '/verify':
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => const VerifyScreen(),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          case '/forgot-password':
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => const ForgotPasswordScreen(),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          case '/reset-password':
            final args = settings.arguments as Map<String, dynamic>;
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) =>
                  ResetPasswordScreen(email: args['email']),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
        // Добавляем маршрут для верификации
          case '/verifyReset':
            final args = settings.arguments as Map<String, dynamic>;
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) =>
                  ResetPasswordScreen(email: args['email']),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          default:
            return null; // Если маршрут не найден
        }
      },
    );
  }
}
