import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class AIHandler {
  final List<Map<String, String>> messages = [];
  final openAIAPIKey = "YOUR_API_KEY";
  final _openAI = OpenAI.instance.build(
    token: 'YOUR_API_KEY',
    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 5),
      connectTimeout: const Duration(seconds: 5),
    ),
  );
  // Default Function
  Future<String> getResponse(String message) async {
    try {
      final request = ChatCompleteText(messages: [
        Map.of({"role": "user", "content": message})
      ], maxToken: 200, model: ChatModel.gptTurbo);

      final response = await _openAI.onChatCompletion(request: request);
      if (response != null) {
        return response.choices[0].message!.content.trim();
      }

      return 'Some thing went wrong';
    } catch (e) {
      return e.toString();
    }
  }

  void dispose() {
    _openAI.cancelAIGenerate();
  }
}
