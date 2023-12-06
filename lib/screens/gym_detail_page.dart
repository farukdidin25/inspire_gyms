import 'package:flutter/material.dart';
import 'package:inspire_gyms/constants/api.dart';
import 'package:inspire_gyms/constants/app_colors.dart';


class GymDetailPage extends StatelessWidget {
  final Map<String, dynamic> gym;

  const GymDetailPage({Key? key, required this.gym}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gym['name']),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gym['photoReference'] != ''
                ? Image.network(
                    "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${gym['photoReference']}&key=${Api.apiKey}",
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: Colors.grey,
                  ),
            const SizedBox(height: 20),
            Text(
              '${gym['name']}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Address: ${gym['address'] ?? 'No address'}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

