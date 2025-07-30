import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ocr_text/core/const/text_styles.dart';
import 'package:ocr_text/feature/ocr/models/reading_data.dart';

class ResultScreen extends StatelessWidget {
  final ReadingData data;
  final File? attachment;

  const ResultScreen({
    super.key,
    required this.data,
    required this.attachment,
    required String extractedText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f8fe),
      appBar: AppBar(
        title: const Text('Opening Reading'),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            _buildTitle("Date"),
            _labelField("Date", data.date),
            _labelField("Shift", data.shift),
            _labelField("Fuel Type", data.fuelType1),
            _labelField("Volume", data.volume1),
            _labelField("90% Ullage", data.ullage1),
            _labelField("Fuel Type", data.fuelType2),
            _labelField("Volume", data.volume2),
            _labelField("90% Ullage", data.ullage2),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Attachment",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10),
              ),
              child: attachment != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(attachment!, fit: BoxFit.cover),
                    )
                  : const Center(child: Icon(Icons.upload, size: 10)),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 43,
              child: Center(child: linearButton('Submit')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(bottom: 6.h, top: 12.h),
        child: Text(text, style: TextStyle(fontSize: 13)),
      ),
    );
  }

  Widget _labelField(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: TextEditingController(text: value),
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          alignLabelWithHint: false,
          hintText: "Enter $label",
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
