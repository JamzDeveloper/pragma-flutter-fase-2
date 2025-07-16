import 'package:fake_store/core/theme/light_theme.dart';
import 'package:fake_store/features/auth/data/auth_service.dart';
import 'package:fake_store/features/auth/state/auth_bloc.dart';
import 'package:fake_store/features/home/state/cart/cart_bloc.dart';
import 'package:fake_store/features/home/state/products/product_bloc.dart';
import 'package:fake_store/features/home/state/products/product_event.dart';
import 'package:fake_store/features/home/state/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/routing/app_router.dart';
import 'package:fake_store_client/fake_store_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(AuthService())),

        BlocProvider(
          create: (_) => ProductBloc(FakeStoreClient())..add(LoadProducts()),
        ),
        BlocProvider(create: (_) => UserBloc(FakeStoreClient())),
        BlocProvider(create: (_) => CartBloc()),
      ],

      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        title: 'Fase 2 Demo',
        routerConfig: appRouter,
      ),
    );
  }
}
