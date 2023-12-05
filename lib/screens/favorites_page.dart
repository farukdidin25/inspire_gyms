import 'package:flutter/material.dart';
import 'package:inspire_gyms/constants/app_colors.dart';
import 'package:inspire_gyms/services/favorities_services.dart';


class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: FutureBuilder<List<String>>(
        future: FavoritesService().getFavoriteGyms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<String>? favoriteGyms = snapshot.data;

              if (favoriteGyms == null || favoriteGyms.isEmpty) {
                return const Center(child: Text('No favorite gyms yet!'));
              }

              return ListView.builder(
                itemCount: favoriteGyms.length,
                itemBuilder: (context, index) {
                  String gymName = favoriteGyms[index];
                  return ListTile(
                    title: Text(gymName),
                    // Diğer widget'lar burada
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
