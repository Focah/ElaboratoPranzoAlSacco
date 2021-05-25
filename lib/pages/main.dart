import 'dart:async';
import 'dart:math';

import 'package:elaborato_delivery_app/pages/homeAuth.dart';
import 'package:elaborato_delivery_app/pages/homeOrdine.dart';
import 'package:elaborato_delivery_app/pages/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';
import '../services/consts.dart';
import '../services/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('it', ''), // English, no country code
        // Spanish, no country code
      ],
      theme: ThemeData(
          primaryColor: colorBtn,
          backgroundColor: colorBg,
          primarySwatch: MaterialColor(
              0xFFB32520,
            const <int, Color>{
              50: const Color(0xFFB32520),
              100: const Color(0xFFB32520),
              200: const Color(0xFFB32520),
              300: const Color(0xFFB32520),
              400: const Color(0xFFB32520),
              500: const Color(0xFFB32520),
              600: const Color(0xFFB32520),
              700: const Color(0xFFB32520),
              800: const Color(0xFFB32520),
              900: const Color(0xFFB32520),
            }
          ),
          accentColor: colorGreen),
      home: SplashScreen(
        //email: "mr.armando.sacco@gmail.com",
      ),
    );
  }
}
