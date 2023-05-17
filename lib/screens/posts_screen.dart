import 'package:firebase_crud/screens/action_screen.dart';
import 'package:firebase_crud/services/firebase_service.dart';
import 'package:firebase_crud/services/models/post_model.dart';
import 'package:firebase_crud/utils/colors.dart';
import 'package:firebase_crud/widgets/post_item.dart';
import 'package:flutter/material.dart';
import '../widgets/appbar_widget.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String userId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: const MyAppBar(),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pushNamed("/action",
              arguments: (userId, ActionType.insert, null, null, null)),
          backgroundColor: KColors.secondaryColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          )),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: StreamBuilder<Posts>(
          stream: FirebaseService().getUserPostsAsStream(userId),
          builder: (context, snapshot) {
            final Posts? posts = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return Column(
              children: List.generate(posts!.posts.length, (index) {
                final Post post = posts.posts[index];
                return PostItem(
                    id: post.id,
                    userId: userId,
                    title: post.title,
                    description: post.description);
              }),
            );
          },
        )),
      ),
    );
  }
}
