import 'package:hackathon/Declarations/Global/GlobalDeclarations.dart';
import 'package:hackathon/Declarations/Images/ImageFiles.dart';
import 'package:hackathon/Declarations/GetStartedPage.dart';
import 'package:hackathon/GeneralWidgets/GWidgets.dart';
import 'package:flutter/material.dart';

Widget buildPageView(BuildContext context) => Container(
      height: MediaQuery.of(context).size.height / 1.55,
      color: Colors.grey[50], // Use dark blue as the background color
      child: Container(
        child: PageView.builder(
          controller: myPageViewController,
          itemCount: 4,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return buildTopViews(context, index);
          },
          onPageChanged: (value) {
            try {
              currentPage.value = value.toDouble();
            } catch (e) {}
          },
        ),
      ),
    );

Widget buildTopViews(BuildContext context, int index) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.00),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildImage(index),
            heightSpacer(25.00),
            buildTitle(index),
            heightSpacer(10.00),
            buildSubTitle(context, index),
          ],
        ),
      ),
    );

Widget buildImage(int index) => Center(
  child: Padding(
    padding: EdgeInsets.only(top: 60.0),
    child: Container(
      width: double.infinity,
      height: 300,
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

Widget buildTitle(int index) => Flexible(
  child: Container(
    margin: EdgeInsets.only(top: 32.0),
    child: Text(
      heading[index],
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.blue[600],
        fontSize: 28.0,
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
    width: (MediaQuery.of(context).size.width) - 100,
    child: Text(
      subHeading[index],
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.blueGrey.shade700,
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        // fontFamily: 'Roboto',
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


