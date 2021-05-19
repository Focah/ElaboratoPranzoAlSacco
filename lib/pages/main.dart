import 'dart:async';
import 'dart:math';

import 'package:elaborato_delivery_app/pages/homeOrdine.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';
import '../services/consts.dart';
import '../services/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: colorBtn),
      home: HomeOrdine(
        email: "mr.armando.sacco@gmail.com",
      ),
    );
  }
}