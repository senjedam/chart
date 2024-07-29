import 'package:flutter/material.dart';

class FadeChartItem extends StatefulWidget {
  @override
  _FadeChartItemState createState() => _FadeChartItemState();
}

class _FadeChartItemState extends State<FadeChartItem> {
  bool _isVisible = true;

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggleVisibility,
          child: Container(
            color: Colors.blue,
            padding: EdgeInsets.all(16),
            child: Text(
              'Tap to ${_isVisible ? 'Hide' : 'Show'} Content',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: _isVisible ? 1.0 : 0.0,
          child: Container(
            height: 150,
            color: Colors.blueAccent,
            child: Center(child: Text('Additional Content', style: TextStyle(color: Colors.white))),
          ),
        ),
      ],
    );
  }
}

void main() => runApp(MaterialApp(home: Scaffold(body: FadeChartItem())));