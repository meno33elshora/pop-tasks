import 'package:flutter/material.dart';
import 'package:todo/View/Done%20Screen.dart';
import 'package:todo/View/Task%20Screen.dart';

class Testing extends StatefulWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> with SingleTickerProviderStateMixin{
  TabController ? _tabController;

  @override
  void initState() {
    _tabController =  TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var tabIndex = 0;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DefaultTabController(
              length: 2,
              initialIndex: tabIndex,
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                // indicatorPadding: const EdgeInsets.only(top: 10),
                labelPadding: const EdgeInsets.only(bottom: 5),
                controller: _tabController,
                  unselectedLabelColor: Colors.black87,
                  labelColor: Colors.amber,
                  tabs: [
                    Container(
                      width: double.infinity,
                      height: 50,
                      color: Colors.red,
                      child: Text('test1'),
                      alignment: Alignment.center,
                    ),
                    Container(
                      child: Text('test1'),
                    ),
                  ]),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                  children: [
                    Text('one '),
                    Text('two '),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
