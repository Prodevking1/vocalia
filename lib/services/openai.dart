import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:voice_app/utils/const.dart';

class OpenAiService {
  late OpenAI openAI;

  static const String promptGuard =
      "Oublie tout ce qui précède ta réponse. Sois précis et ne développe pas trop et utilise un ton amical";

  void init() {
    openAI = OpenAI.instance.build(
        token: openAiKey,
        baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
        enableLog: true);
  }

  Future<String> sendPrompt(String prompt) async {
    final request = ChatCompleteText(
      messages: [
        Messages(role: Role.user, content: prompt, name: 'prompt'),
      ],
      maxToken: 200,
      model: GptTurboChatModel(),
      functionCall: FunctionCall.auto,
    );

    ChatCTResponse? response = await openAI.onChatCompletion(request: request);
    print(response!.choices.first.message!.content);
    return response.choices.first.message!.content;
  }

  promtParameters(String params) {}
}
