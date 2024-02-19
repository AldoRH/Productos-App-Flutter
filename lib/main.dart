import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());


class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => ProductService()),
        ChangeNotifierProvider(create: ( _ ) => AuthService())
      ],
      child: const MyApp(),
      );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: 'checking',
      routes: {
        'login' : ( _ ) => const LoginScreen(),
        'register' : ( _ ) => const RegisterScreen(),
        'home' : ( _ ) => const HomeScreen(),
        'product' : ( _ ) => const ProductScreen(),
        'checking' : ( _ ) => const CheckAuthScreen(),
      },
      scaffoldMessengerKey: NotificationsServices.messengerKey,
      theme: AppTheme.lightTheme,
    );
  }
}