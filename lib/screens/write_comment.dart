import 'package:assignment_comment/ui/comment_form.dart';
import 'package:flutter/material.dart';

class WriteComment extends StatelessWidget {
  const WriteComment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Write Comment'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: CommentForm(),
        ),
      ),
    );
  }
}
