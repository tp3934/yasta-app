import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/login_pin_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
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
        fontFamily: 'Flexo',
        useMaterial3: true,
      ),
      home: const LoginPinScreen(userPhone: '68763153'),
    );
  }
}
