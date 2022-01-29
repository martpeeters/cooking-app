import 'package:flutter/material.dart';
import 'LoadingScreen.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // New private method which includes the background image:
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

    return GestureDetector(
      onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new LoadingScreen())),
      child: Container(
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
    );
  }
}
