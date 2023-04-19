import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:dayoff/app.dart';
import 'injection_container.dart' as di;

const clientId =
    '105523419023-gkq7cimkcijkkqn2p74cbspkh7lp1nar.apps.googleusercontent.com';
// const clientId = 'AIzaSyAZSHH7x__CyOiDwVNBbaZtdWiL3-JRm0s';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterFireUIAuth.configureProviders([
    const EmailProviderConfiguration(),
    const GoogleProviderConfiguration(clientId: clientId),
  ]);

  await di.init();

  runApp(const MyApp());
}
