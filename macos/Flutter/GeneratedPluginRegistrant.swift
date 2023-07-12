//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import audio_session
import elevenlabs
import just_audio
import mic_stream
import path_provider_foundation
import speech_to_text_macos

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  AudioSessionPlugin.register(with: registry.registrar(forPlugin: "AudioSessionPlugin"))
  ElevenlabsPlugin.register(with: registry.registrar(forPlugin: "ElevenlabsPlugin"))
  JustAudioPlugin.register(with: registry.registrar(forPlugin: "JustAudioPlugin"))
  MicStreamPlugin.register(with: registry.registrar(forPlugin: "MicStreamPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  SpeechToTextMacosPlugin.register(with: registry.registrar(forPlugin: "SpeechToTextMacosPlugin"))
}
