
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dayoff/features/navigation/constants/nav_bar_items.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(NavbarItem.personal, 0));

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.personal:
        emit(const NavigationState(NavbarItem.personal, 0));
        break;
      case NavbarItem.calendar:
        emit(const NavigationState(NavbarItem.calendar, 1));
        break;
      case NavbarItem.chat:
        emit(const NavigationState(NavbarItem.chat, 2));
        break;
    }
  }
}
