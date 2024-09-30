import 'package:flutter/material.dart';
import 'post_detail.dart';


class PlusScreen extends StatelessWidget {
  final VoidCallback goHome;
  const PlusScreen({required this.goHome, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            goHome();
          },
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Share Your Thoughts',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(width: 40),
          ],
        ),
        elevation: 1,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: 40,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetail(imagePath: 'assets/image$index.jpg'),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/image$index.jpg', fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}