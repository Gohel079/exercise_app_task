import 'package:exercise_app/constant/app_colors.dart';
import 'package:exercise_app/constant/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(child: Text('API Call Successfully',
          style: styleLarge1.copyWith(color: secondaryColor,fontSize: 20,
              fontWeight: FontWeight.w600),),),
      ),
    );
  }
}
