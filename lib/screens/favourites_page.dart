import 'package:flutter/material.dart';
import 'package:inspire_gyms/constants/app_colors.dart';

class FavoritiesPage extends StatefulWidget {
  const FavoritiesPage({Key? key}) : super(key: key);

  @override
  State<FavoritiesPage> createState() => _FavoritiesPageState();
}

class _FavoritiesPageState extends State<FavoritiesPage> {
  // Favori öğeleri içeren bir liste örneği
  List<String> favoriListesi = [
    'Favori Öğe 1',
    'Favori Öğe 2',
    'Favori Öğe 3',
    // ...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.quaternaryColor,
        title: Text('Favorilerim'),
      ),
      body: favoriListesi.isEmpty
          ? Center(
              child: Text('Henüz favori öğe eklenmedi.'),
            )
          : ListView.builder(
              itemCount: favoriListesi.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(favoriListesi[index]),
                  // Buraya favori öğelerinize tıklanınca ne olacağını ekleyebilirsiniz
                  onTap: () {
                    // Örneğin: Favori öğe detayları sayfasına git
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => FavoriDetaySayfasi(favoriListesi[index]),
                    //   ),
                    // );
                  },
                );
              },
            ),
    );
  }
}
