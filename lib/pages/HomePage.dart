import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Text(
                      "🇺🇸",
                      style: TextStyle(fontSize: 24),
                    ),
                    title: Text('USD'),
                    subtitle: Text('United States Dollar'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      '1.00',
                      style: TextStyle(fontSize: 36),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.0),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Text(
                      "🇮🇳",
                      style: TextStyle(fontSize: 24),
                    ),
                    title: Text('INR'),
                    subtitle: Text('Indian Rupees'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      '1.00',
                      style: TextStyle(fontSize: 36),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
