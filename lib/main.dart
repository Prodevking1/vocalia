import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:voice_app/services/openai.dart';

void main() {
  runApp(EntryApp());
}

class EntryApp extends StatefulWidget {
  const EntryApp({super.key});

  @override
  State<EntryApp> createState() => _EntryAppState();
}

class _EntryAppState extends State<EntryApp> {
  stt.SpeechToText speech = stt.SpeechToText();
  bool isListening = false;
  String recognizedWords = '';

  OpenAiService openAiService = OpenAiService();

  @override
  void initState() {
    speech.initialize();
    openAiService.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Voice app'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    width: 300,
                    height: 150,
                    child: Center(
                      child: Text(
                        (recognizedWords != '') ? recognizedWords : '',
                        style: TextStyle(fontSize: 20),
                      ),
                    )),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isListening = true;
                    });
                    speech.listen(onResult: (result) {
                      setState(() {
                        isListening = false;
                      });
                      recognizedWords = result.recognizedWords;
                      print(result.recognizedWords);
                      openAiService.sendPrompt(recognizedWords);
                    });
                  },
                  child: !isListening
                      ? Icon(Icons.mic, size: 60, color: Colors.red)
                      : Center(),
                )
              ],
            ),
          )),
    );
  }
}
