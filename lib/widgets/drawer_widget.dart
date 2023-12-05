import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inspire_gyms/constants/app_colors.dart';
import 'package:inspire_gyms/screens/howto_page.dart';
import 'package:inspire_gyms/screens/info_page.dart';
import 'package:inspire_gyms/widgets/gradient_text_widget.dart';

class MyDrawer extends StatelessWidget {
  final void Function(int) onDrawerItemTap;
  final int selectedIndex;
  const MyDrawer({
    super.key, required this.onDrawerItemTap, required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.backgroundColor,
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    onDrawerItemTap(0);
                    Navigator.pop(context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/icons/location.png',
                        width: 70,
                        height: 70,
                        color: AppColors.iconColor,
                      ),
                      const SizedBox(height: 2),
                      const GradientText(
                        'Inspire Gym',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'EmonaW00-Condensed',
                        ),
                        gradient: LinearGradient(colors: [
                          AppColors.secondaryColor,
                          AppColors.iconColor,
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.question_mark_sharp),
              title: const Text(
                'Nasıl Kullanılır',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HowTo(),
                  ),
                );
                
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text(
                'Hakkımda',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const InfoPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app_rounded),
              title: const Text(
                'Çıkış Yap',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
