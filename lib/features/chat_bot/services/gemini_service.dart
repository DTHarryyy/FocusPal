import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final GenerativeModel model;
  static String get apiKey => dotenv.get('GEMINI_API_KEY');

  GeminiService()
      : model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: apiKey);

  Future<String> ask(String message) async {
    try {
      final response = await model.generateContent([Content.text(message)]);
      return response.text ?? "";
    } catch (e) {
      print('Gemini API Error: $e');
      return "Sorry, something went wrong!";
    }
  }
}
