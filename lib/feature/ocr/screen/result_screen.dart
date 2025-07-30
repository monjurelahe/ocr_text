import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String extractedText;

  const ResultScreen({Key? key, required this.extractedText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> lines = extractedText.split('\n');

    return Scaffold(
      appBar: AppBar(title: Text('Extracted Result')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: lines.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: TextEditingController(text: lines[index]),
                decoration: InputDecoration(
                  labelText: 'Line ${index + 1}',
                  border: OutlineInputBorder(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
