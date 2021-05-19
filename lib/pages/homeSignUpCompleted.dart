import 'package:elaborato_delivery_app/pages/homeSignIn.dart';
import 'package:elaborato_delivery_app/services/consts.dart';
import 'package:flutter/material.dart';

//Pagina Registrazione completa
class HomeSignUpCompleted extends StatelessWidget {
  final email;
  const HomeSignUpCompleted({Key key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        return null;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: size.width,
          height: size.height,
          color: colorBgApp,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              //LogoImg
              Positioned(
                  top: size.height * 0.15,
                  child: Image(
                    image: ResizeImage(AssetImage('images/Logo.png'),
                        width: (size.width * 0.85).toInt(),
                        height: (size.height * 0.16).toInt()),
                  )),

              //CenterTxt
              Positioned(
                top: size.height * 0.50,
                child: Text(
                  "Grazie per esserti registrato!",
                  style: TextStyle(
                    fontFamily: 'Itim',
                    fontSize: 26,
                    color: colorBtnDark,
                  ),
                ),
              ),

              //CenterTxt2
              Positioned(
                top: size.height * 0.60,
                child: Container(
                  width: size.width * 0.75,
                  child: Text(
                    "Controlla la casella di posta elettronica per completare la registrazione.",
                    style: TextStyle(
                      fontFamily: 'Itim',
                      fontSize: 24,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

              //GreenIcon
              Positioned(
                top: size.height * 0.35,
                child: Icon(
                  Icons.done_outline_sharp,
                  color: colorGreen,
                  size: 80,
                ),
              ),

              //BtnToLogin
              //AccediBtn
              Positioned(
                bottom: size.height * 0.16,
                width: size.width * 0.75,
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(colorBtn),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: colorBtnDark),
                      ))),
                  onPressed: () {
                    print("Pressed Sign In");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeSignIn(
                              email: email,
                            )));
                  },
                  child: Text(
                    "ACCEDI",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'Itim',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}