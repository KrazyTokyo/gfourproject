import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data_barrel.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _songsTitles = [];
  List<String> get songsTitles => _songsTitles;

  FavoriteProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _songsTitles = prefs.getStringList('favoriteSongs') ?? [];
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favoriteSongs', _songsTitles);
  }

  Future<void> clearFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('favoriteSongs');
    _songsTitles = [];
    notifyListeners();
  }

  void toggleFavorite(String title) {
    final isExist = _songsTitles.contains(title);
    if (isExist) {
      _songsTitles.remove(title);
    } else {
      _songsTitles.add(title);
    }
    _saveFavorites();
    notifyListeners();
  }

  bool isExist(String title) {
    return _songsTitles.contains(title);
  }

  void clearFavorite() {
    _songsTitles = [];
    _saveFavorites();
    notifyListeners();
  }

  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(context, listen: listen);
  }

  Songs getSongsByTitle(String title) {
    final songClass = SongClass();
    return songClass.songList.firstWhere((song) => song.song == title);
  }
}
