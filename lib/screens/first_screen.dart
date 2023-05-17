import 'package:flutter/material.dart';
import '../utils/images.dart';
import '../widgets/custom_button.dart';
import '../widgets/login_field.dart';

class FirstScreen extends StatelessWidget {
   FirstScreen({super.key});

  final _userIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(KImages.firebaseLogo, scale: 3),
              LoginField(controller: _userIdController),
              const SizedBox(height: 30),
              CustomButton(
                text: "GİRİŞ",
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("/posts", arguments: _userIdController.text);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
