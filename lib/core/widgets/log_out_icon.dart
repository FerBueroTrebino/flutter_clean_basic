import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dayoff/features/auth/presentation/cubit/auth/auth_cubit.dart';

class LogOutIcon extends StatelessWidget {
  const LogOutIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        BlocProvider.of<AuthCubit>(context).loggedOut();
        Navigator.pop(context);
      },
      icon: const Icon(Icons.exit_to_app),
    );
  }
}
