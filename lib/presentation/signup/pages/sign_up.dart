import 'package:flutter/material.dart';
import 'package:geeksynergymt/core/colors/colors.dart';
import 'package:geeksynergymt/core/constants/styles.dart';
import 'package:geeksynergymt/data/models/user_model.dart';
import 'package:geeksynergymt/presentation/login/pages/login.dart';
import 'package:geeksynergymt/presentation/login/widgets/loginform.dart';
import 'package:hive_flutter/adapters.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController professionController = TextEditingController();

  final ValueNotifier<String?> selectedProfession =
      ValueNotifier<String?>(null);

  final List<String> professions = [
    'Engineer',
    'Doctor',
    'Artist',
    'Teacher',
    'Other'
  ];
  Future<void> _signUp(BuildContext context) async {
    final box = await Hive.openBox<User>('userBox');

    final user = User(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      phone: phoneController.text,
      profession: selectedProfession.value ?? 'Unknown',
    );

    await box.add(user);

    await box.close();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User signed up successfully!')),
    );
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kblack,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign Up',
              style: kstyle,
            ),
            height10,
            Formfield(
              labelText: 'Name',
              controller: nameController,
            ),
            height10,
            Formfield(
              labelText: 'Email id',
              controller: emailController,
            ),
            height10,
            Formfield(
              labelText: 'Password',
              controller: passwordController,
            ),
            height10,
            Formfield(
              labelText: 'Phone no',
              controller: phoneController,
            ),
            height10,
            ValueListenableBuilder<String?>(
              valueListenable: selectedProfession,
              builder: (context, value, child) {
                return DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Profession',
                    filled: true,
                    fillColor: Colors.black,
                    labelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: kwhite),
                    ),
                  ),
                  dropdownColor: Colors.black,
                  value: value,
                  onChanged: (newValue) {
                    selectedProfession.value = newValue;
                  },
                  items: professions.map((profession) {
                    return DropdownMenuItem(
                      value: profession,
                      child: Text(profession, style: const TextStyle(color: kwhite)),
                    );
                  }).toList(),
                );
              },
            ),
            ElevatedButton(
                onPressed: () {
                  _signUp(context);
                },
                child: const Text('Sign Up')),
          ],
        ),
      ),
    );
  }
}
