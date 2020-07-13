import 'package:despicable_me/models/character.dart';
import 'package:despicable_me/styleguide.dart';
import 'package:despicable_me/widgets/characters_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;
  int currentPage=0;
  @override
  void initState() {
    super.initState();
    _pageController=PageController(
      viewportFraction: 1.0,
      initialPage: currentPage,
      keepPage: false
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom:16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 32),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(text: "Despicable Me", style: AppTheme.display1),
                    TextSpan(text: "\n"),
                    TextSpan(text: "Character", style: AppTheme.display2)
                  ]),
                ),
              ),
              Expanded(
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  children: <Widget>[
                    for(int i=0; i<characters.length; i++)
                    CharactersWidgets(character: characters[i], pageController: _pageController, currentPage: i,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
