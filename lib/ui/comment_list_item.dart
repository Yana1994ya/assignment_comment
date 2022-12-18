import 'package:assignment_comment/models/comment.dart';
import 'package:flutter/material.dart';

class CommentListItem extends StatelessWidget {
  final Comment comment;
  const CommentListItem({required this.comment , Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(comment.name),
      subtitle: Text(comment.email),
    );
  }
}
