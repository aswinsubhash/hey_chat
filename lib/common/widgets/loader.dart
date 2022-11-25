
import 'package:flutter/material.dart';
import 'package:hey_chat/utils/colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: tabColor,
      ),
    );
  }
}