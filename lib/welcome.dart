import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body:Stack(
          children: [
            Image.asset('assets/images/bg3.png', fit:BoxFit.cover,width: double.infinity,height: double.infinity,),
            Column(
              children: [
                Flexible(child: Container(child: Center(child: Text("Weome"))))

              ],
            )


          ],
        )
    );
  }
}