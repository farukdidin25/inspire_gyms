import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  void addFavorite(dynamic gym) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteGyms = prefs.getStringList('favoriteGyms') ?? [];
    favoriteGyms.add(gym['name']);
    prefs.setStringList('favoriteGyms', favoriteGyms);
  }

  void removeFavorite(dynamic gym) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteGyms = prefs.getStringList('favoriteGyms') ?? [];
    favoriteGyms.remove(gym['name']); // Favorilerden gym ismini kaldırıyoruz
    prefs.setStringList('favoriteGyms', favoriteGyms);
  }

  Future<List<String>> getFavoriteGyms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favoriteGyms') ?? [];
  }
}
