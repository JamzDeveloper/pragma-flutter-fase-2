
import 'package:fake_store/features/auth/screen/login_screen.dart';
import 'package:fake_store/features/home/screens/home_shell.dart';
import 'package:fake_store/features/home/screens/tabs/home_tab.dart';
import 'package:fake_store/features/home/screens/tabs/cart_tab.dart';
import 'package:fake_store/features/home/screens/tabs/profile_tab.dart';
import 'package:fake_store/features/support_contact/screen/support_contact.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/support_contact',
      name: 'support contact',
      builder: (context, state) => const SupportScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => HomeShell(child: child),
      routes: [
        GoRoute(
          path: '/home',
          name: 'home',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeTab(),
          ),
        ),
        GoRoute(
          path: '/cart',
          name: 'cart',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: CartTab(),
          ),
        ),
     
        GoRoute(
          path: '/profile',
          name: 'profile',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ProfileTab(),
          ),
        ),
      ],
    ),
  ],
);
