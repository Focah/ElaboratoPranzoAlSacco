import 'package:elaborato_delivery_app/services/consts.dart';
import 'package:elaborato_delivery_app/services/services.dart';
import 'package:flutter/material.dart';

//Pagina per creare il proprio ordine
class HomeOrdine extends StatefulWidget {
  final email;
  const HomeOrdine({Key key, this.email}) : super(key: key);

  @override
  _HomeOrdineState createState() => _HomeOrdineState();
}

class _HomeOrdineState extends State<HomeOrdine> {

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
              alignment: Alignment.center,
              children: [
                //TopLeft icon
                Positioned(
                  top: size.height * 0.060,
                  left: size.width * 0.05,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.home),
                    color: colorBtn,
                    iconSize: 40,
                  ),
                ),

                //TopRight icon
                Positioned(
                  top: size.height * 0.060,
                  right: size.width * 0.05,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.account_circle,
                      color: colorBtn,
                    ),
                    iconSize: 40,
                  ),
                ),

                //TopText
                Positioned(
                  top: size.height * 0.06,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Pranzo al Sacco",
                        style: TextStyle(
                            color: colorBtn, fontSize: 25, fontFamily: 'Itim'),
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            color: Colors.grey,
                          ),
                          Text(
                            " 13:00 - 13:30",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontFamily: 'Itim'),
                          )
                        ],
                      )
                    ],
                  ),
                ),

                //MainContainer
                Positioned(
                  bottom: size.height * 0.1,
                  child: Container(
                    height: size.height * 0.75,
                    width: size.width * 0.95,
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overscroll) {
                        overscroll.disallowGlow();
                        return null;
                      },
                      child: ListView(
                        children: [
                          //Pizze
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 18),
                                child: Text(
                                  "Pizze",
                                  style: TextStyle(
                                      color: colorBtn,
                                      fontSize: 25,
                                      fontFamily: 'Itim'),
                                ),
                              )),
                          CatListView(
                            cat: 0,
                          ),

                          //Contorni
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 18, top: 5),
                                child: Text(
                                  "Contorni",
                                  style: TextStyle(
                                      color: colorBtn,
                                      fontSize: 25,
                                      fontFamily: 'Itim'),
                                ),
                              )),
                          CatListView(
                            cat: 1,
                          ),

                          //Secondi
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 18, top: 5),
                                child: Text(
                                  "Secondi",
                                  style: TextStyle(
                                      color: colorBtn,
                                      fontSize: 25,
                                      fontFamily: 'Itim'),
                                ),
                              )),
                          CatListView(
                            cat: 2,
                          ),

                          //Bibite
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 18, top: 5),
                                child: Text(
                                  "Bibite",
                                  style: TextStyle(
                                      color: colorBtn,
                                      fontSize: 25,
                                      fontFamily: 'Itim'),
                                ),
                              )),
                          CatListView(
                            cat: 3,
                          ),

                          //Dolci
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 18, top: 5),
                                child: Text(
                                  "Dolci",
                                  style: TextStyle(
                                      color: colorBtn,
                                      fontSize: 25,
                                      fontFamily: 'Itim'),
                                ),
                              )),
                          CatListView(
                            cat: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //Bottom draggableScrollableSheet
                DraggableScrollableSheet(
                  initialChildSize: 0.1,
                  minChildSize: 0.1,
                  maxChildSize: 0.5,
                  builder: (context, scrollController) {
                    return NotificationListener<
                        OverscrollIndicatorNotification>(
                      onNotification: (overscroll) {
                        overscroll.disallowGlow();
                        return null;
                      },
                      child: SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        controller: scrollController,
                        child: Container(
                          width: size.width,
                          height: size.height * 0.49,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [colorBgApp, Colors.white]),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              //Top rectangle drawing
                              Positioned(
                                top: size.height * 0.015,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  width: size.width * 0.15,
                                  height: 5,
                                ),
                              ),

                              //TopLeftText
                              Positioned(
                                top: size.height * 0.04,
                                left: size.width * 0.05,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.shopping_bag,
                                      color: colorBtn,
                                    ),
                                    Text(
                                      " Il tuo ordine",
                                      style: TextStyle(
                                          fontFamily: 'Itim', fontSize: 25),
                                    )
                                  ],
                                ),
                              ),

                              //TopRightBtn
                              Positioned(
                                top: size.height * 0.03,
                                right: size.width * 0.05,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              colorBtn),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        side: BorderSide(color: colorBtnDark),
                                      ))),
                                  child: Text(
                                    "Svuota",
                                    style: TextStyle(
                                        fontFamily: 'Itim', fontSize: 18),
                                  ),
                                ),
                              ),

                              //TopRow drawed
                              Positioned(
                                top: size.height * 0.115,
                                child: Container(
                                  width: size.width,
                                  height: 1,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),

                              //Conferma ordine
                              Positioned(
                                bottom: size.height * 0.01,
                                child: Container(
                                  width: size.width * 0.9,
                                  height: size.height * 0.07,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                colorBtn),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          side: BorderSide(color: colorBtnDark),
                                        ))),
                                    child: Text(
                                      "Conferma ordine",
                                      style: TextStyle(
                                          fontFamily: 'Itim', fontSize: 25),
                                    ),
                                  ),
                                ),
                              ),

                              //Total amount
                              Positioned(
                                bottom: size.height * 0.12,
                                child: Container(
                                  width: size.width * 0.9,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Totale",
                                        style: TextStyle(
                                            fontFamily: 'Itim', fontSize: 20),
                                      ),
                                      Text(
                                        "0 €",
                                        style: TextStyle(
                                            fontFamily: 'Itim', fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

class CatListView extends StatelessWidget {
  final cat;
  const CatListView({Key key, this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Services.pietanzaDaCategoria(cat),
      builder: (context, snapshot) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: snapshot?.data?.length ?? 0,
          itemBuilder: (context, index) {
            Pietanza p = snapshot.data[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 10)
              ]),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: ListTile(
                  tileColor: Colors.white,
                  title: Text(p.nome),
                  subtitle: Text("Qt. 0"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("${p.prezzo.toString()} €"),
                      IconButton(
                        onPressed: () {
                          print(p.nome);
                        },
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: colorBtn,
                        ),
                        iconSize: 40,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

//https://i.pinimg.com/originals/da/85/ef/da85ef1ffa269927371bd5e511a408ec.png
