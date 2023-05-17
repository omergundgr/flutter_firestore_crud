import 'package:firebase_crud/services/firebase_service.dart';
import 'package:firebase_crud/widgets/appbar_widget.dart';
import 'package:firebase_crud/widgets/custom_button.dart';
import 'package:flutter/material.dart';

enum ActionType { insert, update }

class ActionScreen extends StatelessWidget {
  ActionScreen({super.key});

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Widget titleWidget(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget inputWidget(
      {TextEditingController? controller, bool multiLine = false}) {
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white38, width: 1.5));
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        maxLines: multiLine ? 7 : null,
        decoration: InputDecoration(
            border: border, enabledBorder: border, focusedBorder: border),
      ),
    );
  }

  void _getPostData(String title, String description) {
    _titleController.text = title;
    _descriptionController.text = description;
  }

  @override
  Widget build(BuildContext context) {
    final (userId, actionType, id, title, description) = ModalRoute.of(context)!
        .settings
        .arguments as (String, ActionType, String?, String?, String?);
    if (actionType == ActionType.update) {
      _getPostData(title!, description!);
    }
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              titleWidget("Başlık"),
              inputWidget(controller: _titleController),
              titleWidget("Açıklama"),
              inputWidget(controller: _descriptionController, multiLine: true),
              CustomButton(
                text:
                    actionType == ActionType.insert ? "POST EKLE" : "GÜNCELLE",
                onPressed: () {
                  if (actionType == ActionType.insert) {
                    FirebaseService().insertPost(
                        userId: userId,
                        title: _titleController.text,
                        description: _descriptionController.text);
                  } else {
                    FirebaseService().updatePost(
                        userId: userId,
                        id: id!,
                        title: _titleController.text,
                        description: _descriptionController.text,
                        post: {
                          "title": title,
                          "description": description,
                          "id": id
                        }).then((value) => Navigator.of(context).pop());
                  }
                },
              ),
              if (actionType == ActionType.update) ...[
                const SizedBox(height: 15),
                CustomButton(
                    text: "KALDIR",
                    onPressed: () => FirebaseService().removePost(
                            userId: userId,
                            post: {
                              "title": title,
                              "description": description,
                              "id": id
                            }).then((value) => Navigator.of(context).pop()))
              ]
            ],
          ),
        ),
      ),
    );
  }
}
