import 'package:flutter/material.dart';
import 'package:todo/View/Done%20Screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}
bool isSelect = false;
class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  var tabIndex = 0;

  TabController ? _tabController;

  @override
  void initState() {
    _tabController =  TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green,
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
          begin: Alignment.topLeft,
          end:
          Alignment(0.8, 0.0),
          colors: <Color>[
            Color(0xffee0041),
            Color(0xffeeee00)]
        ),
        ),
        child: InkWell(

          child: Container(
            color: Colors.white,
            width:  MediaQuery.of(context).size.width/1.3 ,
            // width: isSelect ? MediaQuery.of(context).size.width/1.3 : MediaQuery.of(context).size.height/2.5,
            height: isSelect ? MediaQuery.of(context).size.height/1.3 : MediaQuery.of(context).size.height/1.7,
            child: Column(
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
                      labelColor: Colors.indigo,
                      tabs: [
                        Container(
                          // width: double.infinity,
                          height: 50,
                          // color: Colors.red,
                          child: const Text('Sign in'),
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text('Sign up'),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
