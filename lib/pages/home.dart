import 'package:flutter/material.dart';

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
          shadowColor: Colors.white,
          flexibleSpace: ClipRRect(
            borderRadius: _curvedRadius,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/cute_pets_cropped.jpeg"),
                  fit: BoxFit.fill
                )
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Rate Us!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 45.0,
                ),
              ),
              const Text("Try it, let's see",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: const Text("Everyone says their pet is the cutest. Thanks to the power of Deep"
                      " Learning, we can settle this once and for all!. Don't be scared, "
                      "push the button!",
                  ),
                ),
              )

            ],
          ),

        ),


      ],
    );
  }

}