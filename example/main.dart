import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pretty_list_animation/pretty_list_animation.dart';

void main() {
  runApp(const MyApp());
}

/// Main class which is the entry point of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// The build method will return the main view widget from the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      /// Configure the application theme
      theme: ThemeData(useMaterial3: true),

      /// Widget utama yang akan ditampilkan
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Declare variable [List] 'numbers' with data type int and initial value blank
  late List<int> numbers = [];

  @override
  void initState() {
    setState(() {
      numbers = [0, 1, 2];
    });
    super.initState();
  }

  /// Method for adding numbers to the 'numbers' list
  _addNumber() {
    setState(() {
      numbers = numbers +
          [
            /// Adding random numbers to the 'numbers' list
            Random().nextInt(100),
          ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Example')),
      body: PrettyListAnimation(
        onRefresh: () async {},
        padding: const EdgeInsets.all(16),
        items: numbers,

        /// Method for displaying each item in the 'numbers' list
        itemBuilder: (context, number, index, animation) {
          /// Animated Widgets can be adjusted to your taste, for the widgets used, you can use the widgets provided by flutter
          /// for example : [SizeTransition] and [FadeTransition]
          return SizeTransition(
            sizeFactor: animation,
            child: SizedBox(
              height: 80.0,
              child: Card(
                color: Color.fromRGBO(
                  Random().nextInt(256),
                  Random().nextInt(256),
                  Random().nextInt(256),
                  1,
                ),
                child: Center(
                  child: Text('Item $number'),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: '1',
        onPressed: () {
          _addNumber();
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
