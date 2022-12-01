// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hey_chat/features/status/controller/status_controller.dart';
import 'package:hey_chat/utils/colors.dart';

class ConfirmStatusScreen extends ConsumerWidget {
  static const String routeName = '/confirm-status-screen';
  final File file;

  const ConfirmStatusScreen({
    Key? key,
    required this.file,
  }) : super(key: key);

  void addStatus(WidgetRef ref, BuildContext context) {
    ref.read(statusControllerProvider).addStatus(
          file,
          context,
        );
        Navigator.pop(context); // 8:05:20 display status/stories
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: Image.file(file),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: tabColor,
        child: const Icon(
          Icons.done,
          color: whiteColor,
        ),
        onPressed: () => addStatus(ref, context),
      ),
    );
  }
}
