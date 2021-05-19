import 'package:elaborato_delivery_app/pages/homeSignIn.dart';
import 'package:elaborato_delivery_app/pages/homeSignUpFirst.dart';
import 'package:flutter/material.dart';
import 'package:elaborato_delivery_app/services/consts.dart';

//Pagina principale login/registrazione
class HomeAuth extends StatelessWidget {
  const HomeAuth({Key key}) : super(key: key);

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
                  top: size.height * 0.2,
                  child: Image(
                    image: ResizeImage(AssetImage('images/Logo.png'),
                        width: (size.width * 0.85).toInt(),
                        height: (size.height * 0.16).toInt()),
                  )),

              //BottomContainer
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: containerGradient,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  //color: Color(0xFF4058DB),
                  width: size.width,
                  height: size.height * 0.25,
                ),
              ),

              //AccediBtn
              Positioned(
                bottom: size.height * 0.21,
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeSignIn()));
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

              //RegistratiBtn
              Visibility(
                visible: true,
                child: Positioned(
                  bottom: size.height * 0.08,
                  width: size.width * 0.75,
                  height: 60,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(colorBtn2),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: colorBtn2, width: 2),
                        ))),
                    onPressed: () {
                      print("Pressed Register");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeSignUpFirst()));
                    },
                    child: Text(
                      "REGISTRATI",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: 'Itim',
                          fontWeight: FontWeight.bold),
                    ),
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