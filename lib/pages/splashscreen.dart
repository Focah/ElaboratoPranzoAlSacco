import 'dart:async';

import 'package:elaborato_delivery_app/pages/homeAuth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    //Dopo due secondi dall'inizializzazione della pagina,
    //passa alla schermata successiva
    Timer(Duration(seconds: 2), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeAuth()));
    });
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //Scaffold è il widget che da la struttura base di una pagina
    //a cui si puo aggiungere un appBar, un Drawer, un FloatingActionButton
    //ecc
    return Scaffold(
      body: Center(
        child: Image(
          image: ResizeImage(AssetImage('images/Logo.png'),
              width: (size.width * 0.85).toInt(),
              height: (size.height * 0.16).toInt()),
        ),
      ),
    );
  }
}
