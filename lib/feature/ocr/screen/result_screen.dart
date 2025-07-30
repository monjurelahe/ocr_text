import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ocr_text/core/const/text_styles.dart';
import 'package:ocr_text/feature/ocr/models/reading_data.dart';
import '../models/reading_data.dart';

class ResultScreen extends StatelessWidget {
  final ReadingData data;
  final File? attachment;

  const ResultScreen({
    Key? key,
    required this.data,
    required this.attachment,
    required String extractedText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opening Reading'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _labelField("Date", data.date),
            _labelField("Shift", data.shift),
            _labelField("Fuel Type", data.fuelType1),
            _labelField("Volume", data.volume1),
            _labelField("90% Ullage", data.ullage1),
            _labelField("Fuel Type", data.fuelType2),
            _labelField("Volume", data.volume2),
            _labelField("90% Ullage", data.ullage2),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Attachment",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: attachment != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(attachment!, fit: BoxFit.cover),
                    )
                  : const Center(child: Icon(Icons.upload, size: 40)),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: linearButton('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _labelField(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: TextEditingController(text: value),
        decoration: InputDecoration(
          labelText: label,
          hintText: "Enter $label",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
