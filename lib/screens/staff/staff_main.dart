import 'package:flutter/material.dart';
import 'package:staff_cleaner/screens/staff/home/home_staff_screen.dart';
import 'package:staff_cleaner/screens/staff/profile/profil_screen.dart';

import '../../component/bottom-bar/bottom_bar_staff_component.dart';
import '../models/item_menu.dart';

class StaffMain extends StatefulWidget {
  const StaffMain({super.key});

  @override
  State<StaffMain> createState() => _StaffMainState();
}

class _StaffMainState extends State<StaffMain> {
  final _pageController = PageController(initialPage: 0);

  int maxCount = 2;

  final List<ItemMenu> item = [
    ItemMenu(
      icon: Icons.home_filled,
    ),
    ItemMenu(
      icon: Icons.people,
    )
  ];

  /// widget list
  final List<Widget> bottomBarPages = [
    const HomeStaffScreen(),
    const ProfileScreen(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(bottomBarPages.length, (index) => bottomBarPages[index]),
        ),
        extendBody: true,
        bottomNavigationBar: (bottomBarPages.length <= maxCount)
            ? BottomBarStaffComponent(
                pageController: _pageController,
                item: item,
              )
            : null);
  }
}
