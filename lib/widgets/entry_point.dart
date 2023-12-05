import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:inspire_gyms/constants/app_colors.dart';
import 'package:inspire_gyms/screens/favourites_page.dart';
import 'package:inspire_gyms/screens/home_page.dart';
import 'package:inspire_gyms/screens/map_page.dart';
import 'package:inspire_gyms/widgets/appbar_widget.dart';
import 'package:inspire_gyms/widgets/drawer_widget.dart';


class EntryPoint extends StatefulWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  late int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    FavoritiesPage(),
    MapPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: MyDrawer(
        selectedIndex: _selectedIndex,
        onDrawerItemTap: (index) {
          _updateIndex(index);
        },
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: AppColors.quaternaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
            backgroundColor: AppColors.quaternaryColor,
            color: AppColors.secondaryColor,
            activeColor: AppColors.primaryColor,
            tabBackgroundColor: AppColors.tertiaryColor,
            gap: 8,
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              _updateIndex(index);
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
                icon: Icons.map_sharp,
                text: 'Konum',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}