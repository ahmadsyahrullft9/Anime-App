import 'package:flutter/cupertino.dart';

class FavoriteProvider with ChangeNotifier {
  bool _isFavorite = false;

  get isFavorite => _isFavorite;

  set isFavorite(newValue) {
    _isFavorite = newValue;
    notifyListeners();
  }

  FavoriteProvider({required bool isFavorite}) {
    _isFavorite = isFavorite;
  }
}
