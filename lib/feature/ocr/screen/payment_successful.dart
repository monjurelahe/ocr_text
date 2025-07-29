import 'package:flutter/material.dart';

class PaymentSuccessful extends StatelessWidget {
  final String extractedText;

  const PaymentSuccessful({super.key, required this.extractedText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.qr_code_2_rounded, size: 120),
            SizedBox(height: 20),
            Text("Payment is Successful", style: TextStyle(fontSize: 18)),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(extractedText, textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
