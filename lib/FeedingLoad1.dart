import 'package:flutter/material.dart';

class FeedingLoad extends StatefulWidget {
  const FeedingLoad({super.key});

  @override
  State<FeedingLoad> createState() => _FeedingLoadState();
}

class _FeedingLoadState extends State<FeedingLoad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Feeding()
    );
  }
}

class Feeding extends StatefulWidget {
  const Feeding({super.key});

  @override
  State<Feeding> createState() => _FeedingState();
}

class _FeedingState extends State<Feeding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
