import 'package:anime_news/models/top_content.dart';
import 'package:flutter/cupertino.dart';

class TopContentProvider with ChangeNotifier {
  TopContent? _topContent;

  TopContentProvider({required TopContent? topContent}) {
    _topContent = topContent;
  }

  set topContent(TopContent topContent) {
    _topContent = topContent;
    notifyListeners();
  }

  TopContent get topContent => _topContent!;
}
