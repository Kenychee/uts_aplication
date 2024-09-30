import 'package:flutter/material.dart';

class SearchDetail extends StatefulWidget {
  final String imageUrl;

  const SearchDetail({required this.imageUrl, super.key});

  @override
  _SearchDetailState createState() => _SearchDetailState();
}

class _SearchDetailState extends State<SearchDetail> {
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
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Image section
            Hero(
              tag: widget.imageUrl,
              child: widget.imageUrl.contains('assets/')
                  ? Image.asset(widget.imageUrl)
                  : Image.network(widget.imageUrl),
            ),
            const SizedBox(height: 10),

            // Post interaction section (like, bookmark)
            _buildPostInteraction(),

            const SizedBox(height: 20),

            // Comments section
            _buildCommentsSection(),

            // Comment input section
            _buildCommentInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildPostInteraction() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            isPostLiked ? Icons.favorite : Icons.favorite_border,
            color: isPostLiked ? Colors.red : Colors.black,
          ),
          onPressed: () {
            setState(() {
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
            style: TextStyle(
              color: isBookmarked ? Colors.black : Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCommentsSection() {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 300,
      color: Colors.grey[200],
      child: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar icon for user
                CircleAvatar(
                  backgroundImage: const AssetImage('assets/user.png'),
                  radius: 20,
                  backgroundColor: Colors.grey[600],
                ),
                const SizedBox(width: 10),

                // Comment text
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
                            // Like button for comment
                            IconButton(
                              icon: Icon(
                                isLiked[index]
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isLiked[index] ? Colors.red : Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  isLiked[index] = !isLiked[index];
                                });
                              },
                              padding: const EdgeInsets.only(right: 30),
                            ),
                            // More button to report comment
                            IconButton(
                              icon: const Icon(Icons.more_horiz, color: Colors.black),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                _showReportDialog(index);
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
    );
  }

  Widget _buildCommentInput() {
    return Padding(
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
    );
  }

  // Function to display the report dialog
  void _showReportDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Report"),
          content: const Text("Do you want to report this comment?"),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Comment reported successfully'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
