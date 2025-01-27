import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const platform = MethodChannel('toast_channel');

  Future<void> _showToast() async {
    try {
      await platform.invokeMethod(
        'showToast',
        {'message': 'test'},
      );
    } on PlatformException catch (e) {
      debugPrint("toast call failed: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Hello World!'),
              ElevatedButton(
                onPressed: _showToast,
                child: const Text('toast'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
