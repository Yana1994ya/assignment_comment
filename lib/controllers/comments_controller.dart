import 'package:assignment_comment/models/comment.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CommentsController {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
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
        await dio.get('/comments?_limit=$pageSize&_start=$startAt');

    final comments = response.data as List<dynamic>;
    return comments.map((comment) => Comment.fromJson(comment)).toList();
  }

  static Future<Comment> uploadComment(
      String userName, String userEmail, String userComment) async {
    final response = await dio.post('/comments', data: {
      'postId': 1,
      'name': userName,
      'email': userEmail,
      'body': userComment,
    });

    final newComment = Comment.fromJson(response.data);
    return newComment;
  }
}
