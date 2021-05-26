import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:elaborato_delivery_app/pages/homeOrdineAttendere.dart';
import 'package:elaborato_delivery_app/services/consts.dart';
import 'package:elaborato_delivery_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Pagina per creare il proprio ordine
class HomeOrdine extends StatefulWidget {
  final email;
  const HomeOrdine({Key key, this.email}) : super(key: key);

  @override
  _HomeOrdineState createState() => _HomeOrdineState();
}

class _HomeOrdineState extends State<HomeOrdine> {
  var ordine = <elementoOrdine>[];
  bool puoiAggiungere = false;
  DateTime dataSelezionata = DateTime.now();
  TimeOfDay orarioSelezionato = TimeOfDay.now();
  Cliente cliente;

  Widget _catListView(int cat) {
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
                  title: Text(
                    p.nome,
                    style: TextStyle(fontSize: 19, fontFamily: 'Itim'),
                  ),
                  //subtitle: Text("Qt. 0"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${p.prezzo.toString()} €",
                        style: TextStyle(fontSize: 15, fontFamily: 'Itim'),
                      ),
                      IconButton(
                        onPressed: () {
                          //TODO aggiunge elemento all'ordine

                          setState(() {
                            if (ordine.isEmpty) {
                              print("Aggiungo ${p.nome}");
                              ordine.add(elementoOrdine(p: p, n: 1));
                            } else {
                              for (final eo in ordine) {
                                if (eo.p.pietanza_id == p.pietanza_id) {
                                  eo.n += 1;
                                  puoiAggiungere = false;
                                  break;
                                } else {
                                  puoiAggiungere = true;
                                }
                              }

                              if (puoiAggiungere) {
                                ordine.add(elementoOrdine(p: p, n: 1));
                                puoiAggiungere = true;
                              }
                            }

                            print("Ordine: ");
                            ordine.forEach((element) {
                              print("${element.p.nome}: ${element.n}");
                            });
                          });
                        },
                        icon: Icon(
                          Icons.add,
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

  String _totale() {
    double tot = 0;
    for (final eo in ordine) {
      tot += eo.p.prezzo * eo.n;
    }

    ordine.sort((elementoOrdine a, elementoOrdine b) =>
        a.p.pietanza_id.compareTo(b.p.pietanza_id));

    return tot.toString();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime selezionata = await showDatePicker(
        context: context,
        initialDate: dataSelezionata,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (selezionata != null && selezionata != dataSelezionata)
      setState(() {
        dataSelezionata = selezionata;
      });
  }

  Future _pickTime(BuildContext context) async {
    final initialTime = TimeOfDay.now();
    final newTime = await showTimePicker(
      context: context,
      initialTime: orarioSelezionato ?? initialTime,
    );

    if (newTime == null) return;

    //TODO controllo che l'orario selezionato sia dopo l'orario attuale se la data è oggi

    setState(() {
      orarioSelezionato = newTime;
    });
  }

  _showDialog(BuildContext context) {
    VoidCallback continueCallBack = () {
      Navigator.of(context).pop();

      Services.inserimentoOrdine(dataSelezionata, orarioSelezionato,
              double.parse(_totale()), cliente.cliente_id)
          .then((value) {
        int ordine_id;
        var valueDecoded = json.decode(value);
        for (var c in valueDecoded) {
          ordine_id = int.parse(c['ordine_id']);
        }
        for (var p in ordine) {
          Services.aggiungiPietanzaOrdine(p.n, p.p.pietanza_id, ordine_id).then((value){
            print("value: ${value}");
          });
        }

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeOrdineAttendere(
                  email: widget.email,
                )));

        //TODO andare alla pagina di "Attendere"
      });
    };

    if (double.parse(_totale()) > 0.0) {
      BlurryDialog alert = BlurryDialog("Confermare l'ordine?",
          "Sei sicuro di voler confermare l'ordine?", continueCallBack, 0);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  @override
  void initState() {
    //Prendere il client_id dalla mail
    Services.clienteById(widget.email).then((value) {
      setState(() {
        cliente = value;
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
          body: Container(
            width: size.width,
            height: size.height,
            color: colorBgApp,
            child: Stack(
              alignment: Alignment.center,
              children: [
                //DatePicker
                Positioned(
                  top: size.height * 0.055,
                  left: size.width * 0.09,
                  height: size.width * 0.12,
                  width: size.width * 0.12,
                  child: IconButton(
                    onPressed: () => _selectDate(context),
                    icon: Icon(Icons.calendar_today_sharp),
                    iconSize: 30,
                    color: colorBtnDark,
                  ),
                ),

                //DateText
                Positioned(
                  top: size.height * 0.105,
                  left: size.width * 0.045,
                  child: GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Text(
                        "${DateFormat('dd-MM-yyyy').format(dataSelezionata.toLocal())}",
                        style: TextStyle(fontSize: 17, fontFamily: 'Itim'),
                      )),
                ),

                //TimePicker
                Positioned(
                  top: size.height * 0.046,
                  right: size.width * 0.073,
                  height: size.width * 0.12,
                  width: size.width * 0.12,
                  child: IconButton(
                    onPressed: () => _pickTime(context),
                    icon: IconButton(
                      icon: Icon(
                        Icons.timer,
                        color: colorBtnDark,
                      ),
                      iconSize: 32,
                    ),
                  ),
                ),

                //TimeText
                Positioned(
                  top: size.height * 0.105,
                  right: size.width * 0.058,
                  child: GestureDetector(
                      onTap: () => _pickTime(context),
                      child: Text(
                        "${orarioSelezionato.hour}:${(orarioSelezionato.minute).toString().padLeft(2, '0')}",
                        style: TextStyle(fontSize: 18, fontFamily: 'Itim'),
                      )),
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
                        "    Pranzo al Sacco",
                        style: TextStyle(
                            color: colorBtn, fontSize: 25, fontFamily: 'Itim'),
                      ),
                    ],
                  ),
                ),

                //MainContainer
                Positioned(
                  bottom: size.height * 0.11,
                  child: Container(
                    height: size.height * 0.74,
                    width: size.width * 0.95,
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overscroll) {
                        overscroll.disallowGlow();
                        return null;
                      },
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
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
                            _catListView(0),

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
                            _catListView(1),

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
                            _catListView(2),

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
                            _catListView(3),

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
                            _catListView(4),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                //Bottom draggableScrollableSheet
                DraggableScrollableSheet(
                  initialChildSize: 0.11,
                  minChildSize: 0.11,
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
                                  onPressed: () {
                                    setState(() {
                                      ordine.clear();
                                    });
                                  },
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
                                    onPressed: () {
                                      //TODO mandare ordine al db, da fare accettare poi dal commesso nel sito
                                      _showDialog(context);
                                    },
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

                              //ListView ordine
                              Positioned(
                                top: size.height * 0.118,
                                child: Container(
                                  //color: Colors.green,
                                  width: size.width,
                                  height: size.height * 0.22,
                                  child: MediaQuery.removePadding(
                                    removeTop: true,
                                    context: context,
                                    child: ordine.isNotEmpty
                                        ? ListView.builder(
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              elementoOrdine eo = ordine[index];
                                              return Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.3),
                                                          spreadRadius: 5,
                                                          blurRadius: 10)
                                                    ]),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15)),
                                                  child: ListTile(
                                                    tileColor: Colors.white,
                                                    title: Text(
                                                      eo.p.nome,
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontFamily: 'Itim'),
                                                    ),
                                                    subtitle: Text(
                                                      "Qt. ${eo.n}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontFamily: 'Itim'),
                                                    ),
                                                    dense: true,
                                                    trailing: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          "${eo.p.prezzo.toString()} €",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  'Itim'),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            //TODO rimuove quantità
                                                            setState(() {
                                                              if (eo.n > 1) {
                                                                eo.n -= 1;
                                                              } else {
                                                                ordine
                                                                    .remove(eo);
                                                              }
                                                            });
                                                          },
                                                          icon: Icon(
                                                            Icons.remove,
                                                            color: colorBtn,
                                                          ),
                                                          iconSize: 30,
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            //TODO aggiunge quantità
                                                            setState(() {
                                                              eo.n += 1;
                                                            });
                                                          },
                                                          icon: Icon(
                                                            Icons.add,
                                                            color: colorBtn,
                                                          ),
                                                          iconSize: 30,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            itemCount: ordine.length)
                                        : Container(
                                            child: Center(
                                              child: Text(
                                                "Il carrello è vuoto...",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'Itim'),
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ),

                              //Total amount
                              Positioned(
                                bottom: size.height * 0.10,
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
                                        "${_totale()} €",
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

//https://i.pinimg.com/originals/da/85/ef/da85ef1ffa269927371bd5e511a408ec.png

class elementoOrdine {
  Pietanza p;
  int n;

  elementoOrdine({Key key, this.p, this.n});
}
