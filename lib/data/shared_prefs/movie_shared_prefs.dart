import 'package:flutter_hf/domain/model/sort_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieSharedPrefs {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static const SORT_OPTION = "SORT_OPTION";
  static const FAVORITES = "FAVORITES";

  Future<SortOptions> getSortOption() async {
    final prefs = await _prefs;
    final idx = prefs.getInt(SORT_OPTION) ?? 0;
    return SortOptions.values[idx];
  }

  Future<void> setSortOption(SortOptions sortOptions) async {
    final prefs = await _prefs;
    await prefs.setInt(SORT_OPTION, sortOptions.index);
  }

  Future<List<String>> getFavorites() async {
    final prefs = await _prefs;
    final favorites = prefs.getStringList(FAVORITES) ?? [];
    return favorites;
  }

  Future<void> toggleFavorite(int malId) async {
    final prefs = await _prefs;
    var favorites = prefs.getStringList(FAVORITES) ?? [];
    final id = malId.toString();
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }
    await prefs.setStringList(FAVORITES, favorites);
  }

}