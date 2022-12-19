import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/paged_comments_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              context.go('/write_comment');
            },
          ),
        ],
      ),
      body: const PagedCommentsListView(),
    );
  }
}
