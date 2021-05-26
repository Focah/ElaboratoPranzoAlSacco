import 'package:elaborato_delivery_app/services/consts.dart';
import 'package:flutter/material.dart';

class HomeOrdineAttendere extends StatefulWidget {
  final email;
  const HomeOrdineAttendere({Key key, this.email}) : super(key: key);

  @override
  _HomeOrdineAttendereState createState() => _HomeOrdineAttendereState();
}

class _HomeOrdineAttendereState extends State<HomeOrdineAttendere> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        return null;
      },
      child: Scaffold(
        body: Container(
          height: size.height,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Grazie per aver ordinato!",
                  style: TextStyle(
                    fontFamily: 'Itim',
                    fontSize: 26,
                    color: colorBtnDark,
                  ),
                ),
                Text(
                  "Attendi un attimo.",
                  style: TextStyle(
                    fontFamily: 'Itim',
                    fontSize: 26,
                    color: colorBtnDark,
                  ),
                ),
                Icon(
                  Icons.done_outline_sharp,
                  color: colorGreen,
                  size: 80,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
