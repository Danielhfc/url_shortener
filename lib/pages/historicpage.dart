import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:url_shortener/components/home_controller.dart';

import '../historic_widget.dart';



class HistoricPage extends StatefulWidget {
  HistoricPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HistoricPageState createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage> {


  @override
  Widget build(BuildContext context) {
    final controller = GetIt.I.get<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: controller.setFilter,
          decoration: InputDecoration(hintText: "Filtrar..."),
        ),
      ),
      body: Observer(
        builder: (_) {
          if (controller.output.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: controller.output.data.length,
            itemBuilder: (_, index) {
              var historic = controller.output.data[index];
              return HistoricWidget(
                historic: historic,
                removeClicked: () {
                  controller.removeHistoric(historic);
                },
              );
            },
          );
        },
      ),

    );
  }
}
