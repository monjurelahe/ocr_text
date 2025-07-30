// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:image_picker/image_picker.dart';

// class TankReading extends StatefulWidget {
//   const TankReading({super.key});

//   @override
//   State<TankReading> createState() => _TankReadingState();
// }

// class _TankReadingState extends State<TankReading> {
//   File? _imageFile;

//   // First function for picking image
//   Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//     );
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//       _processImage();
//     }
//   }

//   // Second function for Process images
//   Future<void> _processImage() async {
//     final inputImage = InputImage.fromFilePath(_imageFile!.path);
//     final textRecognizer = TextRecognizer();
//     final RecognizedText recognizedText = await textRecognizer.processImage(
//       inputImage,
//     );
//     String extractedText = recognizedText.text;
//     print(extractedText);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _imageFile == null ? Text('True') : Image.file(_imageFile!),
//             SizedBox(height: 22),
//             ElevatedButton(onPressed: _pickImage, child: Text('Pick Image')),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'result_screen.dart'; // New screen

class TankReading extends StatefulWidget {
  const TankReading({super.key});

  @override
  State<TankReading> createState() => _TankReadingState();
}

class _TankReadingState extends State<TankReading> {
  File? _imageFile;

  // Pick image from gallery
  Future<void> _pickImage() async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Choose Image Source"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _getImage(ImageSource.camera);
            },
            child: Text("Camera"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _getImage(ImageSource.gallery);
            },
            child: Text("Gallery"),
          ),
        ],
      ),
    );
  }

  //Method for _getImage
  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      _processImage();
    }
  }

  // Process image and extract text
  Future<void> _processImage() async {
    final inputImage = InputImage.fromFilePath(_imageFile!.path);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(
      inputImage,
    );
    String extractedText = recognizedText.text;

    // Navigate to Result Screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(extractedText: extractedText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tank Reading')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile == null
                ? Text('No image selected')
                : Image.file(_imageFile!),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _pickImage, child: Text('Pick Image')),
          ],
        ),
      ),
    );
  }
}
