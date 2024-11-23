import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poco_hackers_app/constants/ENavigation.dart';
import 'package:poco_hackers_app/ui/screens/sign_in/sign_in.dart';
import 'package:poco_hackers_app/widgets/CWidgets.dart';

import '../../../constants/CColors.dart';
import '../../../constants/CDimensions.dart';
import '../../../generated/l10n.dart';
import '../../../models/User.dart';
import '../../../repo/AuthenticationApiImpl.dart';
import '../../../viewmodels/LoginViewModel.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _makeController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _plateNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = AuthenticationRepositoryImpl();
    final _loginVM = LoginViewModel(auth);

    return Scaffold(
      bottomNavigationBar: _footer,
      body: SingleChildScrollView(
        child: Padding(
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
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: const Icon(Icons.person),
                  border: const OutlineInputBorder(),
                ),
              ),
              spacerVertical16,
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              spacerVertical16,
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              spacerVertical16,
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: const Icon(Icons.person),
                  border: const OutlineInputBorder(),
                ),
              ),
              spacerVertical16,
              TextFormField(
                controller: _surnameController,
                decoration: InputDecoration(
                  labelText: 'Surname',
                  prefixIcon: const Icon(Icons.person),
                  border: const OutlineInputBorder(),
                ),
              ),
              spacerVertical16,
              TextFormField(
                controller: _makeController,
                decoration: InputDecoration(
                  labelText: 'Make',
                  prefixIcon: const Icon(Icons.directions_car),
                  border: const OutlineInputBorder(),
                ),
              ),
              spacerVertical16,
              TextFormField(
                controller: _modelController,
                decoration: InputDecoration(
                  labelText: 'Model',
                  prefixIcon: const Icon(Icons.directions_car),
                  border: const OutlineInputBorder(),
                ),
              ),
              spacerVertical16,
              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(
                  labelText: 'Year',
                  prefixIcon: const Icon(Icons.calendar_today),
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              spacerVertical16,
              TextFormField(
                controller: _plateNumberController,
                decoration: InputDecoration(
                  labelText: 'Plate Number',
                  prefixIcon: const Icon(Icons.confirmation_number),
                  border: const OutlineInputBorder(),
                ),
              ),
              spacerVertical16,
              ElevatedButton(
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  //   // Process login/signup
                  //   print('Collected Data:');
                  //   print('Username: ${_usernameController.text}');
                  //   print('Email: ${_emailController.text}');
                  //   print('Password: ${_passwordController.text}');
                  //   print('Name: ${_nameController.text}');
                  //   print('Surname: ${_surnameController.text}');
                  //   print('Car: ${_makeController.text}, ${_modelController.text}, ${_yearController.text}, ${_plateNumberController.text}');
                  // }


                  _loginVM.signUpUser(
                      User(
                        username: _usernameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        name: _nameController.text,
                        surname: _surnameController.text,
                        car: Car(
                          make: _makeController.text,
                          model: _modelController.text,
                          year: int.parse(_yearController.text),
                          plateNumber: _plateNumberController.text,
                        ),
                      )
                  );

                  //context.pop();
                },
                child: const Text('Enter'),
              ),
            ],
          ),
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
