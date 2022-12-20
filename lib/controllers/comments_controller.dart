import 'package:assignment_comment/models/comment.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CommentsController {
  // Read comment from jsonplaceholder.typicode.com
  static final Dio dioRead = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
    ),
  );

  // The instructions asked to send the new comments to a different url
  static final Dio dioUpload = Dio(
    BaseOptions(
      baseUrl: 'https://cambium.co.il',
    ),
  );

  /// Read comments from jsonplaceholder, when encountering an error (any error)
  /// pass it along to the caller.
  static Future<List<Comment>> readComments(
      int pageNumber, int pageSize) async {
    if (kDebugMode) {
      print("loading page: $pageNumber");
    }

    final startAt = pageNumber * pageSize;
    final response =
        await dioRead.get('/comments?_limit=$pageSize&_start=$startAt');

    final comments = response.data as List<dynamic>;
    return comments.map((comment) => Comment.fromJson(comment)).toList();
  }

  static Future<Comment> uploadComment(
      String userName, String userEmail, String userComment) async {
    final response = await dioUpload.post('/test/testAssignComment', data: {
      'postId': 1,
      'name': userName,
      'email': userEmail,
      'body': userComment,
    });

    final newComment = Comment.fromJson(response.data);
    return newComment;
  }
}
