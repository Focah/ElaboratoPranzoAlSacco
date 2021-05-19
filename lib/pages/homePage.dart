import 'dart:async';
import 'dart:math';

import 'package:elaborato_delivery_app/pages/homeOrdine.dart';
import 'package:elaborato_delivery_app/services/consts.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//HomePage dopo login
class HomePage extends StatefulWidget {
  final email;
  const HomePage({Key key, this.email}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final posRistorante = LatLng(45.537918, 9.423339);
  static final double raggioConsegna = 1000;
  BitmapDescriptor mapMarker;
  Timer timer;
  String testo = "";
  bool show = false;

  Set<Marker> _markers = {
    Marker(
        markerId: MarkerId('0'),
        position: posRistorante,
        //icon: mapMarker,
        infoWindow: InfoWindow(
            title: "Pranzo al Sacco", snippet: "Posizione del ristorante"))
  };

  Set<Circle> _circles = {
    Circle(
        circleId: CircleId("0"),
        center: posRistorante,
        radius: raggioConsegna,
        fillColor: colorBtn.withOpacity(.1),
        strokeColor: colorBtn.withOpacity(.8),
        strokeWidth: 2)
  };

  //Icona personalizzata per un marker
  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'images/Logo.png');
  }

  void _onMapCreated(GoogleMapController controller) {
    print("Mappa creata");
  }

  //Aggiunge un marker sulla mappa
  void _addMarker(LatLng pos, String id, String title, String snippet) {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(id),
          position: pos,
          //icon: mapMarker,
          infoWindow: InfoWindow(title: title, snippet: snippet)));
    });
  }

  //Prende la posizione del telefono
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  //Calcola la distanza tra due posizioni
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  void initState() {
    //setCustomMarker();

    timer = Timer.periodic(Duration(seconds: 3), (Timer t) {
      _markers.removeWhere((element) => element.markerId == MarkerId("user"));

      _determinePosition().then((value) {
        _addMarker(LatLng(value.latitude, value.longitude), "user",
            "Posizione utente", "Marker per la posizione dell'utente");
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
        onWillPop: () {
          return null;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          //appBar: AppBar(),
          body: Container(
            width: size.width,
            height: size.height,
            color: colorBgApp,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                //Mappa
                Positioned(
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    markers: _markers,
                    circles: _circles,
                    initialCameraPosition:
                    CameraPosition(target: posRistorante, zoom: 14),
                  ),
                ),

                //OrdinaBtn
                Positioned(
                  bottom: size.height * 0.05,
                  child: Container(
                    height: 50.0,
                    margin: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        //Al click del bottone calcola la distanza tra il ristorante e la posizione dell'utente
                        _determinePosition().then((value) {
                          var distance = (1000 *
                              calculateDistance(
                                  value.latitude,
                                  value.longitude,
                                  posRistorante.latitude,
                                  posRistorante.longitude));
                          print("Distance: $distance m");
                          setState(() {
                            if (distance <= raggioConsegna) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeOrdine(
                                        email: widget.email,
                                      )));
                            } else {
                              show = true;
                              testo =
                              "Non puoi ordinare! Sei fuori dal raggio di consegna del ristorante";
                            }
                          });
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff751815), colorBtn],
                            ),
                            borderRadius: BorderRadius.circular(30.0)),
                        constraints:
                        BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Ordina",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: 'Itim'),
                        ),
                      ),
                    ),
                  ),
                ),

                //Testo in sovraimpressione
                Visibility(
                  visible: show,
                  child: Positioned(
                    top: size.height * 0.18,
                    child: Container(
                        width: size.width * 0.75,
                        child: Text(
                          testo,
                          style: TextStyle(
                            fontFamily: 'Itim',
                            fontSize: 30,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}