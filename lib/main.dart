import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hey_chat/colors.dart';
import 'package:hey_chat/features/landing/screens/landing_screen.dart';
import 'package:hey_chat/firebase_options.dart';
import 'package:hey_chat/router.dart';
import 'package:hey_chat/screens/mobile_layout_screen.dart';
import 'package:hey_chat/screens/web_layout_screen.dart';
import 'package:hey_chat/utils/responsive_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Hey Chat',
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: const AppBarTheme(
            color: appBarColor,
          )),
      onGenerateRoute: (settings) => generateRoute(settings),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileLayoutScreen(),
      //   webScreenLayout: WebLayoutScreen(),
      // ),
      home: const LandingScreen(),
    );
  }
}
