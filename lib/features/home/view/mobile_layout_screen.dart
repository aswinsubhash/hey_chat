import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hey_chat/features/auth/controller/auth_controller.dart';
import 'package:hey_chat/utils/colors.dart';
import 'package:hey_chat/features/select_contacts/view/select_contacts_screen.dart';
import 'package:hey_chat/features/chat/widgets/contacts_list.dart';

class MobileLayoutScreen extends ConsumerStatefulWidget {
  const MobileLayoutScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MobileLayoutScreen> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends ConsumerState<MobileLayoutScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserState(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: appBarColor,
          centerTitle: false,
          title: const Text(
            'HeyChat',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.grey),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.grey),
              onPressed: () {},
            ),
          ],
          bottom: const TabBar(
            indicatorColor: tabColor,
            indicatorWeight: 4,
            labelColor: tabColor,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(
                text: 'CHATS',
                icon: Icon(
                  Icons.messenger,
                  size: 18,
                ),
              ),
              Tab(
                text: 'STORIES',
                icon: Icon(
                  Icons.blur_circular_rounded,
                  size: 18,
                ),
              ),
              Tab(
                text: 'CALLS',
                icon: Icon(
                  Icons.call_rounded,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
        body: const ContactsList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, SelectContactScreen.routeName);
          },
          backgroundColor: tabColor,
          child: const Icon(
            Icons.chat_bubble,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
