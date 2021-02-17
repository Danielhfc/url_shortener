import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'models/historic_model.dart';


class HistoricWidget extends StatelessWidget {
  const HistoricWidget({Key key, this.historic, this.removeClicked}) : super(key: key);

  final HistoricModel historic;
  final Function removeClicked;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return ListTile(
          title: Text(historic.title),
          subtitle: Text(historic.url),
          leading: IconButton(
            icon: Icon(Icons.content_copy),
                    onPressed: () async {
                      await FlutterClipboard.copy(historic.url);
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Copiado para a área de transferência!'),
                      ));
                    }),
          trailing: IconButton(
            icon: Icon(Icons.remove_circle, color: Colors.red,),
            onPressed: removeClicked,
          ),
        );
      },
    );
  }
}
