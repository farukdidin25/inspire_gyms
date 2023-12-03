import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:inspire_gyms/constants/app_colors.dart';
import 'package:inspire_gyms/screens/favourites_page.dart';
import 'package:inspire_gyms/screens/profile_page.dart';
import 'package:inspire_gyms/screens/home_page.dart';
import 'package:inspire_gyms/widgets/appbar_widget.dart';
import 'package:inspire_gyms/widgets/drawer_widget.dart';


class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const FavoritiesPage(),
    const ProfilePage(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const MyDrawer(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: AppColors.quaternaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: GNav(
            backgroundColor: AppColors.quaternaryColor,
            color: AppColors.secondaryColor,
            activeColor: AppColors.primaryColor,
            tabBackgroundColor: AppColors.tertiaryColor,
            gap: 8,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home_outlined,
                text: 'Ana Sayfa',
              ),
              GButton(
                icon: Icons.favorite_border,
                text: 'Favoriler',
              ),
              GButton(
                icon: Icons.person_2_outlined,
                text: 'Profil',
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}