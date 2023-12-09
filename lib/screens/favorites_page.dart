import 'package:flutter/material.dart';
import 'package:inspire_gyms/constants/app_colors.dart';
import 'package:inspire_gyms/services/favorities_services.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoriler'),
        backgroundColor: AppColors.quaternaryColor,
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
                return const Center(child: Text('Şimdilik Favori Gym Yok !'));
              }

              return ListView.builder(
                itemCount: favoriteGyms.length,
                itemBuilder: (context, index) {
                  String gymName = favoriteGyms[index];

                  return ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.red), // Heart icon
                        SizedBox(width: 8), // Add some space between icon and text
                        Text(gymName),
                      ],
                    ),
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
