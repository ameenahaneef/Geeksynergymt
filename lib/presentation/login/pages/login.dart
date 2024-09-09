import 'package:flutter/material.dart';
import 'package:geeksynergymt/core/colors/colors.dart';
import 'package:geeksynergymt/core/constants/styles.dart';
import 'package:geeksynergymt/data/models/user_model.dart';
import 'package:geeksynergymt/presentation/home/pages/home_screen.dart';
import 'package:geeksynergymt/presentation/login/widgets/loginform.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:geeksynergymt/presentation/signup/pages/sign_up.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  Future<void> _login(BuildContext context) async {
    final box = await Hive.openBox<User>('userBox');
    final users = box.values.toList();
    final enteredName = nameController.text;
    final enteredPassword = passwordController.text;

    User? matchingUser;
    try {
      matchingUser = users.firstWhere(
        (user) => user.name == enteredName && user.password == enteredPassword,
      );
    } catch (e) {
      matchingUser = null;
    }

    if (matchingUser != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(), 
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kblack,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Formfield(
                labelText: 'Name',
                controller: nameController,
              ),
              height10,
              Formfield(
                labelText: 'Password',
                controller: passwordController,
                
              ),
              height10,
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState?.validate() ?? false) {
                    _login(context);
                  }
                },
                child: const Text('Login'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a user?', style: kstyle),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
