import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenAIService {
  final String _apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
  final String _url = 'https://api.openai.com/v1/chat/completions';

  Future<String> generateStudy(String verseText) async {
    final prompt = '''
Crie um estudo bíblico para o seguinte versículo:

"$verseText"

Retorne com as seções:
1. Contexto Histórico
2. Aplicação Prática
3. Referências Cruzadas

Responda em no máximo 500 tokens.
''';

    final response = await http.post(
      Uri.parse(_url),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'user', 'content': prompt},
        ],
        'max_tokens': 500,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Erro ao gerar estudo: ${response.body}');
    }
  }
}
