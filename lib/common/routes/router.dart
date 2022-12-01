import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hey_chat/common/widgets/error.dart';
import 'package:hey_chat/features/auth/view/login_screen.dart';
import 'package:hey_chat/features/auth/view/otp_screen.dart';
import 'package:hey_chat/features/auth/view/user_information_screen.dart';
import 'package:hey_chat/features/chat/view/mobile_chat_screen.dart';
import 'package:hey_chat/features/home/view/confirm_status_screen.dart';
import 'package:hey_chat/features/select_contacts/view/select_contacts_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {

    //login screen route
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );

    //OTP screen route
    case OTPScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OTPScreen(verificationId: verificationId),
      );

    //UserInfoScreen route
    case UserInformationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserInformationScreen(),
      );

    //Selectcontact screen route
    case SelectContactScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SelectContactScreen(),
      );

    //Mobilechat screen route
    case MobileChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      return MaterialPageRoute(
        builder: (context) => MobileChatScreen(
          name: name,
          uid: uid,
        ),
      );

    // confirm status route
    case ConfirmStatusScreen.routeName:
      final file = settings.arguments as File;
      return MaterialPageRoute(
        builder: (context) => ConfirmStatusScreen(
          file: file,
        ),
      );

    //error screen route
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: "This page doesn't exist"),
        ),
      );
  }
}
