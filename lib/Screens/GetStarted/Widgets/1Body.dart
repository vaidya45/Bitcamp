import 'package:hackathon/Declarations/GetStartedPage.dart';
import 'package:hackathon/GeneralWidgets/GWidgets.dart';
import 'package:flutter/material.dart';
import '5GetStartedBtn.dart';
import '3DotIndicator.dart';
import '2PageView.dart';

Widget buildBody(BuildContext context) => Container(
      color: Colors.grey[50],
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: (MediaQuery.of(context).size.height)),
          child: ValueListenableBuilder<double>(
            valueListenable: currentPage,
            builder: (context, value, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildPageView(context),
                  heightSpacer(40.00),
                  buildDotIndicator(),
                  heightSpacer(100.00),
                  buildGetStartedButton(context),
                ],
              );
            },
          ),
        ),
      ),
    );
