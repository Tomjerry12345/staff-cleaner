import 'package:flutter/material.dart';

import '../../component/bottom-bar/bottom_bar_admin_component.dart';
import '../../values/color.dart';
import '../models/item_menu.dart';
import 'home/home_admin_screen.dart';
import 'list-user/list_user_staff.dart';

class AdminMain extends StatefulWidget {
  const AdminMain({super.key});

  @override
  State<AdminMain> createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {
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

  final List<Widget> bottomBarPages = [
    const HomeAdminScreen(),
    const ListUserStaff(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
              bottomBarPages.length, (index) => bottomBarPages[index]),
        ),
        extendBody: true,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: primaryColor,
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const BottomBarAdmin());
  }
}
