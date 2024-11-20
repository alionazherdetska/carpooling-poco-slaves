import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poco_hackers_app/constants/CColors.dart';

class CreateRideScreen extends StatefulWidget {
  const CreateRideScreen({super.key});

  @override
  State<CreateRideScreen> createState() => _CreateRideScreenState();
}

class _CreateRideScreenState extends State<CreateRideScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GoRouterState.of(context).name ?? ''),
        backgroundColor: CColor.appBarColor,
      ),
      body: _body,
    );
  }

  Widget get _body {
    return Center(
        child: Column(children: [
      TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: CColor.appBarColor,
          hintText: 'Enter text here',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      const SizedBox(height: 16.0),
      TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: CColor.appBarColor,
          hintText: 'Enter text here',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none, // Remove border
          ),
        ),
      ),
    ]));
  }
}
