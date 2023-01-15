import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo/View/Home%20Layout%20Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds: 5), (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeLayoutScreen()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width/1,
        color: Colors.blue,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  const [
            // Icon(Icons.theater_comedy , color: Colors.white,size: 80,),
            Image(image: AssetImage('images/verifay.png'),width: 200,height: 200,fit: BoxFit.cover,),
            SizedBox(height: 10,),
            Text('Pop Task' , style: TextStyle(color: Colors.white , fontSize: 30,fontWeight: FontWeight.w600),)
          ],
        ),
      ),
    );
  }
}
