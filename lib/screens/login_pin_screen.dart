import 'package:flutter/material.dart';

class LoginPinScreen extends StatefulWidget {
  final String userPhone;

  const LoginPinScreen({
    super.key,
    required this.userPhone,
  });

  @override
  State<LoginPinScreen> createState() => _LoginPinScreenState();
}

class _LoginPinScreenState extends State<LoginPinScreen> {
  String _pin = '';
  bool _obscurePin = true;
  final int _maxPinLength = 6;

  void _onNumberPressed(String number) {
    if (_pin.length < _maxPinLength) {
      setState(() {
        _pin += number;
      });
    }
  }

  void _onBackspacePressed() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  void _onBiometricPressed() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Autenticación biométrica'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _onLoginPressed() {
    if (_pin.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ingresa tu contraseña completa'),
          backgroundColor: Color(0xFFE53935),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('PIN ingresado: $_pin'),
        backgroundColor: const Color(0xFF0F9B92),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topPadding = MediaQuery.of(context).padding.top;

    // Paleta propia de YaloPago
    const bgGradientStart = Color(0xFF0B6E4F);
    const bgGradientEnd = Color(0xFF2E9E6B);
    const accentPrimary = Color(0xFFFF7A59);
    const textDark = Color(0xFF1E1B2E);
    const keypadNumColor = Color(0xFF4B5563);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Fondo degradado superior
          Container(
            height: size.height * 0.44,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [bgGradientStart, bgGradientEnd],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                // Contenido del header
                SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      // Botón de ayuda (?) superior derecho
                      Padding(
                        padding: const EdgeInsets.only(right: 22.0, top: 4.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.55),
                                  width: 1.4,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  '?',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Logo propio de YaloPago
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.15),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.6),
                            width: 1.5,
                          ),
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 14),

                      // "Bienvenid@" con la tipografía y color propios
                      const Text(
                        'Bienvenid@',
                        style: TextStyle(
                          color: accentPrimary,
                          fontSize: 22,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Teléfono del usuario
                      Text(
                        widget.userPhone,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. Tarjeta blanca curvada inferior
          Positioned(
            top: (size.height * 0.32) + (topPadding > 0 ? 0 : 10),
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 12,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Texto: Ingresa tu contraseña
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Ingresa tu contraseña',
                        style: TextStyle(
                          color: textDark,
                          fontSize: 15,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Display de PIN con toggle de visibilidad
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            _pin.isEmpty
                                ? ''
                                : (_obscurePin ? '●●●●●●'.substring(0, _pin.length) : _pin),
                            style: TextStyle(
                              fontSize: _obscurePin ? 18 : 20,
                              letterSpacing: _obscurePin ? 4.5 : 8.0,
                              color: textDark,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscurePin = !_obscurePin;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              _obscurePin
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              size: 22,
                              color: textDark.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Divider(
                      color: Color(0xFFCFD8DC),
                      thickness: 1.0,
                      height: 1,
                    ),
                    const SizedBox(height: 22),

                    // Teclado numérico circular con sombreado y elevación
                    _buildKeypad(keypadNumColor),
                    const SizedBox(height: 24),

                    // Botón de acción "Iniciar sesión"
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentPrimary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: _onLoginPressed,
                        child: const Text(
                          'Iniciar sesión',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Enlace ¿Olvidaste tu contraseña?
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(
                          color: textDark,
                          fontSize: 13,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Pie "Aplicación segura"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.lock_outline_rounded,
                          size: 14,
                          color: Color(0xFF90A4AE),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'Aplicación segura',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF78909C),
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeypad(Color numColor) {
    return Column(
      children: [
        _buildRow(['1', '2', '3'], numColor),
        const SizedBox(height: 14),
        _buildRow(['4', '5', '6'], numColor),
        const SizedBox(height: 14),
        _buildRow(['7', '8', '9'], numColor),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Botón huella dactilar
            _buildSpecialKey(
              icon: Icons.fingerprint_rounded,
              color: const Color(0xFFB0BEC5),
              onTap: _onBiometricPressed,
            ),
            _buildKey('0', numColor),
            // Botón borrar
            _buildSpecialKey(
              icon: Icons.backspace_outlined,
              color: const Color(0xFFB0BEC5),
              onTap: _onBackspacePressed,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRow(List<String> values, Color numColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: values.map((val) => _buildKey(val, numColor)).toList(),
    );
  }

  Widget _buildKey(String value, Color numColor) {
    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.07),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(31),
          onTap: () => _onNumberPressed(value),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 22,
                color: numColor,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialKey({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.04),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(31),
          onTap: onTap,
          child: Center(
            child: Icon(icon, color: color, size: 22),
          ),
        ),
      ),
    );
  }
}
