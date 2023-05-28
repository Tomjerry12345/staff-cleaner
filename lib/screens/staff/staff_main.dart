import 'package:flutter/material.dart';
import 'package:staff_cleaner/screens/staff/home/home_staff_screen.dart';
import 'package:staff_cleaner/screens/staff/profile/profil_screen.dart';

import '../../component/bottom-bar/bottom_bar_staff_component.dart';
import '../../values/kunci_utils.dart';
import '../models/item_menu.dart';

class StaffMain extends StatefulWidget {
  final int initialPage;
  const StaffMain({super.key, this.initialPage = 0});

  @override
  State<StaffMain> createState() => _StaffMainState();
}

class _StaffMainState extends State<StaffMain> {
  int maxCount = 2;
  PageController _controller = PageController(initialPage: 0);

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
  void initState() {
    super.initState();
    setState(() {
      _controller = PageController(initialPage: widget.initialPage);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(bottomBarPages.length, (index) => bottomBarPages[index]),
        ),
        extendBody: true,
        bottomNavigationBar: (bottomBarPages.length <= maxCount)
            ? BottomBarStaffComponent(
                pageController: _controller,
                item: item,
              )
            : null);
  }
}
