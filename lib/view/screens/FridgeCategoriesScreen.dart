import 'package:flutter/material.dart';

import '../../manager.dart';
import 'FridgeContentScreen.dart';

class FridgeCategoriesScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new FridgeCategoriesScreenState();
}

class FridgeCategoriesScreenState extends State<FridgeCategoriesScreen> {

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return _filterList();
  }

  _buildIngredientsList() {
    return new ListView.builder(
      itemCount: AppManager.instance.assets.categories.getLength(),
      itemBuilder: (context, i) => ExpansionTile(
        title: new Text(AppManager.instance.assets.categories.get(i).name),
        // Get List of possibly modified cat list
        children: AppManager.instance.fridge.getInternal()
            .where((ing) => ing.family.category.getId() == i)
            .map((val) => new ListTile(
                  leading: new Icon(
                    AppManager.instance.fridge.isBookmarked(val)
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: Colors.blue,
                  ),
                  title: new Text(val.name),
                  onTap: () {
                    setState(() {
                      if (AppManager.instance.fridge.isBookmarked(val)) {
                        AppManager.instance.fridge.setBookmark(val, false);
                      } else {
                        AppManager.instance.fridge.setBookmark(val, true);
                      }

                      FridgeContentScreenState.upateFridge();
                    });
                  },
                ))
            .toList(),
      ),
    );
  }

  Column _filterList() {
    return new Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
        ),
        new Expanded(
          child: Scaffold(
            resizeToAvoidBottomPadding: false,
            body: _buildIngredientsList(),
          ),
        ),
      ],
    );
  }
}
