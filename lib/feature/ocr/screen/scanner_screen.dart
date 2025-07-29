import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:ocr_text/feature/ocr/screen/payment_successful.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _showPickOptions(); // Ask user for image immediately
  }

  void _showPickOptions() async {
    await Future.delayed(Duration(milliseconds: 100)); // Ensure build completes
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Select Image Source"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
            child: Text("Open Camera"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
            child: Text("Choose from Gallery"),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? imageFile = await _picker.pickImage(source: source);
    if (imageFile == null) return;

    final text = await _extractText(File(imageFile.path));
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PaymentSuccessful(extractedText: text),
        ),
      );
    }
  }

  Future<String> _extractText(File file) async {
    final inputImage = InputImage.fromFile(file);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText = await textRecognizer.processImage(
      inputImage,
    );
    return recognizedText.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Check'),
        centerTitle: true,
        leading: BackButton(),
      ),
      body: Center(
        child: Text("Waiting for image...", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
