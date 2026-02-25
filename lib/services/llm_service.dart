import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LLMService {

  Future<String> simplifyText(String originalText) async {
    // 1. Securely read the key from the .env file
    final apiKey = dotenv.env['GEMINI_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      print("Error: API Key not found in .env file!");
      return "Oops! I need my API key to do magic.";
    }

    try {
      // FIX: Changed to 'gemini-pro' to resolve the v1beta API error!
      final model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: apiKey);

      // Inside llm_service.dart
      // The "Ultimate Simplicity" Prompt
      final prompt = '''
        You are a kind teacher for a child with dyslexia. 
        Explain the main idea of this text in 3 very short bullet points.
        
        Rules:
        1. Use words a 5-year-old knows.
        2. Use "The Big Idea" at the start.
        3. Use a simple analogy (like "It's like a toy box" or "It's like a dog learning a trick").
        4. No big words like "information," "patterns," or "technology."
        5. Total word count must be under 40 words.
        
        Text to simplify:
        "$originalText"
      ''';

      final response = await model.generateContent([Content.text(prompt)]);

      return response.text?.replaceAll('\n', ' ').trim() ?? "Sorry, I couldn't simplify that right now.";

    } catch (e) {
      print("LLM Error: $e");
      return "Sorry, I'm having trouble connecting right now.";
    }
  }
}