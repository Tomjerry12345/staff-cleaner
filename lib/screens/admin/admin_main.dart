import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staff_cleaner/screens/admin/tambah-data/tambah_data_customer.dart';
import 'package:staff_cleaner/values/navigate_utils.dart';

import '../../component/bottom-bar/bottom_bar_admin_component.dart';
import '../../main.dart';
import '../../services/firebase_services.dart';
import '../../values/color.dart';
import '../../values/kunci_utils.dart';
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
  int _selectedIndex = 0;

  int maxCount = 2;

  FirebaseServices fs = FirebaseServices();

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: bottomBarPages.elementAt(_selectedIndex),
        extendBody: true,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigatePush(TambahDataCustomer());
          },
          backgroundColor: primaryColor,
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomBarAdmin(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ));
  }
}
