import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:dayoff/on_generate_route.dart';
import 'package:dayoff/core/intl/firebase_ui_label_overrides.dart';
import 'package:dayoff/features/navigation/cubit/navigation_cubit.dart';
import 'package:dayoff/features/notes/presentation/cubit/note_cubit.dart';
import 'package:dayoff/features/navigation/presentation/root_screen.dart';
import 'package:dayoff/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:dayoff/features/auth/presentation/cubit/user/user_cubit.dart';
import 'package:dayoff/features/auth/presentation/screens/sign_in_page.dart';

import 'package:flutterfire_ui/i10n.dart';
import 'injection_container.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(create: (context) => NavigationCubit()),
        BlocProvider<AuthCubit>(
            create: (_) => di.sl<AuthCubit>()..appStarted()),
        BlocProvider<UserCubit>(create: (_) => di.sl<UserCubit>()),
        BlocProvider<NoteCubit>(create: (_) => di.sl<NoteCubit>()),
      ],
      child: MaterialApp(
        title: 'Dayoff App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
          useMaterial3: true,
        ),
        navigatorObservers: <NavigatorObserver>[observer],
        localizationsDelegates: [
          // Creates an instance of FirebaseUILocalizationDelegate with overridden labels
          FlutterFireUILocalizations.withDefaultOverrides(
              const LabelOverrides()),

          // Delegates below take care of built-in flutter widgets
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,

          // This delegate is required to provide the labels that are not overridden by LabelOverrides
          FlutterFireUILocalizations.delegate,
        ],
        initialRoute: '/',
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthStateCustom>(
                builder: (context, authState) {
              if (authState is Authenticated) {
                return RootScreen(uid: authState.uid);
              }
              if (authState is UnAuthenticated) {
                return const SignInPage();
              }

              return const CircularProgressIndicator();
            });
          }
        },
      ),
    );
  }
}
