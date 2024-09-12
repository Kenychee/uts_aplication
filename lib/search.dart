import 'package:flutter/material.dart';

void search() {
  runApp(SearchTabsApp());
}

class SearchTabsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchTabsScreen(),
    );
  }
}

class SearchTabsScreen extends StatefulWidget {
  @override
  _SearchTabsScreenState createState() => _SearchTabsScreenState();
}

class _SearchTabsScreenState extends State<SearchTabsScreen> {
  int _currentSlideIndex = 0;
  List<String> _slideImages = ['assets/1.png', 'assets/2.png', 'assets/3.png'];
  List<String> _slideCaptions = ['Caption One', 'Caption Two', 'Caption Three'];
  String _activeTab = 'All';

  void _changeTab(String tabName) {
    setState(() {
      _activeTab = tabName;
    });
  }

  void _nextSlide() {
    setState(() {
      _currentSlideIndex = (_currentSlideIndex + 1) % _slideImages.length;
    });
  }

  void _previousSlide() {
    setState(() {
      _currentSlideIndex =
          (_currentSlideIndex - 1 + _slideImages.length) % _slideImages.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            _buildSearchBar(),
            SizedBox(height: 10),
            _buildTabs(),
            SizedBox(height: 20),
            _buildSlideshow(),
            _buildDots(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 2,
          )
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.camera_alt, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTabButton('All'),
        _buildTabButton('Images'),
        _buildTabButton('Videos'),
        _buildTabButton('Pins'),
      ],
    );
  }

  Widget _buildTabButton(String tabName) {
    bool isActive = _activeTab == tabName;
    return GestureDetector(
      onTap: () => _changeTab(tabName),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? Colors.grey[400] : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          tabName,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildSlideshow() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          _slideImages[_currentSlideIndex],
          width: 300,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 10,
          child: Text(
            _slideCaptions[_currentSlideIndex],
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Positioned(
          left: 10,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: _previousSlide,
          ),
        ),
        Positioned(
          right: 10,
          child: IconButton(
            icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
            onPressed: _nextSlide,
          ),
        ),
      ],
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _slideImages.length,
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              _currentSlideIndex = index;
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentSlideIndex == index ? Colors.grey[600] : Colors.grey[400],
            ),
          ),
        ),
      ),
    );
  }
}
