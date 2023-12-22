import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<File> imageFile;
  File? _image;
  //String result = 'Persian';
  String result = '';
  ImagePicker? imagePicker;

  loadDataModelFiles() async {
    String? output = await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
      isAsset: true,
      useGpuDelegate: false,
    );
    print("The output : $output");
  }

  doImageClassification() async {
    var recognition = await Tflite.runModelOnImage(
      path: _image!.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 2,
      threshold: 0.1,
      asynch: true,
    );
    print('Recognition Length : $recognition.length.toString()');
    setState(() {
      result = " ";
    });
    recognition!.forEach((element) {
      setState(() {
        print(element.toString);
        result += element["label"];
      });
    });
  }

  selectPhotoFromGallery() async {
    XFile? pickedFile =
        await imagePicker!.pickImage(source: ImageSource.gallery);
    _image = File(pickedFile!.path);
    setState(() {
      _image;
      doImageClassification();
    });
  }

  capturePhotoFromCamera() async {
    XFile? pickedFile =
        await imagePicker!.pickImage(source: ImageSource.camera);
    _image = File(pickedFile!.path);
    setState(() {
      _image;
      doImageClassification();
    });
  }

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    loadDataModelFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Stack(
              children: [
                Center(
                  child: TextButton(
                    onPressed: selectPhotoFromGallery,
                    onLongPress: capturePhotoFromCamera,
                    child: Container(
                        margin: EdgeInsets.only(top: 30, right: 35, left: 18),
                        child: _image != null
                            ? Image.file(
                                _image!,
                                height: 160,
                                width: 400,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 140,
                                height: 190,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                ),
                              )),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 160),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              '$result',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.blueAccent,
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
