import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:clipboard/clipboard.dart';
import 'package:url_shortener/blocs/homepage_bloc.dart';
import 'package:url_shortener/components/home_controller.dart';
import 'package:url_shortener/models/historic_model.dart';
import 'package:url_shortener/models/shorten_model.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageBloc bloc = HomePageBloc();
  final _controller = TextEditingController();
  String encurtado = '';

 

  @override
  Widget build(BuildContext context) {
    final controller = GetIt.I.get<HomeController>();

     _dialog() {
    var model = HistoricModel();

    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Salvar Link"),
            content: TextField(
              onChanged: model.setTitle,
              onSubmitted: (_) {
                  model.setUrl(encurtado);
                  controller.addHistoric(model);
                  Navigator.pop(context);
                },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite o título',
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancelar'),
              ),
              FlatButton(
                onPressed: () {
                  model.setUrl(encurtado);
                  controller.addHistoric(model);
                  Navigator.pop(context);
                },
                child: Text('Salvar'),
              )
            ],
          );
        });
  }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildPaste(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () => bloc.input.add(_controller.text),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child:
                        const Text('Encurtar', style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: buildCopy(),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _dialog();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildPaste() => Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: "Cole a URL",
              border: OutlineInputBorder(),
            ),
          )),
          IconButton(
              icon: Icon(Icons.paste),
              onPressed: () async {
                _controller.text = await FlutterClipboard.paste();
              })
        ],
      );

  Widget buildCopy() => Container(
        decoration: const BoxDecoration(
          color: Colors.lightBlueAccent,
        ),
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          title: StreamBuilder<Shorten>(
              stream: bloc.output,
              initialData: Shorten(resultUrl: "Esperando Link"),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    "Erro na Pesquisa",
                    style: TextStyle(color: Colors.red),
                  );
                }

                encurtado = snapshot.data.resultUrl;
                return Text(encurtado);
              }),
          trailing: StreamBuilder<Shorten>(
            stream: bloc.output,
            initialData: Shorten(resultUrl: "Esperando Link"),
            builder: (context, snapshot) {
              return CircleAvatar(
                child: IconButton(
                    icon: Icon(Icons.content_copy),
                    onPressed: () async {
                      await FlutterClipboard.copy(snapshot.data.resultUrl);

                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Copiado para a área de transferência!'),
                      ));
                    }),
              );
            },
          ),
        ),
      );
}
