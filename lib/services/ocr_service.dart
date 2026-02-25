import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OCRService {
  // Initialize the text recognizer for Latin-based languages (English)
  final TextRecognizer _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  Future<String> extractText(File imageFile) async {
    try {
      // 1. Convert the file into an ML Kit readable format
      final inputImage = InputImage.fromFile(imageFile);

      // 2. Process the image
      final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);

      // 3. Return the extracted string (Cleaned up slightly to avoid weird line breaks)
      return recognizedText.text.replaceAll('\n', ' ');

    } catch (e) {
      print("OCR Error: $e");
      return "";
    }
  }

  // Good practice to close the recognizer when done
  void dispose() {
    _textRecognizer.close();
  }
}