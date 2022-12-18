import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        actions: [
          IconButton(
          icon: const Icon(Icons.add_comment),
          tooltip: 'Add Comment',
          onPressed: () {

          },
        ),],
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}