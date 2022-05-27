/// Generic data class for pagination any data type
/// with Generic [PaginationView]
///
class Paginator<T> {
  late final List<T> _items;
  bool _hasNextPage;
  final int perPageItems;
  int _pageIndex;
  final int _initialPageIndex;

  List<T> get items => _items;
  bool get hasNextPage => _hasNextPage;
  int get pageIndex => _pageIndex;

  Paginator({
    bool hasNextPage = true,
    this.perPageItems = 20,
    int pageIndex = 0,
  })  : _items = <T>[],
        _hasNextPage = hasNextPage,
        _pageIndex = pageIndex,
        _initialPageIndex = pageIndex;

  void addItems(List<T> items, bool hasNextPage) {
    _items.addAll(items);
    _hasNextPage = hasNextPage;
    _pageIndex++;
  }

  void clear() {
    _items.clear();
    _hasNextPage = true;
    _pageIndex = _initialPageIndex;
  }
}
