import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import '../models/reading_data.dart';
import 'result_screen.dart';

class TankReading extends StatefulWidget {
  const TankReading({super.key});

  @override
  State<TankReading> createState() => _TankReadingState();
}

class _TankReadingState extends State<TankReading> {
  File? _imageFile;

  // Show dialog to choose image source
  Future<void> _pickImage() async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Choose Image Source"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _getImage(ImageSource.camera);
            },
            child: const Text("Camera"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _getImage(ImageSource.gallery);
            },
            child: const Text("Gallery"),
          ),
        ],
      ),
    );
  }

  // Pick image and process
  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      await _processImage();
    }
  }

  // Process image with ML Kit
  Future<void> _processImage() async {
    final inputImage = InputImage.fromFilePath(_imageFile!.path);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(
      inputImage,
    );
    String extractedText = recognizedText.text;

    print("Extracted Text:\n$extractedText");

    // === Simulate mapping (you can implement logic based on your invoice format) ===
    List<String> lines = extractedText.split('\n');

    ReadingData data = ReadingData(
      date: lines.isNotEmpty ? lines[0] : null,
      shift: lines.length > 1 ? lines[1] : null,
      fuelType1: lines.length > 2 ? lines[2] : null,
      volume1: lines.length > 3 ? lines[3] : null,
      ullage1: lines.length > 4 ? lines[4] : null,
      fuelType2: lines.length > 5 ? lines[5] : null,
      volume2: lines.length > 6 ? lines[6] : null,
      ullage2: lines.length > 7 ? lines[7] : null,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ResultScreen(data: data, attachment: _imageFile, extractedText: ''),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tank Reading')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile == null
                ? const Text('No image selected')
                : Image.file(_imageFile!, height: 200),
            const SizedBox(height: 22),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Scan Invoice'),
            ),
          ],
        ),
      ),
    );
  }
}
