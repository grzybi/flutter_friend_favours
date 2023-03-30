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

  Widget _favoursList(String title, List<Favor> favours) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
//        Padding
        Expanded(
            child: ListView.builder(
          itemCount: favours.length,
          itemBuilder: (BuildContext context, int index) {
            final favour = favours[index];
            return Card(
              key: ValueKey(favour.uuid),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Padding(
                child: Column(children: <Widget>[
                  Text(favour.description ?? ""),
                ]),
                padding: EdgeInsets.all(8.0),
              ),
            );
          },
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Your favours"),
          bottom: TabBar(isScrollable: true, tabs: [
            _buildCategoryTab("Requests"),
            _buildCategoryTab("Doing"),
            _buildCategoryTab("Completed"),
            _buildCategoryTab("Refused"),
          ]),
        ),
        body: TabBarView(
          children: [
            _favoursList("Pending", pendingAnswerFavours),
            _favoursList("", acceptedFavours),
            _favoursList("", completedFavours),
            _favoursList("", refusedFavours),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: "Ask a favour",
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
