import 'package:assignment_comment/models/comment.dart';
import 'package:flutter/material.dart';

class CommentListItem extends StatelessWidget {
  final Comment comment;

  const CommentListItem({required this.comment, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Table(
          columnWidths: const {
            // Name, Email, Body label, intrinsic means as small as required
            // to write the text.
            0: IntrinsicColumnWidth(),
            // The content, make it take the rest of the space
            1: FlexColumnWidth()
          },
          children: [
            TableRow(
              children: [
                const Text(
                  "Name:  ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(comment.name),

              ]
            ),
            TableRow(
                children: [
                  const Text(
                    "Email:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(comment.email),

                ]
            ),
            TableRow(
                children: [
                  const Text(
                    "Body:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(comment.body),

                ]
            ),
          ],
        ),
      ),
    );
  }

/*@override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Name:  ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: Text(comment.name)),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Email:  ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(comment.email),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Body:  ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(comment.body),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    return ListTile(
      title: Text(comment.name),
      subtitle: Text(comment.email),
    );
  }*/

}
