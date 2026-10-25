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
  runApp(const YaloPagoApp());
}

class YaloPagoApp extends StatelessWidget {
  const YaloPagoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YaloPago',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Quicksand',
        useMaterial3: true,
      ),
      home: const LoginPinScreen(userPhone: '71234567'),
    );
  }
}
