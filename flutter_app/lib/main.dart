import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poco_hackers_app/constants/ENavigation.dart';
import 'package:poco_hackers_app/ui/screens/create_ride/create_ride.dart';
import 'package:poco_hackers_app/ui/screens/find_ride/find_ride.dart';
import 'package:poco_hackers_app/ui/screens/home/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:poco_hackers_app/ui/screens/map/map.dart';
import 'package:poco_hackers_app/ui/screens/sign_in/sign_in.dart';
import 'package:poco_hackers_app/ui/screens/sign_up/sign_up.dart';
import 'generated/l10n.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  /// The route configuration.
  final GoRouter _router = GoRouter(
    initialLocation: ENavigation.signIn.path,
    routes: <RouteBase>[
      GoRoute(
        path: ENavigation.signIn.path,
        name: ENavigation.signIn.name,
        builder: (BuildContext context, GoRouterState state) {
          return const SignInScreen();
        },
      ),
      GoRoute(
        path: ENavigation.signUp.path,
        name: ENavigation.signUp.name,
        builder: (BuildContext context, GoRouterState state) {
          return SignUpScreen();
        },
      ),
      GoRoute(
        path: ENavigation.home.path,
        name: ENavigation.home.name,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
        routes: [
          GoRoute(
            path: ENavigation.createRide.path,
            name: ENavigation.createRide.name,
            builder: (BuildContext context, GoRouterState state) {
              return const CreateRideScreen();
            },
          ),
          GoRoute(
            path: ENavigation.findRide.path,
            name: ENavigation.findRide.name,
            builder: (BuildContext context, GoRouterState state) {
              return const FindRideScreen();
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const Scaffold(
      body: Center(
        child: Text('404 - Page not found'),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
