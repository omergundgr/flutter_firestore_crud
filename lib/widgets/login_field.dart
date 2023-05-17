import 'package:firebase_crud/utils/colors.dart';
import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  final TextEditingController? controller;
  const LoginField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
        borderSide: BorderSide(color: KColors.secondaryColor, width: 1));
    return TextField(
      controller: controller,
      enabled: true,
      decoration: const InputDecoration(
          labelText: "Kullanıcı ID",
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold, color: KColors.secondaryColor),
          enabledBorder: border,
          focusedBorder: border),
    );
  }
}
