import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poco_hackers_app/constants/ENavigation.dart';
import 'package:poco_hackers_app/ui/screens/sign_in/sign_in.dart';
import 'package:poco_hackers_app/widgets/CWidgets.dart';

import '../../../constants/CColors.dart';
import '../../../constants/CDimensions.dart';
import '../../../generated/l10n.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _footer,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.current.signUp,
              style: const TextStyle(fontSize: 36),
            ),
            spacerVertical(32),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: S.current.fullName,
                // hintText: S.current.enterName,
                prefixIcon: const Icon(Icons.email),
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              // validator: MultiValidator([
              //   RequiredValidator(errorText: 'Email is required'),
              //   EmailValidator(errorText: 'Invalid email format'),
              // ]),
            ),
            spacerVertical16,
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: S.current.workEmail,
                // hintText: S.current.workEmail,
                prefixIcon: const Icon(Icons.lock),
                border: const OutlineInputBorder(),
              ),
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              // validator: RequiredValidator(errorText: 'Password is required'),
            ),
            spacerVertical16,

            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                // hintText: 'Enter your password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              // validator: RequiredValidator(errorText: 'Password is required'),
            ),
            spacerVertical16,

            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: S.current.confirmPassword,
                // hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock),
                border: const OutlineInputBorder(),
              ),
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              // validator: RequiredValidator(errorText: 'Password is required'),
            ),
            spacerVertical(24),
            ElevatedButton(
              onPressed: () {
                // if (_formKey.currentState!.validate()) {
                //   // Process login/signup
                //   print('Email: ${_emailController.text}');
                //   print('Password: ${_passwordController.text}');
                // }

                context.pop();
              },
              child: const Text('Enter'),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _footer {
    return Container(
      height: CDimensions.footerHeight,
      color: Colors.grey[200], // Customize background color
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(S.current.noAccount),
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              S.current.signIn,
              style: const TextStyle(color: CColor.mainRed),
            ),
          ),
        ],
      ),
    );
  }
}
