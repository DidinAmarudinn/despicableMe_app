import 'package:despicable_me/models/character.dart';
import 'package:despicable_me/screens/character_detail.dart';
import 'package:despicable_me/styleguide.dart';
import 'package:flutter/material.dart';

class CharactersWidgets extends StatefulWidget {
  final Character character;
  final PageController pageController;
  final int currentPage;
  CharactersWidgets({this.character, this.pageController, this.currentPage});
  @override
  _CharactersWidgetsState createState() => _CharactersWidgetsState();
}

class _CharactersWidgetsState extends State<CharactersWidgets> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 350),
                pageBuilder: (context, _, __) => CharcterDetailScreen(
                      character: widget.character, 
                    )));
      },
      child: AnimatedBuilder(
        animation: widget.pageController,
        builder: (context, child){
          double value=1;
          if(widget.pageController.position.haveDimensions){
            value=widget.pageController.page-widget.currentPage;
            value=(1-(value.abs()*0.6)).clamp(0.0, 1.0);
          }
          return Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Hero(
                tag: "background-${widget.character.name}",
                child: ClipPath(
                  clipper: CharacterCardBackgroundClipper(),
                  child: Container(
                    height: 0.60 * screenHeight,
                    width: 0.9 * screenWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors:widget.character.colors,
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, -0.6),
              child: Hero(
                tag: "image-${widget.character.imagePath}",
                child: Image.asset(widget.character.imagePath,
                    height: screenHeight * 0.55*value),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 48,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    widget.character.name,
                    style: AppTheme.heading,
                  ),
                  Text(
                    "Tap to read more",
                    style: AppTheme.subHeading,
                  )
                ],
              ),
            )
          ],
        );
        },
      ),
    );
  }
}

class CharacterCardBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path clippedPath = Path();
    double curveDistance = 40;

    clippedPath.moveTo(0, size.height * 0.4);
    clippedPath.lineTo(0, size.height - curveDistance);
    clippedPath.quadraticBezierTo(
        1, size.height - 1, 0 + curveDistance, size.height);
    clippedPath.lineTo(size.width - curveDistance, size.height);
    clippedPath.quadraticBezierTo(size.width + 1, size.height - 1, size.width,
        size.height - curveDistance);
    clippedPath.lineTo(size.width, 0 + curveDistance);
    clippedPath.quadraticBezierTo(size.width - 1, 0,
        size.width - curveDistance - 5, 0 + curveDistance / 3);
    clippedPath.lineTo(curveDistance, size.height * 0.29);
    clippedPath.quadraticBezierTo(
        1, (size.height * 0.30) + 10, 0, size.height * 0.4);
    return clippedPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
