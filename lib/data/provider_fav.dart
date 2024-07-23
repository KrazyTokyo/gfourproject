import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data_barrel.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _songsTitles = [];
  List<String> get songsTitles => _songsTitles;

  void toggleFavorite(String title) {
    final isExist = _songsTitles.contains(title);
    if (isExist) {
      _songsTitles.remove(title);
    } else {
      _songsTitles.add(title);
    }
    notifyListeners();
  }

  bool isExist(String title) {
    final isExist = _songsTitles.contains(title);
    return isExist;
  }

  void clearFavorite() {
    _songsTitles = [];
    notifyListeners();
  }

  static FavoriteProvider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<FavoriteProvider>(
      context,
      listen: listen,
    );
  }

  Songs getSongsByTitle(String title) {
    final songClass = SongClass();
    return songClass.songList.firstWhere((song) => song.song == title);
  }
}
