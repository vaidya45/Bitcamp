import 'package:flutter/material.dart';

PageController myPageViewController = new PageController(viewportFraction: 0.8);
final ValueNotifier<double> currentPage = ValueNotifier<double>(0.0);

List heading = <String>[
  "Snap and read on the go!",
  "Dyslexic? No problem.",
  "Can't Read? We got you.",
  "Struggling with Prescriptions?",
];

List subHeading = <String>[
  "No More Struggling with Menus",
  "Get the most out of your reading with powerful tools and features.",
  "Enjoy your favorite books wherever life takes you!",
  "Never miss a medication or dosage with text-to-speech reminders.",
];
