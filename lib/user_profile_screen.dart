import 'package:dayoff/core/widgets/log_out_icon.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  //POR AHORA DEJO ESTA PANTALLA AQUI,
  // DEBO DEFINIR SI TODA LA INFO DEL USUARIO SE VA A MANEJAR DEL ESPACIO PERSONAL,
  // O SI DIVIDIMOS lA INFO PRINCIPAL Y LUEGO LO REFERENTE A LA APP

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: Text('Logout:')),
          LogOutIcon(),
        ],
      ),
    );
  }
}
