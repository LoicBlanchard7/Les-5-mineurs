import 'package:flutter/material.dart';

class CreditPage extends StatefulWidget {
  const CreditPage({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<CreditPage> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 1,
      child: Container(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40, bottom: 300),
              child: const Text(
                'Crédits',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 75,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  shadows: [Shadow(blurRadius: 3, color: Colors.black)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
