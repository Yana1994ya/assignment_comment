import 'package:assignment_comment/controllers/comments_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CommentForm extends StatefulWidget {
  const CommentForm({super.key});

  @override
  CommentFormState createState() {
    return CommentFormState();
  }
}

class CommentFormState extends State<CommentForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final commentController = TextEditingController();

  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final commentFocusNode = FocusNode();

  bool isLoading = false;


  @override
  void dispose() {
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    commentFocusNode.dispose();

    super.dispose();
  }

  static String? _validateName(String? value)  {
    if (value == null || value.isEmpty) {
      return 'Name is required!';
    } else if (value.trim() == "" ||
        !RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return 'Please enter valid name that only contains letters.';
    } else if (value.trim().length < 2) {
      return 'Please enter valid name that contains at least 2 letters.';
    }

    return null;
  }

  static String? _validateEmail(String? value)  {
    if (value == null || value.isEmpty) {
      return 'Email is required!';
    } else if (value.trim() == "") {
      return 'Please enter valid email.';
    } else if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Please enter valid email.';
    }

    return null;
  }

  static String? _validateComment(String? value)  {
    if (value == null || value.isEmpty) {
      return 'Content is required!';
    } else if (value.trim() == "") {
      return 'Please enter valid comment.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            autofocus: true,
            focusNode: nameFocusNode,
            onFieldSubmitted: (_){
              nameFocusNode.unfocus();
              FocusScope.of(context).requestFocus(emailFocusNode);
            },
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              hintText: 'Enter Your Name',
            ),
            controller: nameController,
            validator: _validateName,
          ),
          const SizedBox(height: 10,),
          TextFormField(
            focusNode: emailFocusNode,
            onFieldSubmitted: (_){
              emailFocusNode.unfocus();
              FocusScope.of(context).requestFocus(commentFocusNode);
            },
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              hintText: 'Enter Your Email',
            ),
            controller: emailController,
            validator: _validateEmail,
          ),
          const SizedBox(height: 10,),
          TextFormField(
            focusNode: commentFocusNode,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: 'Enter Your Comment',
            ),
            controller: commentController,
            validator: _validateComment,
          ),
          const SizedBox(height: 20,),
          isLoading
              ? LoadingAnimationWidget.threeArchedCircle(
                  color: Theme.of(context).primaryColor,
                  size: 40,
                )
              : ElevatedButton(
                child: const Text('Add Comment'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });

                    final newCommentRequest =
                        CommentsController.uploadComment(
                      nameController.text,
                      emailController.text,
                      commentController.text,
                    );

                    newCommentRequest.catchError((error) {
                      // For developers only
                      if (kDebugMode) {
                        print(error);
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Something went wrong!\n'
                                'Please try again later.',
                          ),
                        ),
                      );
                      context.go('/');
                    }).then((newComment) {
                      // For developers only
                      if (kDebugMode) {
                        print(newComment);
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Uploading the comment!')),
                      );
                      context.go('/');
                    });
                  }
                },
              ),
        ],
      ),
    );
  }
}
