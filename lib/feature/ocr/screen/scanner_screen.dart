import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:ocr_text/core/const/image_path.dart';
import 'package:ocr_text/core/const/text_styles.dart';
import 'package:ocr_text/feature/ocr/screen/payment_successful.dart';
import 'package:ocr_text/feature/ocr/screen/text_storage.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  File? selectedMedia;

  @override
  void initState() {
    super.initState();
    _pickImageAndExtractText();
  }

  Future<void> _pickImageAndExtractText() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final text = await _extractText(imageFile);
      if (text.isNotEmpty) {
        TextStorage.extractedText = text;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PaymentSuccessful()),
        );
      }
    }
  }

  Future<String> _extractText(File file) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final inputImage = InputImage.fromFile(file);
    final recognizedText = await textRecognizer.processImage(inputImage);
    return recognizedText.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF3F8),
        elevation: 0,
        title: Text('Payment Check', style: headingText(Colors.black)),
        centerTitle: true,
        leading: Icon(Icons.arrow_back_ios_new_outlined),
      ),
      body: Center(child: Image.asset(ImagePath.ocr, width: 200)),
    );
  }
}
