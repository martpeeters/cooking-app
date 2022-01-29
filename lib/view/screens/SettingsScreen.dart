import 'package:flutter/material.dart';
import '../../manager.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Your Profile"),
          backgroundColor: Colors.green,
        ),
        body: Container(
          child: _buildBody(),
        )
    );
  }


  _buildBody() {
    return new ListView(
      children: <Widget>[
        ExpansionTile(
          title: Text('Permanent Filters', style: new TextStyle(fontWeight: FontWeight.bold)),
          children: null,
        ),
        new SwitchListTile(
          value: AppManager.instance.settings.isOffline(),
          onChanged: (bool value){ setState(() {
            AppManager.instance.settings.setOffline(value);
          });},
          title: new Text('Offline Mode', style: new TextStyle(fontWeight: FontWeight.bold)),
        ),
        new OutlineButton(
          onPressed: () => AppManager.instance.database.reset(),
          child: new Text('Reset Application', style: new TextStyle(fontWeight: FontWeight.bold)),
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        )
      ]
    );
  }
}