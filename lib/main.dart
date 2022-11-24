import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hey_chat/colors.dart';
import 'package:hey_chat/common/widgets/error.dart';
import 'package:hey_chat/common/widgets/loader.dart';
import 'package:hey_chat/features/auth/controller/auth_controller.dart';
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
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Hey Chat',
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: const AppBarTheme(
            color: appBarColor,
          )),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userDataAuthProvider).when(
            data: (user) {
              if (user == null) {
                return const LandingScreen();
              }
              return const MobileLayoutScreen();
            },
            error: (error, stackTrace) {
              return ErrorScreen(
                error: error.toString(),
              );
            },
            loading: () => const Loader(),
          ),
    );
  }
}
