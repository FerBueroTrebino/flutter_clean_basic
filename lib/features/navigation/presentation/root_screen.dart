import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dayoff/features/chat_bot/presentation/ai_screen.dart';
import 'package:dayoff/features/navigation/cubit/navigation_cubit.dart';
import 'package:dayoff/features/navigation/constants/nav_bar_items.dart';
import 'package:dayoff/features/notes/presentation/calendar_screen.dart';
import 'package:dayoff/features/notes/presentation/screens/notes_screen.dart';
import 'package:dayoff/user_profile_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key, required this.uid});

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dayoff App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<UserProfileScreen>(
                  builder: (context) => const UserProfileScreen(),
                ),
              );
            },
          )
        ],
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          final navigationProvider = BlocProvider.of<NavigationCubit>(context);
          return NavigationBar(
            selectedIndex: state.index,
            onDestinationSelected: (int index) {
              if (index == 0) {
                navigationProvider.getNavBarItem(NavbarItem.personal);
              } else if (index == 1) {
                navigationProvider.getNavBarItem(NavbarItem.calendar);
              } else if (index == 2) {
                navigationProvider.getNavBarItem(NavbarItem.chat);
              }
            },
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: const <NavigationDestination>[
              NavigationDestination(
                selectedIcon: Icon(Icons.document_scanner),
                icon: Icon(Icons.document_scanner_outlined),
                label: 'Mi Espacio',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.calendar_month),
                icon: Icon(Icons.calendar_month_outlined),
                label: 'Calendario',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.speaker_phone),
                icon: Icon(Icons.speaker_phone_sharp),
                label: 'Chat',
              ),
            ],
          );
        },
      ),
      body: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
        if (state.navbarItem == NavbarItem.chat) {
          return const AiScreen();
        } else if (state.navbarItem == NavbarItem.calendar) {
          return const CalendarScreen();
        } else if (state.navbarItem == NavbarItem.personal) {
          return NotesScreen(uid: uid);
        }
        return Container();
      }),
    );
  }
}
