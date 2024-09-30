import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  final String image;
  const Detail(this.image, {super.key});
  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool isBookmarked = false;
  bool isPostLiked = false;
  final TextEditingController _commentController = TextEditingController();
  List<String> comments = [];
  List<bool> isLiked = [];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Hero(
              tag: widget.image,
              child: Image.asset(widget.image),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    isPostLiked ? Icons.favorite : Icons.favorite_border,
                    color: isPostLiked ? Colors.red : Colors.black,
                  ),
                  onPressed: () {
                    setState (() {
                      isPostLiked = !isPostLiked;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isBookmarked = !isBookmarked;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isBookmarked ? Colors.grey[350] : Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    isBookmarked ? 'Disimpan' : 'Simpan',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(8),
              height: 300,
              color: Colors.grey[200],
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  if(isLiked.length <= index){
                    isLiked.add(false);
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: const AssetImage('assets/user.png'),
                          radius: 20,
                          backgroundColor: Colors.grey[600],
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(comments[index]),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        isLiked[index] ? Icons.favorite : Icons.favorite_border,
                                        color: isLiked[index] ? Colors.red : Colors.black,
                                      ),
                                      onPressed: (){
                                        setState(() {
                                          isLiked[index] = !isLiked[index];
                                        });
                                      },
                                      padding: const EdgeInsets.only(right: 30),
                                    ),

                                    IconButton(
                                      icon: const Icon(
                                        Icons.more_horiz, color: Colors.black),
                                      onPressed: () {

                                        FocusScope.of(context).unfocus();
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text("Laporan"),
                                              content: const Text(
                                                "Laporkan komentar ini?"),
                                              actions: [
                                                TextButton(
                                                  child: const Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                          'Komentar berhasil dilaporkan'
                                                        ),
                                                        duration: Duration(
                                                          seconds: 2
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: "Add a comment on this post!",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.black),
                    onPressed: () {
                      setState(() {
                        if (_commentController.text.isNotEmpty) {
                          comments.add(_commentController.text);
                          isLiked.add(false);
                          _commentController.clear();
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}