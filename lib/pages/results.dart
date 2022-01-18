import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ResultsPage extends StatefulWidget {
  ResultsPage({Key? key, this.image}) : super(key: key);

  XFile? image;

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  String result = "";

  loadModel() async {
    String? output = await Tflite.loadModel(
        model: "assets/model/model.tflite",
        labels: "assets/model/labels.txt",
        isAsset: true,
        useGpuDelegate: false,
        numThreads: 1
    );
    print(output);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel();
  }

  Future<Map> runInference() async {
    var recognitions = await Tflite.runModelOnImage(
        path: widget.image!.path,
      imageMean: 0.0,
      imageStd: 255
    );

    print(recognitions![0]["label"]);
    return recognitions[0];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1.0,
        leading: InkWell(
            child: const Icon(Icons.arrow_back, color: Colors.black),
          onTap: () {
              Navigator.pop(context);
              },
        ),
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        title: const Text("Result", style: TextStyle(color: Colors.black)),
      ),
      body: FutureBuilder<Map>(
        future: runInference(), // async work
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator(color: Colors.black));
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right:20.0, left: 20.0),
                        child: Image.file(
                          File(widget.image!.path),
                          height: MediaQuery.of(context).size.height * 0.43,
                          //width: MediaQuery.of(context).size.width * 0.65,
                        ),
                      ),

                      snapshot.data!["label"] == "cat" ? Image.asset(
                        "assets/images/certified.png",
                        fit: BoxFit.cover,
                        height: 150,
                      ) : Container(),

                      Center(
                        child: Column(
                          children: [
                            Text(snapshot.data!["label"] == "cat" ? "10/10" : "7/10",
                                style: const TextStyle(
                                    fontSize: 50.0,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(snapshot.data!["label"] == "cat" ? "Solid Cat" : "Cat?",
                                  style: const TextStyle(
                                      fontSize: 50.0,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
          }
        },
      )
    );
  }

}