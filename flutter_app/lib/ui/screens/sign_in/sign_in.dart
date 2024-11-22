import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poco_hackers_app/constants/CDimensions.dart';
import 'package:poco_hackers_app/constants/ENavigation.dart';
import 'package:poco_hackers_app/generated/l10n.dart';
import 'package:poco_hackers_app/repo/AuthenticationApi.dart';
import 'package:poco_hackers_app/repo/AuthenticationApiImpl.dart';
import 'package:poco_hackers_app/widgets/CWidgets.dart';
import 'package:provider/provider.dart';

import '../../../constants/CColors.dart';
import '../../../viewmodels/LoginViewModel.dart';
import '../sign_up/sign_up.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = AuthenticationRepositoryImpl();
    final _loginVM = LoginViewModel(auth);

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(S.current.signIn, style: const TextStyle(fontSize: 36),),
              const SizedBox(height: 32),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                // validator: MultiValidator([
                //   RequiredValidator(errorText: 'Email is required'),
                //   EmailValidator(errorText: 'Invalid email format'),
                // ]),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                // validator: RequiredValidator(errorText: 'Password is required'),
              ),
      
      
              spacerVertical(),
      
              _forgotPasswordButton,
      
              ElevatedButton(
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  //   // Process login/signup
                  //   print('Email: ${_emailController.text}');
                  //   print('Password: ${_passwordController.text}');
                  // }

                   _loginVM.signUpUser(null);
                  //_loginVM.getUser("userId");

                  //context.go(ENavigation.home.path);
                },
                child: const Text('Submit'),
              ),
      
            ],
          ),
        ),
      
        bottomNavigationBar: _footer,
    );
  }


  Widget get _forgotPasswordButton {
    return TextButton(
      onPressed: () {
        //_signInViewModel.launchForgot();
      },
      child: Text(
        S.current.forgotPassword,
        style: const TextStyle(
          color: CColor.black,
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen(),));
            },
            child: Text(S.current.signUp, style: const TextStyle(color: CColor.mainRed),),
          ),
        ],
      ),
    );
  }
}
