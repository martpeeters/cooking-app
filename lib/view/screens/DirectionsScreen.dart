import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../model/assets/recipe/Recipe.dart';

class DirectionsScreen extends StatefulWidget {
  final Recipe recipe;

  DirectionsScreen({Key key, @required this.recipe}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new DirectionsScreenState();
}

class DirectionsScreenState extends State<DirectionsScreen> {
  int _index = 0;

  List<Step> _getSteps() {
    return widget.recipe.steps.map((s) => Step(
        title: AutoSizeText(
          'Step ${s.index}',
          style: TextStyle(
              color: Colors.black45, fontFamily: 'Open Sans', fontSize: 20.0),
        ),
        content: AutoSizeText(
          s.instructions,
          style: TextStyle(
              color: Colors.black45, fontFamily: 'Open Sans', fontSize: 20.0),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Center(
              child: new Stepper(
                /*controlsBuilder: (BuildContext context,
                        {VoidCallback onStepContinue,
                        VoidCallback onStepCancel}) =>
                    Container(),*/
                currentStep: _index,
                onStepTapped: (index) {
                  setState(() {
                    _index = index;
                  });
                },
                steps: _getSteps(),
              ),
            ),
            Positioned(
              child: IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.black45),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
