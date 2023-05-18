import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:splashscreen/splashscreen.dart';
import 'package:staff_cleaner/screens/admin/home/home_admin_screen.dart';
import 'package:staff_cleaner/screens/autentikasi/login/login_screen.dart';
import 'package:staff_cleaner/screens/staff/home/home_staff_screen.dart';
import 'package:staff_cleaner/values/color.dart';
import 'package:staff_cleaner/values/global_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

import 'services/firebase_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: primaryColor,
      ),
      home: MainPage(),
      navigatorKey: GlobalContext.navigatorKey,
    );
  }
}

// ignore: must_be_immutable
class MainPage extends StatefulWidget {
  late Map<String, dynamic> data;

  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  FirebaseServices firebaseServices = FirebaseServices();

  @override
  void initState() {
    super.initState();
  }

  void getData(User? user) async {
    final res = await firebaseServices.getDataCollection("user", "email", user?.email);
    widget.data = res.first.data();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 8,
      image: Image.network('https://www.geeksforgeeks.org/wp-content/uploads/gfg_200X200.png'),
      photoSize: 100.0,
      backgroundColor: primaryColor,
      navigateAfterSeconds: StreamBuilder(
          stream: firebaseServices.checkLogged(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final user = snapshot.data;
              getData(user);
              final widgetData = widget.data;

              if (widgetData["type_account"] == "admin") {
                return const HomeAdminScreen();
              } else {
                return const HomeStaffScreen();
              }
            } else {
              return const LoginScreen();
            }
          }),
    );
  }
}
