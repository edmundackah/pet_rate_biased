import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_rate_biased/pages/results.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final BorderRadius _curvedRadius =  const BorderRadius.only(
  bottomRight: Radius.circular(40),
  bottomLeft: Radius.circular(40)
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.47),
        child: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.orange[200],
          shadowColor: Colors.white,
          flexibleSpace: ClipRRect(
            borderRadius: _curvedRadius,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/cattt-transparent.png"),
                    fit: BoxFit.scaleDown
                  )
                ),
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: _curvedRadius
          ),
        ),
      ),
      body: _LowerThird(),
    );
  }

}

class _LowerThird extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left:30.0, top: 25.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("🍼 r8 my cat 😂🔥",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 27.0,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: const Text("Everyone says their cat is the cutest. Thanks to the power of Deep"
                        " Learning, we can settle this once and for all!. Don't be scared, "
                        "push the button!",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),

              ],
            ),
          ),

        ),

        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: RaisedButton(
              textColor: Colors.white,
              color: Colors.black,
              elevation: 4.0,
              splashColor: Colors.grey[200],
              child: const Padding(
                padding: EdgeInsets.only(top:7.0, bottom: 7.0, right: 40.0, left: 40.0),
                child: Text("Scan",
                    style: TextStyle(fontSize: 22.0)),
              ),
              onPressed: () => getPhoto(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ),


      ],
    );
  }

  void getPhoto(BuildContext context) {
    Scaffold.of(context).showBottomSheet(
            (context) => _ImagePickerSheet());
  }

}

class _ImagePickerSheet extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8.0,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.35,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 50.0),
                  child: InkWell(
                    onTap: () async => loadPhoto(true, context),
                    child: Column(
                      children: const [
                        Icon(Icons.camera, size: 100.0),
                        Text("Take a Photo", style: TextStyle(fontSize: 20.0),)
                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: () async => loadPhoto(false, context),
                  child: Column(
                    children: const [
                      Icon(Icons.image, size: 100.0),
                      Text("Pick from gallery", style: TextStyle(fontSize: 20.0),)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loadPhoto(bool useCamera, BuildContext context) async {
    // Pick an image
    final XFile? image = await _picker.pickImage(
        source: useCamera == true ? ImageSource.camera : ImageSource.gallery);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultsPage(image: image)),
    );
  }

}