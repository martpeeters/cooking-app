import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../model/assets/dictionary/Ingredient.dart';

import '../../manager.dart';

class FridgeContentScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new FridgeContentScreenState();
}

class FridgeContentScreenState extends State<FridgeContentScreen> {

  static List<Ingredient> _fridge;

  static upateFridge() {
    _fridge = AppManager.instance.fridge.filter();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: AppManager.instance.assets.categories.getLength(),
      itemBuilder: (context, i) => ExpansionTile(
        title: new Text(AppManager.instance.assets.categories.get(i).name),
        leading: new CircleAvatar(
          child: CachedNetworkImage(
            placeholder: (context, url) => Center(
                child: SizedBox(
              child: CircularProgressIndicator(),
              height: 50.0,
              width: 50.0,
            )),
            imageUrl: AppManager.instance.assets.categories.get(i).imageLink,
            fit: BoxFit.cover,
          ),
        ),
        children: _fridge
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

                      upateFridge();
                    });
                  },
                ))
            .toList(),
      ),
    );
  }
}
