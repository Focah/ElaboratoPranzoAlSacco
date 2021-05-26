import 'dart:ui';

import 'package:flutter/material.dart';

const colorBtnDark = Color(0xFF9A031E);
const colorBtn = Color(0xFFB32520);

const colorBtn2 = Color(0xFFCE5A12);

const colorBgDark = Color(0xFFE96E18);
const colorBg = Color(0xFFFB8B24);

const colorGreen = Color(0xFFC0CE64);

const colorBgApp = Color(0xFFF3F4F6);

const LinearGradient containerGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [colorBg, Color(0xfffb5d24)]);

class BlurryDialog extends StatelessWidget {
  String title;
  String content;
  VoidCallback continueCallBack;
  int tipo;

  BlurryDialog(this.title, this.content, this.continueCallBack, this.tipo);
  TextStyle textStyle = TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: new Text(
            title,
            style: textStyle,
          ),
          content: new Text(
            content,
            style: textStyle,
          ),
          actions: <Widget>[
            new TextButton(
              child: new Text("Conferma"),
              onPressed: () {
                continueCallBack();
              },
            ),
            tipo == 0
                ? new TextButton(
                    child: Text("Cancella"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                : Container(),
          ],
        ));
  }
}
