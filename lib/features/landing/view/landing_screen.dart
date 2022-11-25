import 'package:flutter/material.dart';
import 'package:hey_chat/utils/colors.dart';
import 'package:hey_chat/common/widgets/common_widgets.dart';
import 'package:hey_chat/common/widgets/custom_button.dart';
import 'package:hey_chat/features/auth/view/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            commonSizedBox(50),
            const Text(
              'Welcome to HeyChat',
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.w600,
              ),
            ),
            commonSizedBox(size.height / 13),
            ClipRRect(
              borderRadius: BorderRadius.circular(280.0),
              child: Image.asset(
                'assets/landingscreen.png',
                height: 350,
                width: 350,
                fit: BoxFit.cover,
                color: tabColor,
              ),
            ),
            commonSizedBox(size.height / 13),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Read our Privacy Policy. Tap "Agree and continue" to accept the Terms of Service.',
                style: TextStyle(color: greyColor),
                textAlign: TextAlign.center,
              ),
            ),
            commonSizedBox(10),
            SizedBox(
              width: size.width * 0.75,
              child: CustomButton(
                text: 'AGREE AND CONTINUE',
                onPressed: () => navigateToLoginScreen(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
