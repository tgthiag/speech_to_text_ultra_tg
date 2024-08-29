import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextUltra extends StatefulWidget {
  // final ValueChanged<String> callback;
  final Icon? toPauseIcon;
  final Icon? toStartIcon;
  final Color? pauseIconColor;
  final Color? startIconColor;
  final double? startIconSize;
  final String? language;
  final double? pauseIconSize;
  final Function(String liveText, String finalText, bool isListening)
      ultraCallback;

  // String combinedResponse = '';
  const SpeechToTextUltra(
      {super.key,
      required this.ultraCallback,
      this.toPauseIcon = const Icon(Icons.pause),
      this.toStartIcon = const Icon(Icons.mic),
      this.pauseIconColor = Colors.black,
      this.startIconColor = Colors.black,
      this.startIconSize = 24,
      this.language,
      this.pauseIconSize = 24});

  @override
  State<SpeechToTextUltra> createState() => _SpeechToTextUltraState();
}

class _SpeechToTextUltraState extends State<SpeechToTextUltra> {
  late SpeechToText speech;
  bool isListening = false;
  String liveResponse = '';
  String entireResponse = '';
  String chunkResponse = '';

  @override
  void initState() {
    super.initState();
    speech = SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isListening
          ? IconButton(
              iconSize: widget.pauseIconSize,
              icon: widget.toPauseIcon!,
              color: widget.pauseIconColor,
              onPressed: () {
                stopListening();
              },
            )
          : IconButton(
              iconSize: widget.startIconSize,
              color: widget.startIconColor,
              icon: widget.toStartIcon!,
              onPressed: () {
                startListening();
              },
            ),
    );
  }

  void startListening() async {
    // speech = SpeechToText();
    bool available = await speech.initialize(
      onStatus: (status) async {
        // print('Speech recognition status: $status AND is LISTENING STATUS ${isListening}');
        if ((status == "done" || status == "notListening") && isListening) {
          await speech.stop();
          setState(() {
            if (chunkResponse != '') {
              entireResponse = '$entireResponse $chunkResponse';
            }
            chunkResponse = '';
            liveResponse = '';
            //MAIN CALLBACK HAPPENS
            widget.ultraCallback(liveResponse, entireResponse, isListening);
          });
          startListening();
        }
      },
    );

    if (available) {
      setState(() {
        isListening = true;
        liveResponse = '';
        chunkResponse = '';
        widget.ultraCallback(liveResponse, entireResponse, isListening);
      });
      await speech.listen(
        localeId: widget.language,
        onResult: (result) {
          setState(() {
            final state = result.recognizedWords;
            liveResponse = state;
            if (result.finalResult) {
              chunkResponse = result.recognizedWords;
            }
            widget.ultraCallback(liveResponse, entireResponse, isListening);
          });
        },
      );
    } else {
      debugPrint('Ultra Speech ERROR : Speech recognition not available');
    }
  }

  void stopListening() {
    speech.stop();
    setState(() {
      isListening = false;
      entireResponse = '$entireResponse $chunkResponse';
      widget.ultraCallback(liveResponse, entireResponse, isListening);
    });
  }
}

class SpeechToTextUltra2 {
  late SpeechToText _speech;
  bool _isListening = false;
  bool _isInitialized = false;
  String _liveResponse = '';
  String _entireResponse = '';
  String _chunkResponse = '';

  final String? language;
  final Function(String liveText, String finalText, bool isListening)
      ultraCallback;

  SpeechToTextUltra2({required this.ultraCallback, this.language}) {
    _speech = SpeechToText(); // Initialize here to avoid multiple instances
  }

  Future<void> initializeSpeech() async {
    if (!_isInitialized) {
      _isInitialized = await _speech.initialize(
        onStatus: (status) async {
          if ((status == "done" || status == "notListening") && _isListening) {
            await stopListening();
            startListening();
          }
        },
      );
      if (!_isInitialized) {
        debugPrint('Ultra Speech ERROR: Speech recognition not available');
      }
    }
  }

  Future<void> startListening() async {
    if (!_isInitialized) {
      await initializeSpeech();
    }

    if (_isInitialized) {
      _isListening = true;
      _liveResponse = '';
      _chunkResponse = '';
      ultraCallback(_liveResponse, _entireResponse, _isListening);

      await _speech.listen(
        localeId: language,
        onResult: (result) {
          final state = result.recognizedWords;
          _liveResponse = state;
          if (result.finalResult) {
            _chunkResponse = result.recognizedWords;
          }
          ultraCallback(_liveResponse, _entireResponse, _isListening);
        },
      );
    }
  }

  Future<void> stopListening() async {
    _speech.stop();
    _isListening = false;
    _entireResponse = '$_entireResponse $_chunkResponse';
    ultraCallback(_liveResponse, _entireResponse, _isListening);
  }

  bool get isListening => _isListening;

  String get liveResponse => _liveResponse;

  String get entireResponse => _entireResponse;
}
