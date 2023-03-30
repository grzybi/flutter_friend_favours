import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'favor.dart';
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
// TODO       Padding
        Expanded(
            child: ListView.builder(
          itemCount: favours.length,
          itemBuilder: (BuildContext context, int index) {
            final favour = favours[index];
            return Card(
              key: ValueKey(favour.uuid),
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
                  _itemHeader(favour),
                  Text(favour.description ?? ""),
                  _itemFooter(favour),
                ]),
              ),
            );
          },
        )),
      ],
    );
  }

  Widget _itemHeader(Favor favour) {
    return Row(
      children: <Widget>[
        const CircleAvatar(
          backgroundColor: Colors.green,
          // backgroundImage: NetworkImage(
          //   favour.friend.photoURL,
          // ),
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(favour.friend?.name ?? "")),
        )
      ],
    );
  }

  Widget _itemFooter(Favor favour) {
    if (favour.isRequested) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextButton(
            onPressed: () {},
            child: const Text("Refuse"),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("Do"),
          ),
        ],
      );
    }

    if (favour.isDoing) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextButton(
            onPressed: () {},
            child: const Text("Give up"),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("Complete"),
          ),
        ],
      );
    }

    if (favour.isCompleted) {
      final format = DateFormat();
      return Container(
          margin: const EdgeInsets.only(top: 8.0),
          alignment: Alignment.centerRight,
          child: Chip(
            label: Text(
                "Completed at ${format.format(favour.completed ?? DateTime.now())}"),
          ));
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Your favours"),
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
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
