import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

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
  String finalText = '';

  @override
  void initState() {
    super.initState();
    speech.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Demo App'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                finalText.isEmpty ? Text('Please speak') : Text(finalText),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isListening = true;
                    });

                    speech.listen(onResult: (result) {
                      print(result.recognizedWords);
                      finalText = result.recognizedWords;
                      setState(() {
                        isListening = false;
                      });
                    });
                  },
                  child: isListening
                      ? Center()
                      : Icon(Icons.mic, size: 60, color: Colors.green),
                )
              ],
            ),
          )),
    );
  }
}
