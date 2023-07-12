import 'package:just_audio/just_audio.dart';
import 'package:voice_app/utils/const.dart';
import 'package:voice_app/services/http.dart';

class ElevenLabsService {
  String? voiceId;
  ElevenLabsService({this.voiceId = "21m00Tcm4TlvDq8ikWAM"});

  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> streamAudioFromText(String text) async {
    HttpClient httpClient = HttpClient(elevenEndpoint);

    final response =
        await httpClient.post(endpoint: "$voiceId/stream", headers: {
      'accept': 'audio/mpeg',
      'xi-api-key': elevenLabsKey,
      'Content-Type': 'application/json',
    }, data: {
      "text": text,
      "model_id": "eleven_multilingual_v1",
      "voice_settings": {"stability": 0.75, "similarity_boost": 0.6}
    });

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      await audioPlayer.setAudioSource(
        AudioSource(bytes),
      );
      await audioPlayer.play();
    } else {
      throw Exception("Failed to load audio");
    }
  }
}

class AudioSource extends StreamAudioSource {
  final List<int> bytes;
  AudioSource(this.bytes);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= bytes.length;
    return StreamAudioResponse(
      sourceLength: bytes.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.value(bytes.sublist(start, end)),
      contentType: 'audio/mpeg',
    );
  }
}
