import 'package:assignment_comment/controllers/comments_controller.dart';
import 'package:assignment_comment/models/comment.dart';
import 'package:assignment_comment/ui/comment_list_item.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PagedCommentsListView extends StatefulWidget {
  const PagedCommentsListView({super.key});

  @override
  State<PagedCommentsListView> createState() => _PagedCommentsListViewState();
}

class _PagedCommentsListViewState extends State<PagedCommentsListView> {
  static const _pageSize = 20;

  final PagingController<int, Comment> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await CommentsController.readComments(pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Comment>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Comment>(
        itemBuilder: (context, item, index) => CommentListItem(comment: item),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
