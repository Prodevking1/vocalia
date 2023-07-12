import 'dart:async';

import 'package:mic_stream/mic_stream.dart';

class MicrophoneService {
  Stream<List<int>>? _audioStream;
  bool isListening = false;
  StreamSubscription<List<int>>? listener;

  void startListening(void Function(List<int> buffer) onData) async {
    if (isListening) return;

    _audioStream = await MicStream.microphone(
      sampleRate: 44100,
      audioSource: AudioSource.MIC,
    );
    isListening = true;
    listener = _audioStream!.listen((buffer) {
      /* onData(buffer); */
      print(buffer);
    });
  }

  void stopListening() {
    if (!isListening) return;
    listener?.cancel();
    isListening = false;
  }
}
