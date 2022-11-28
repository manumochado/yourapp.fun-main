import 'dart:io';
import 'package:go_app_v2/i18n/strings.g.dart'; // import

import 'package:flutter/material.dart';
import 'package:go_app_v2/data/data_slider.dart';
import 'package:go_app_v2/ui/widgets/home/app_bar.dart';
import 'package:go_app_v2/ui/widgets/home/background.dart';
import 'package:go_app_v2/ui/widgets/home/modal_external_app.dart';
import 'package:url_launcher/url_launcher.dart';

class OurApps extends StatefulWidget {
  OurApps({Key? key}) : super(key: key);

  @override
  State<OurApps> createState() => _OurAppsState();
}

class _OurAppsState extends State<OurApps> {
  String _search = "";
  final recommendationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          getAppBar(),
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            t.ourAppsTitle,
            height: 40,
          ),
          Expanded(
              child: Stack(
            children: [
              getBackGround(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SearchBar(),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: getData().isEmpty
                          ? EmptyState()
                          : ListView(
                              children: [
                                Wrap(
                                  runAlignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.spaceAround,
                                  children: [
                                    ...List.generate(
                                        getData().length,
                                        (index) => GestureDetector(
                                              onTap: () {
                                                getModalExternalApp(
                                                    context,
                                                    Platform.isIOS
                                                        ? getData()[index]
                                                            ['playStoreURL']
                                                        : getData()[index]
                                                            ['appStoreURL']);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(12.0),
                                                width: 115,
                                                alignment: Alignment.center,
                                                child: Column(
                                                  children: [
                                                    Image.asset(
                                                        getData()[index]
                                                            ['image'],
                                                        fit: BoxFit.fill),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      getData()[index]['name'],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Rubik-Black',
                                                          fontSize: 15),
                                                    )
                                                  ],
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              ),
                                            ))
                                  ],
                                ),
                              ],
                            ),
                    ),
                  )
                ],
              )
            ],
          ))
        ],
      )),
    );
  }

  getData() {
    List data = getDataSlider();
    List dataSearch = [];
    for (var i = 0; i < data.length; i++) {
      if (data[i]['name']
          .toString()
          .toLowerCase()
          .contains(_search.toLowerCase())) {
        dataSearch.add(data[i]);
      }
    }
    if (_search.isNotEmpty) {
      return dataSearch;
    } else {
      return data;
    }
  }

  Widget SearchBar() {
    return Stack(
      children: [
        Image.asset(
          'assets/Ref3/Barra de Busqueda.png',
        ),
        Positioned.fill(
            child: Container(
                padding: const EdgeInsets.only(left: 15, right: 50),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _search = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: t.ourAppsSearchHint,
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 23),
                  ),
                )))
      ],
    );
  }

  Widget EmptyState() {
    return Container(
      margin: EdgeInsets.only(top: 14, right: 14, left: 14),
      child: Column(
        children: [
          Text(t.titleEmpity,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          Container(
            margin: EdgeInsets.only(top: 14, bottom: 14),
            child: Stack(
              children: [
                Image.asset(
                  'assets/Ref3/Barra de Envio.png',
                ),
                Positioned.fill(
                    child: Container(
                        padding: const EdgeInsets.only(left: 15, right: 50),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            controller: recommendationController,
                            decoration: InputDecoration(
                              hintText: t.ourAppsRecomendHint,
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 23),
                          ),
                        )))
              ],
            ),
          ),
          Row(
            children: [
              Spacer(),
              GestureDetector(
                child: Image.asset('assets/Ref3/Boton Enviar.png', height: 40),
                onTap: () {
                  // launchUrl(Uri.parse('https://www.gocompany.dev/'));

                  // launchUrl(Uri.parse('mailto:gocompanyapps@gmail.com?'
                  //     'subject=Solicitud de artista nuevo&'
                  //     'body=Hola, Go Team. \nMe gustaría que se agregue el artista: "${recommendationController.text}"'));
                  // if (recommendationController.text.isNotEmpty) {}
                },
              ),
              Spacer()
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
