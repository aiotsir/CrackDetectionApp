import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  late File _image;
  late List _output;
  final picker = ImagePicker(); // selects image from gallery or camera

  @override
  void initState() {
    // first function that is executed by default when this class is called
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  classifyImage(File image) async {
    // function to run the model on the image
    var output = await Tflite.runModelOnImage(
      path: image.path,
      
    );
    setState(() {
      _output = output!;
      _loading = false;
    });
  }

  loadModel() async {
    //this function loads the DL model
    await Tflite.loadModel(
        model: 'assets/converted_model.tflite', labels: 'assets/labels.txt');
  }

  pickImage() async {
    // function to capture the image from camera
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  pickGalleryImage() async {
    // function to select image from gallery
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D4B4A),
        title: const Text(
          'Detect Cracks',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 20,
              letterSpacing: 0.8),
        ),
      ),
      body: SafeArea(
        child: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              // WHOLE SCREEN BACKGROUND
              color: Color(0xFFB1DBD7), // LIGHT
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 50),
                    decoration: BoxDecoration(
                      // SPECIAL SCREEN
                      color: Color(0xFF1D4B4A),
                      borderRadius: BorderRadius.circular(30),
                    ),

                    // ignore: prefer_const_constructors
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Center(
                            child: _loading == true
                                ? null
                                : Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 250,
                                          width: 250,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Image.file(
                                              _image,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        const Divider(
                                          height: 25,
                                          thickness: 1,
                                        ),
                                        _output != null
                                            ? Text(
                                                "It's ${_output[0]['label']}!",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            : Container(),
                                        const Divider(
                                          height: 25,
                                          thickness: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: pickImage,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 200,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 17),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF54B2AF),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const Text(
                                    'Capture',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: pickGalleryImage,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 200,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 17),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF54B2AF),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const Text(
                                    'Choose ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
