/* import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextService {
  stt.SpeechToText speech = stt.SpeechToText();

  void init() {
    speech.initialize();
  }

  startListening() async {
    speech.listen(onResult: (result) {
      if (result.finalResult) {
        print(result.recognizedWords);
      }
      //openAiService.sendPrompt(recognizedWords);
    });
  }
}
 */