import 'package:flutter/material.dart';
import 'package:jemputah_app_driver/constants/color.dart';
import 'package:jemputah_app_driver/constants/icons.dart';
import 'package:jemputah_app_driver/constants/size.dart';
import 'package:jemputah_app_driver/screens/featured_screen.dart';
import 'package:jemputah_app_driver/screens/home_screen.dart';
import 'package:jemputah_app_driver/screens/pesanan_screen.dart';
import 'package:jemputah_app_driver/screens/tukar_screen.dart';
import 'package:jemputah_app_driver/screens/profile_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Pesanan(),
    ProfilScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.brokenWhite,
          backgroundColor: AppColors.mainGreen,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                isHome,
                height: kBottomNavigationBarItemSize,
              ),
              icon: Image.asset(
                isHomeNotSelected,
                height: kBottomNavigationBarItemSize,
              ),
              label: "HOME",
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                isPesanan,
                height: kBottomNavigationBarItemSize,
              ),
              icon: Image.asset(
                isPesananNotSelected,
                height: kBottomNavigationBarItemSize,
              ),
              label: "PESANAN",
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                isProfil,
                height: kBottomNavigationBarItemSize,
              ),
              icon: Image.asset(
                isProfilNotSelected,
                height: kBottomNavigationBarItemSize,
              ),
              label: "PROFIL",
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
