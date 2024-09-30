import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 0,
        itemCount: 40,
        itemBuilder: (context, i){
          return _Tile(i);
        },
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final int i;
  const _Tile(this.i);

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
              onTap:() {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => Detail("assets/image$i.jpg"),
                  ),
                );
              },
              child: Hero(
                tag: "assets/image$i.jpg",
                child: Image.asset("assets/image$i.jpg"),
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

  void _showBottomSheet(BuildContext context){
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
                  'Bagikan Pin Ini',
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
                  ]
                ) 
              )
            ]
          ),
        );
      },
    );
  }

  Widget _shareOption(BuildContext context, String asset, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        _showSnackBar(context, 'berhasil dikirim!');
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
      duration: const Duration(seconds:2),
      backgroundColor: Colors.grey[850],
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}