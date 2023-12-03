import 'package:flutter/material.dart';
import 'package:inspire_gyms/constants/app_colors.dart';
import 'package:inspire_gyms/widgets/gradient_text_widget.dart';


class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      title: Row(
        children: <Widget>[
          const SizedBox(width: 60),
          const GradientText(
            'Inspire',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontFamily: 'EmonaW00-Condensed'),
            gradient: LinearGradient(colors: [
              AppColors.secondaryColor,
              AppColors.iconColor,
            ]),
          ),
          const SizedBox(width: 2),
          Image.asset('assets/icons/location.png',
              width: 40, height: 40, color: AppColors.iconColor),
          const SizedBox(width: 2),
          const GradientText(
            'Gym',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontFamily: 'EmonaW00-Condensed'),
            gradient: LinearGradient(colors: [
              AppColors.iconColor,
              AppColors.quaternaryColor,
            ]),
          ),
        ],
      ),
    );
  }
}