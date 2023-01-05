import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hey_chat/features/auth/controller/auth_controller.dart';
import 'package:hey_chat/utils/utils.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user-information';
  const UserInformationScreen({super.key});

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void storeUserData() async {
    String name = nameController.text.trim();

    if (name.isNotEmpty) {
      ref.read(authControllerProvider).saveUserDataToFirebase(
            context,
            name,
            image,
          );
    }else{
      showSnackBar(context: context, content: 'Fill out all the fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Stack(
              children: [
                image == null
                    ? const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
                      )
                    : CircleAvatar(
                        radius: 64,
                        backgroundImage: FileImage(
                          image!,
                        ),
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(
                      Icons.add_a_photo_rounded,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: size.width * 0.85,
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your name',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: storeUserData,
                  icon: const Icon(
                    Icons.done,
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
