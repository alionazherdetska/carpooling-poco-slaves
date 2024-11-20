import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poco_hackers_app/constants/CColors.dart';
import 'package:poco_hackers_app/generated/l10n.dart';

class FindRideScreen extends StatefulWidget {
  const FindRideScreen({super.key});

  @override
  State<FindRideScreen> createState() => _FindRideScreenState();
}

class _FindRideScreenState extends State<FindRideScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.findRide),
        backgroundColor: CColor.lightGrey,
      ),
      body: _body,
    );
  }

  Widget get _body {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 150.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: CColor.appBarColor2,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: CColor.appBarColor2,
                  hintText: S.current.pickUpLocation,
                  border: InputBorder.none,
                ),
              ),
        
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(),
              ),
        
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: CColor.appBarColor2,
                  hintText: S.current.whereTo,
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
