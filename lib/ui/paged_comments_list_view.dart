import 'package:assignment_comment/controllers/comments_controller.dart';
import 'package:assignment_comment/models/comment.dart';
import 'package:assignment_comment/ui/comment_list_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PagedCommentsListView extends StatefulWidget {
  const PagedCommentsListView({super.key});

  @override
  State<PagedCommentsListView> createState() => _PagedCommentsListViewState();
}

class _PagedCommentsListViewState extends State<PagedCommentsListView> {
  // The instruction specified loading 20 items at a time
  static const _pageSize = 20;

  // Start from "page" 0
  final PagingController<int, Comment> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    // Define the function to invoke whenever a page is requested
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      // Read items for the new page
      final newItems = await CommentsController.readComments(pageKey, _pageSize);

      // If we read less items than requested, we're on the last page
      final isLastPage = newItems.length < _pageSize;

      if (isLastPage) {
        // On last page, invoke a function that specifies those items are last
        _pagingController.appendLastPage(newItems);
      } else {
        // When there's a "next" page, invoke the correct function
        // that specifies a "key" for the next page, in our case, it's
        // just the number of current page + 1
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      // Print the error for devs only
      if (kDebugMode) {
        print(error);
      }

      // And set the "error" on the controller to display an error message to
      // our clients
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Render the list view with the paging controller
    return PagedListView<int, Comment>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Comment>(
        itemBuilder: (context, item, index) => CommentListItem(comment: item),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the controller to free whatever resources it holds
    _pagingController.dispose();
    super.dispose();
  }
}
