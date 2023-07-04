import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:voice_app/utils/const.dart';

class OpenAiService {
  late OpenAI openAI;

  void init() {
    openAI = OpenAI.instance.build(
        token: openAiKey,
        baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
        enableLog: true);
  }

  void sendPrompt(String prompt) async {
    final request = /* CompleteText(
        prompt: prompt, model: TextDavinci3Model(), maxTokens: 200); */
        ChatCompleteText(
      messages: [
        Messages(role: Role.user, content: prompt, name: 'prompt'),
      ],
      maxToken: 200,
      model: GptTurboChatModel(),
      functionCall: FunctionCall.auto,
    );
    /* openAI.onCompletionSSE(request: request).listen((CompleteResponse event) {
      final response = event.choices.last.text;
      debugPrint(response);
    }); */
    ChatCTResponse? response = await openAI.onChatCompletion(request: request);
    debugPrint("$response");
  }

  promtParameters(String params) {}
}
