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

  // Text editing controllers, for reading the values of the various fields
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final commentController = TextEditingController();

  // Focus nodes, for changing focus between fields
  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final commentFocusNode = FocusNode();

  // Display loading indicator instead of the "Add Comment" button
  // to indicate activity
  bool isLoading = false;

  @override
  void dispose() {
    // Dispose of all the controllers and focus nodes
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    commentFocusNode.dispose();

    nameController.dispose();
    emailController.dispose();
    commentController.dispose();

    super.dispose();
  }

  // Validation functions for the different fields

  // Validate names, only letters and spaces, and at least 2 letters
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

  // Validate email, use a common email regex, can also use common libraries
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

  // Validate comment, just make sure anything is written
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
              // Next input is email
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
              // next input is comment
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
