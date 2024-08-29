import 'package:flutter/material.dart';
import 'package:speech_to_text_ultra_tg/speech_to_text_ultra_tg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SpeechToTextUltra2 speechService;

  @override
  void initState() {
    super.initState();
    speechService = SpeechToTextUltra2(
      ultraCallback: (liveText, finalText, isListening) {
        // print('Live Text: $liveText');
        if (finalText.isNotEmpty) {
          print(finalText);
        }
        // print('Is Listening: $isListening');
      },
      language: 'en-US',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Speech to Text Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  speechService.startListening();
                },
                child: Text('Start Listening'),
              ),
              ElevatedButton(
                onPressed: () {
                  speechService.stopListening();
                },
                child: Text('Stop Listening'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
