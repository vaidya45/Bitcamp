import 'package:hackathon/Declarations/Global/GlobalDeclarations.dart';
import 'package:hackathon/Declarations/Images/ImageFiles.dart';
import 'package:hackathon/Declarations/GetStartedPage.dart';
import 'package:hackathon/GeneralWidgets/GWidgets.dart';
import 'package:flutter/material.dart';

Widget buildPageView(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;

  return Container(
    height: screenHeight / 1.55,
    color: Colors.grey[50], // Use dark blue as the background color
    child: Container(
      child: PageView.builder(
        controller: myPageViewController,
        itemCount: 4,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return buildTopViews(context, index, screenHeight, screenWidth);
        },
        onPageChanged: (value) {
          try {
            currentPage.value = value.toDouble();
          } catch (e) {}
        },
      ),
    ),
  );
}

Widget buildTopViews(BuildContext context, int index, double screenHeight, double screenWidth) => Padding(
  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
  child: Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildImage(context, index, screenHeight),
        heightSpacer(screenHeight * 0.05),
        buildTitle(context, index),
        heightSpacer(screenHeight * 0.02),
        buildSubTitle(context, index),
      ],
    ),
  ),
);

Widget buildImage(BuildContext context, int index, double screenHeight) => Center(
  child: Padding(
    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
    child: Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                getStartedPageImages[index],
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);

Widget buildTitle(BuildContext context, int index) => Flexible(
  child: Container(
    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
    child: Text(
      heading[index],
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.blue[600],
        fontSize: 0.05 * MediaQuery.of(context).size.width,
        fontWeight: FontWeight.w800,
        fontFamily: 'Montserrat',
        shadows: [
          Shadow(
            blurRadius: 10.0,
            color: Colors.blueGrey.shade200,
            offset: Offset(2.0, 2.0),
          ),
        ],
      ),
    ),
  ),
);

Widget buildSubTitle(BuildContext context, int index) => Flexible(
  child: Container(
    width: (MediaQuery.of(context).size.width) - (2 * MediaQuery.of(context).size.width * 0.1),
    child: Text(
      subHeading[index],
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.blueGrey.shade700,
        fontSize: 0.04 * MediaQuery.of(context).size.width,
        fontWeight: FontWeight.w600,
        fontFamily: 'sanserif',
        shadows: [
          Shadow(
            blurRadius: 5.0,
            color: Colors.blueGrey.shade200,
            offset: Offset(1.0, 1.0),
          ),
        ],
      ),
    ),
  ),
);
