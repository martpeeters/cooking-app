import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../manager.dart';
import 'dart:async';
import 'MainScreen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {

  @protected
  Future runInitTasks() async {

    AppManager.instance.onStateChanged.listen((state) {
    }, onDone: () {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
    }, onError: (error) {
      print("Error occured while loading resources!");
    });
  }
  @override
  void initState() {
    super.initState();

    // Post rendering action
    SchedulerBinding.instance.addPostFrameCallback((_) {
      runInitTasks();
    });
  }

  BoxDecoration _buildBackground() {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/front.jpg"),
        fit: BoxFit.cover,
      ),
    );
  }

  Text _buildText() {
    return Text(
      'Chef App',
      style: Theme
          .of(context)
          .textTheme
          .headline,
      textAlign: TextAlign.start,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: _buildBackground(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildText(),
                  SizedBox(height: 300.0),
                ],
              ),
            ),
          ),
          Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
              height: 50.0,
              width: 50.0,
            ),
          )
        ]
      )
    );
  }

}