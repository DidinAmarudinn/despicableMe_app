import 'package:after_layout/after_layout.dart';
import 'package:despicable_me/models/character.dart';
import 'package:despicable_me/styleguide.dart';
import 'package:flutter/material.dart';

class CharcterDetailScreen extends StatefulWidget {
  final double _expandedBottomSheet = 0.0;
  final double _collapseBottomSheet = -250.0;
  final double _comppleteCollapse = -330;
  final Character character;
  CharcterDetailScreen({this.character});
  @override
  _CharcterDetailScreenState createState() => _CharcterDetailScreenState();
}

class _CharcterDetailScreenState extends State<CharcterDetailScreen>
    with AfterLayoutMixin<CharcterDetailScreen> {
  double _bottomSheetPostion=-330.0;
  bool isCollapse = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Hero(
            tag: "background-${widget.character.name}",
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: widget.character.colors,
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _bottomSheetPostion = widget._comppleteCollapse;
                      });
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      size: 35,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Hero(
                    tag: "image-${widget.character.imagePath}",
                    child: Image.asset(
                      widget.character.imagePath,
                      height: screenHeight * 0.45,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
                  child: Text(
                    widget.character.name,
                    style: AppTheme.heading,
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.fromLTRB(32, 0, 8, 90),
                  child: Text(
                    widget.character.description,
                    style: AppTheme.subHeading,
                  ),
                )
              ],
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.decelerate,
            bottom: _bottomSheetPostion,
            right: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        print("a");
                      _bottomSheetPostion=isCollapse ? widget._expandedBottomSheet : widget._collapseBottomSheet;
                      print(_bottomSheetPostion);
                      isCollapse = !isCollapse;
                      });
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      height: 80,
                      child: Text(
                        "Clips",
                        style:
                            AppTheme.subHeading.copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _clipWidget(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _clipWidget() {
    return Container(
      height: 250,
      margin: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              roundedContainer(Colors.red),
              SizedBox(
                height: 10,
              ),
              roundedContainer(Colors.red),
            ],
          ),
          SizedBox(
            width: 16,
          ),
          Column(
            children: <Widget>[
              roundedContainer(Colors.blue),
              SizedBox(
                height: 10,
              ),
              roundedContainer(Colors.blue),
            ],
          ),
          SizedBox(
            width: 16,
          ),
          Column(
            children: <Widget>[
              roundedContainer(Colors.purple),
              SizedBox(
                height: 10,
              ),
              roundedContainer(Colors.purple),
            ],
          ),
          SizedBox(
            width: 16,
          ),
          Column(
            children: <Widget>[
              roundedContainer(Colors.green),
              SizedBox(
                height: 10,
              ),
              roundedContainer(Colors.green),
            ],
          ),
          SizedBox(
            width: 16,
          ),
          Column(
            children: <Widget>[
              roundedContainer(Colors.orange),
              SizedBox(
                height: 10,
              ),
              roundedContainer(Colors.orange),
            ],
          )
        ],
      ),
    );
  }

  Widget roundedContainer(Color color) {
    return Container(
      width: 100,
      height: 100,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
    );
  }


  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isCollapse = true;
        _bottomSheetPostion = widget._collapseBottomSheet;
      });
    });
  }
}
