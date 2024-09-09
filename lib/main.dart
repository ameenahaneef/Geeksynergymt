import 'package:flutter/material.dart';
import 'package:geeksynergymt/data/models/user_model.dart';
import 'package:geeksynergymt/presentation/login/pages/login.dart';
import 'package:hive_flutter/adapters.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
   await Hive.initFlutter();
   Hive.registerAdapter(UserAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

