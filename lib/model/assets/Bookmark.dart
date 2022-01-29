import 'Identifier.dart';
import 'filter/Filter.dart';

class BookmarkFilter<T extends Bookmark> extends Filter<T> {
  @override
  bool retain(Bookmark b) {
    return b.bookmarked;
  }
}

mixin Bookmark {
  bool bookmarked = false;
}