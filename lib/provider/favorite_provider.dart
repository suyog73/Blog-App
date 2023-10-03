import 'package:blogger/helpers/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class FavoriteProvider extends ChangeNotifier {
  final favoriteBox = Hive.box(kFavoriteBox);

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  bool isFavoriteAvailable() {
    for (bool value in favoriteBox.values) {
      if (value == true) {
        return true;
      }
    }
    return false;
  }

  bool getIsFavorite(String id) {
    bool ans = favoriteBox.get(id) ?? false;

    return ans;
  }

  void toggleFavorite(String id) {
    _isFavorite = favoriteBox.get(id) ?? false;
    _isFavorite = !_isFavorite;

    favoriteBox.put(id, _isFavorite);

    notifyListeners();
  }
}
