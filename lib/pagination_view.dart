import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paginate_app/paginator.dart';

/// Generic View for Pagination
///
class PaginationView<T> extends StatefulWidget {
  /// Provide a [Paginator] with same data type for [PaginationView]
  final Paginator<T> paginator;

  /// Build view for each item
  final Widget Function(T item) itemBuilder;

  /// How to fetch next page data
  /// just provide a function that fetches data
  ///
  /// Need a good name for this : Pls Suggest
  final Future<void> Function() nextPageFetcher;

  /// Loader widget to show during data loading
  final Widget? loader;

  /// View for no item
  final Widget? noItemWidget;

  const PaginationView({
    super.key,
    required this.paginator,
    required this.itemBuilder,
    required this.nextPageFetcher,
    this.loader,
    this.noItemWidget,
  });

  @override
  State<PaginationView<T>> createState() => _PaginationViewState<T>();
}

class _PaginationViewState<T> extends State<PaginationView<T>> {
  late ScrollController _controller;
  bool _isFetchingNextPage = false;

  bool get _shouldFetchedNextPage =>
      _controller.position.maxScrollExtent == _controller.offset &&
      widget.paginator.hasNextPage &&
      !_isFetchingNextPage;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (_shouldFetchedNextPage) {
      _showLoader();
      widget.nextPageFetcher().whenComplete(_hideLoader);
    }
  }

  void _showLoader() => _refreshLoader();
  void _hideLoader() => _refreshLoader();

  void _refreshLoader() => setState(() => _toggleIsFetchingNextPage());

  @override
  Widget build(BuildContext context) {
    var items = widget.paginator.items;

    if (items.isEmpty) {
      return widget.noItemWidget ?? const _NoItemWidget();
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _controller,
            itemCount: items.length + 1,
            itemBuilder: (_, i) {
              if (i == items.length) {
                return _isFetchingNextPage ? _loader : const SizedBox();
              }
              return widget.itemBuilder(items[i]);
            },
          ),
        ),
      ],
    );
  }

  Widget get _loader {
    return widget.loader ??
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CupertinoActivityIndicator(),
              SizedBox(width: 12),
              Text(
                'Loading..',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        );
  }

  void _toggleIsFetchingNextPage() =>
      _isFetchingNextPage = !_isFetchingNextPage;
}

class _NoItemWidget extends StatelessWidget {
  const _NoItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('No item found!');
  }
}
