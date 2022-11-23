import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:hey_chat/colors.dart';
import 'package:hey_chat/common/widgets/common_widgets.dart';
import 'package:hey_chat/common/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country countryy) {
          setState(() {
            country = countryy;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text('Enter your phone number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(19.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('HeyChat will need to verify your phone number'),
            commonSizedBox(10),
            TextButton(
              onPressed: pickCountry,
              child: const Text('Pick Country'),
            ),
            commonSizedBox(5),
            Row(
              children: [
                if(country != null)
                Text('+${country!.phoneCode}'),
                commonWidthBox(10),
                SizedBox(
                  width: size.width * 0.7,
                  child: TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(hintText: 'phone number'),
                  ),
                )
              ],
            ),
            commonSizedBox(size.height * 0.6),
            SizedBox(
              width: 90,
              child: CustomButton(
                text: 'NEXT',
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
