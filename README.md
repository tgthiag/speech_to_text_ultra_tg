## Author

Souvik Das
[Link to Profile](https://www.linkedin.com/in/souvik2710/)

## Speech To Text Ultra

This Flutter package designed to address the inconvenience of sudden pauses during speech recognition.
With manual control over pause and play functionality, users can now dictate paragraphs without interruptions, ensuring a
seamless and uninterrupted speech recognition experience. Elevate your Flutter applications with improved speech interaction,
empowering users to communicate effortlessly and effectively.

## Installation

1. Add the latest version of package to your pubspec.yaml (and run`dart pub get`):
```yaml
dependencies:
  speech_to_text_ultra: ^0.0.1
```
2. Import the package and use it in your Flutter App.
```dart
import 'package:speech_to_text/speech_to_text.dart';
```


## Example
[comment]: <> (<hr>)

<table>
<tr>
<td>

```dart
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


```

</td>
</tr>
</table>

## Features

- Seamlessly pause and resume speech recognition manually for uninterrupted dictation.
- Eliminate sudden pauses during speech input, ensuring smooth and uninterrupted interactions.
- Empower users to dictate entire paragraphs without interruptions or breaks.
- Enhance user experience by providing manual control over speech recognition pause/play functionality.
- Streamline speech input in Flutter applications with intuitive pause and play features.