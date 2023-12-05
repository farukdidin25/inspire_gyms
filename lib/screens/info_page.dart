// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:inspire_gyms/constants/app_colors.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.quaternaryColor,
        title: const Text('Hakkımda'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              // Bu kısımda kendi fotoğrafınızı ekleyin
              child: CircleAvatar(
                radius: 85,
                backgroundImage: AssetImage('assets/images/profil.jpeg'), // Fotoğraf dosyanızın yolu
              ),
            ),
            buildInfoRow('Ad', 'Ömer Faruk', Icons.person),
            buildInfoRow('Soyad', 'Didin', Icons.person),
            buildInfoRow('Üniversite', 'Erciyes Üniversitesi', Icons.school),
            buildInfoRow('Fakülte', 'Mühendislik Fakültesi', Icons.domain),
            buildInfoRow('Lisans', 'Bilgisayar Mühendisliği', Icons.computer),
            buildInfoRow('Sınıf', '3. Sınıf', Icons.class_),
            buildInfoRow('Yazılım', '.NET, HTML, CSS, C#, Flutter', Icons.code),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(String title, String content, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 24),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              content,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}