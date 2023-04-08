import 'package:hackathon/Declarations/Global/GlobalDeclarations.dart';
import 'package:hackathon/Declarations/GetStartedPage.dart';
import 'package:flutter/material.dart';
import '4NxtBackBtn.dart';
import 'pages/get_started.dart';

Widget buildGetStartedButton(BuildContext context) => currentPage.value == 3
    ? Container(
        width: (MediaQuery.of(context).size.width) - 25,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.00),
            ),
          ),
          child: Text(
            "Get Started",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.00,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GetStartedPage()),
            );
          },
        ),
      )
    : buildNextbackBtn(currentPage.value.toDouble());

