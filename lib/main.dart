import 'package:flutter/material.dart';
import 'favor.dart';
import 'friend.dart';
import 'mock_values.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: FavoursPage(
        pendingAnswerFavours: mockPendingFavors,
        completedFavours: mockCompletedFavors,
        refusedFavours: mockRefusedFavors,
        acceptedFavours: mockDoingFavors,
      ),
    );
  }
}

class FavoursPage extends StatelessWidget {
  final List<Favor> pendingAnswerFavours;
  final List<Favor> completedFavours;
  final List<Favor> refusedFavours;
  final List<Favor> acceptedFavours;

  FavoursPage({
    Key? key,
    required this.pendingAnswerFavours,
    required this.completedFavours,
    required this.refusedFavours,
    required this.acceptedFavours,
  }) : super(key: key);
  
  Widget _buildCategoryTab(String title) {
    return Tab(
      child: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Your favours"),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              _buildCategoryTab("Requests"),
              _buildCategoryTab("Doing"),
              _buildCategoryTab("Completed"),
              _buildCategoryTab("Refused"),
            ]),
        ),
      ),
      );
  }



}
