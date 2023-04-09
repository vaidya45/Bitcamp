import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetStartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        accentColor: Colors.lightGreenAccent,
      ),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  File image;
  bool isPaused = false;
  var textSpeak = "";

  final FlutterTts fluttertts = FlutterTts();

  speak() async {
    await fluttertts.setLanguage("en-US");
    await fluttertts.setPitch(1);
    await fluttertts.speak(textSpeak);
  }

  stopSpeaking() async {
    await fluttertts.stop();
  }

  pauseSpeaking() async {
    await fluttertts.pause();
  }

  resumeSpeaking() async {
    await speak();
  }

  uploadImage() async {
    final x = "10.104.40.136";
    final y = "10.0.12.35";

    final request = http.MultipartRequest(
        "GET", Uri.parse("http://10.0.12.35:9080/upload"));
    final headers = {"Content-type": "multipart/form-data"};
    request.files.add(http.MultipartFile(
        'file', image.readAsBytes().asStream(), image.lengthSync(),
        filename: image.path.split("/").last));
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();
    var parsedJson = json.decode(responseBody);
    if (response.statusCode == 200) {
      // Set it to whatever you want to "speak"
      textSpeak = parsedJson["message"];
      speak();
    } else {
      throw Exception('Failed to get text from image');
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Click, Read, and Go!"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image != null
                ? Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(
                        image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                : Container(),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 5,
                shadowColor: Colors.grey.withOpacity(0.5),
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
                // Add animation properties
                animationDuration: Duration(milliseconds: 500),
                splashFactory: InkRipple.splashFactory,
                // Set splashColor in InkRipple widget
              ),
              // Add widget to make button more interesting
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon(
                  //   Icons.photo_album,
                  //   color: Colors.white,
                  // ),
                  SizedBox(width: 10),
                  Text("Pick Image from Gallery"),
                ],
              ),
              onPressed: () async {
                await pickImage();
                uploadImage();
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // primary: Colors.blue,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                shadowColor: Colors.grey.withOpacity(0.5),
                animationDuration: Duration(milliseconds: 300),
                textStyle: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              onPressed: () async {
                await pickImageC();
                uploadImage();
              },
              child: Text(
                "Pick Image from Camera",
              ),
            ),
            // Add here
            Visibility(
              visible: image != null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Stop button
                  FloatingActionButton(
                    backgroundColor: Colors.red,
                    child: Text(
                      'X',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    onPressed: () {
                      stopSpeaking();
                    },
                  ),
                  // Pause Button
                  SizedBox(width: 16),
                  FloatingActionButton(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.pause),
                    onPressed: () {
                      // code for the second button goes here
                      pauseSpeaking();
                    },
                  ),

                  // Resume Button
                  SizedBox(width: 16),
                  FloatingActionButton(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.play_arrow),
                    onPressed: () {
                      // code for the second button goes here
                      resumeSpeaking();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Visibility(
//                 visible: image != null,
//                 child: FloatingActionButton(
//                     backgroundColor: Colors.red,
//                     child: Text(
//                       'X',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 30,
//                       ),
//                     ),
//                     onPressed: () {
//                       stopSpeaking();
//                     }))
