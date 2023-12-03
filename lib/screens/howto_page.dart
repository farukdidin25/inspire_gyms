import 'package:flutter/material.dart';
import 'package:inspire_gyms/constants/app_colors.dart';

class HowTo extends StatelessWidget {
  const HowTo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.quaternaryColor,
        title: Text('Kullanım Talimatı'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInstructionSection(
              icon: Icons.location_on,
              title: 'Nasıl Kullanılır',
              description: '1. Öncelikle konumunuzun açık olduğundan emin olun.\n'
                  '2. Konumunuzu onaylayınız.\n'
                  '3. Yer alan seçeneklerden istediğinize erişin.\n'
                  '4. Favori bir yeriniz varsa bunu favorilere eklemeyi unutmayın!',
            ),
            SizedBox(height: 20),
            buildInstructionSection(
              icon: Icons.info,
              title: 'Neden Kullanılır',
              description: 'Oluştuğunuz konumda etrafınızda yer alan yakın imkanları tek bir tıkla elinizin altında bulabilirsiniz.'
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInstructionSection({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(description),
      ],
    );
  }
}
