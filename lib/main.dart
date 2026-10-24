import 'package:flutter/material.dart';
import 'screens/login_pin_screen.dart';

void main() {
  runApp(const YastaApp());
}

class YastaApp extends StatelessWidget {
  const YastaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yasta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF009688),
          primary: const Color(0xFF00897B),
        ),
        useMaterial3: true,
      ),
      home: const LoginPinScreen(userPhone: '68763153'),
    );
  }
}
