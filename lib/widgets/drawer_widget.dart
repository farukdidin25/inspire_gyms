import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inspire_gyms/constants/app_colors.dart';
import 'package:inspire_gyms/screens/home_page.dart';
import 'package:inspire_gyms/screens/howto_page.dart';
import 'package:inspire_gyms/screens/info_page.dart';
import 'package:inspire_gyms/widgets/gradient_text_widget.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          color: AppColors.backgroundColor,
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      // Image'a tıklandığında HomePage'e git
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/icons/location.png',
                          width: 80,
                          height: 80,
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
                  style: TextStyle(fontSize: 20),
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
                  style: TextStyle(fontSize: 20),
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
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
