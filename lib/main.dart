import 'package:elevenlabs/elevenlabs.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:voice_app/services/eleven.dart';
import 'package:voice_app/services/microphone_service.dart';
import 'package:voice_app/services/openai.dart';
import 'dart:core';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const EntryApp());
}

class EntryApp extends StatefulWidget {
  const EntryApp({super.key});

  @override
  State<EntryApp> createState() => _EntryAppState();
}

class _EntryAppState extends State<EntryApp>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  stt.SpeechToText speech = stt.SpeechToText();
  bool isListening = false;
  String recognizedWords = '';

  OpenAiService openAiService = OpenAiService();
  final ElevenLabsService _elevenLabs = ElevenLabsService();

  @override
  void initState() {
    //speech.initialize();
    openAiService.init();
    openAiService.sendPrompt("Dis moi que tu es un assistant vocal");

    WidgetsBinding.instance.addObserver(this);
    setState(() {});
    //startListening();
    super.initState();
  }

  @override
  void dispose() {
    speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 20, left: 25),
                child: Icon(Icons.person_2_outlined, size: 30),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                  bottom: MediaQuery.of(context).size.height * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.note_alt,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Dernières activités",
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05),
                child: isListening
                    ? Container(
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
                        ))
                    : Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.1),
                        child: Text(
                          "Appuis sur le micro et parle",
                          style: TextStyle(color: Colors.grey),
                        ),
                      )),
            GestureDetector(
              onTap: () {
                setState(() {
                  isListening = true;
                  recognizedWords = "";
                });
                //startListening();
                openAiService
                    .sendPrompt("Tu sais faire quoi ?")
                    .then((response) => {
                          _elevenLabs.streamAudioFromText(response),
                        });
              },
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: !isListening
                    ? Icon(
                        Icons.mic,
                        size: 50,
                        color: Colors.black.withOpacity(0.6),
                      )
                    : Text("Vocalia t'écoute"),
              ),
            ),
          ],
        ),
      )),
    );
  }

  void startListening() async {
    if (await speech.initialize()) {
      setState(() {
        isListening = true;
      });

      final MicrophoneService microphoneService = MicrophoneService();
      microphoneService.startListening((buffer) {
        if (isListening) {
          speech.listen(
            listenMode: stt.ListenMode.dictation,
            onResult: (result) {
              if (result.finalResult) {
                setState(() {
                  recognizedWords = result.recognizedWords;
                });
              }
            },
          );
        }
      });
    }
  }
}
