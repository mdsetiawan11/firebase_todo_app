import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_todo_app/presentation/auth/auth_gate.dart';
import 'package:firebase_todo_app/presentation/home/home_page.dart';
import 'package:firebase_todo_app/utils/firebase_options.dart';
import 'package:firebase_todo_app/presentation/auth/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'presentation/auth/signin_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const AuthGate();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'signin',
          builder: (BuildContext context, GoRouterState state) {
            return const SigninPage();
          },
        ),
        GoRoute(
          path: 'signup',
          builder: (BuildContext context, GoRouterState state) {
            return const SignupPage();
          },
        ),
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp.router(
      title: 'Todo App',
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      theme: ShadThemeData(
          colorScheme: const ShadSlateColorScheme.light(),
          brightness: Brightness.light,
          textTheme: ShadTextTheme.fromGoogleFont(GoogleFonts.poppins)),
      routerConfig: _router,
    );
  }
}
