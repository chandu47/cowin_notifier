import 'dart:developer';

import 'package:cowin_notifier/ui/noitify_me_card.dart';
import 'package:cowin_notifier/ui/search_box.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return Container(
      margin: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          NotifyMeCard(),
          SizedBox(height: 10,),
          SearchBox(),
          SizedBox(height: 10,),
          Expanded(child: Container(color: Colors.amber,))
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
