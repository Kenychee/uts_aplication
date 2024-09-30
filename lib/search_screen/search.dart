import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'search_detail.dart';
import 'sample_data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> _searchResults = [];

  // Retaining the original search function
  void _search(String query) {
    setState(() {
      // Filter results by ID
      _searchResults = sampleData
          .where((item) => item['id'] == query)
          .map((item) => item['image']!)
          .toList();
    });
  }

  // Function to display the detailed image page
  void _showSearchDetail(String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchDetail(imageUrl: imageUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Search Results',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(width: 40),
          ],
        ),
        elevation: 1,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              onSubmitted: _search,
              decoration: InputDecoration(
                hintText: 'Search by ID...',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: _searchResults.isEmpty
          ? _buildMasonryGridView(sampleData)  // Staggered grid view with all data
          : _buildMasonryGridView(_searchResults), // Staggered grid view with filtered results
    );
  }

  Widget _buildMasonryGridView(List data) {
    return MasonryGridView.count(
      padding: const EdgeInsets.all(8),
      crossAxisCount: 2,  // Using 2 columns
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      itemCount: data.length,
      itemBuilder: (context, index) {
        final image = data[index] is String ? data[index] : data[index]['image']!;
        return _Tile(image, () => _showSearchDetail(image));
      },
    );
  }
}

class _Tile extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;

  const _Tile(this.imageUrl, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            child: InkWell(
              onTap: onTap,
              child: Hero(
                tag: imageUrl,
                // Use Image.asset for images from assets
                child: imageUrl.contains('assets/')
                    ? Image.asset(imageUrl, fit: BoxFit.cover)
                    : Image.network(imageUrl, fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -10,
          right: 8,
          child: GestureDetector(
            onTap: () {
              _showBottomSheet(context);
            },
            child: const Icon(Icons.more_horiz, color: Colors.black),
          ),
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Share This Pin',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _shareOption(context, 'assets/whatsapp.png', 'WhatsApp'),
                    _shareOption(context, 'assets/instagram.png', 'Instagram'),
                    _shareOption(context, 'assets/gmail.png', 'Gmail'),
                    _shareOption(context, 'assets/line.png', 'LINE'),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _shareOption(BuildContext context, String asset, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        _showSnackBar(context, 'Successfully sent!');
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(asset, width: 40),
          const SizedBox(height: 8),
          Text(title),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.grey[850],
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
