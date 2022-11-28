import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_app_v2/data/data_slider.dart';
import 'package:go_app_v2/ui/home/controllers/controllers.dart';
import 'package:go_app_v2/ui/widgets/home/modal_external_app.dart';

getSliderImage(context) {
  List _data = getDataSlider();

  return Container(
    width: double.infinity,
    height: 140,
    child: Column(
      children: [
        Flexible(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Row(
                children: [
                  ...List.generate(
                      _data.length,
                      (index) => GestureDetector(
                            onTap: () {
                              getModalExternalApp(
                                  context,
                                  Platform.isIOS
                                      ? _data[index]['playStoreURL']
                                      : _data[index]['appStoreURL']);
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              alignment: Alignment.center,
                              child: Image.asset(_data[index]['image'],
                                  fit: BoxFit.fill),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ))
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            child: Image.asset('assets/Ref1/+App.png', width: 170),
            onTap: () {
              ControllersHome().getNavigateOurApps(context);
            },
          ),
        )
      ],
    ),
  );
}
