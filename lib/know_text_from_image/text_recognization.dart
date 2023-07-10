import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class TextRecognization extends StatefulWidget {
  const TextRecognization({Key? key}) : super(key: key);

  @override
  State<TextRecognization> createState() => _TextRecognizationState();
}

class _TextRecognizationState extends State<TextRecognization> {
  File? image;

  Future pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      image = File(pickedFile!.path);
    });
  }

  String text = "";

  Future textRecognition(File image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final inputImage = InputImage.fromFilePath(image.path);
    final recognizerText = await textRecognizer.processImage(inputImage);
    setState(() {
      print(recognizerText);
      text = recognizerText.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hello world"),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 300,
                  child: Center(
                    child: image == null
                        ? const Icon(
                            Icons.add_a_photo_outlined,
                            size: 65,
                          )
                        : Image.file(image!),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.height*0.4,
                  child: MaterialButton(
                    color: Colors.blueAccent,
                    onPressed: () {
                      pickImage(ImageSource.gallery).then((value) => {
                            if (image != null)
                              {
                                textRecognition(image!),
                              }
                          });
                    },
                    child: const Text("take photo from gallary"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.height*0.4,
                  child: MaterialButton(
                    color: Colors.redAccent,
                    onPressed: () {
                      pickImage(ImageSource.camera).then((value) => {
                            if (image != null)
                              {
                                textRecognition(image!),
                              }
                          });
                    },
                    child: const Text("take photo from camera"),
                  ),
                ),
               const SizedBox(
                  height: 20,
                ),Center(
                  child: GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: text));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('تم نسخ النص')),
                      );
                    },
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ]),
        )));
  }
}
