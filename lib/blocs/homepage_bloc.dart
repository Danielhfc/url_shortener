import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:url_shortener/models/shorten_model.dart';



class HomePageBloc {
  // ignore: close_sinks
  final StreamController<String> _streamController =
      StreamController<String>.broadcast();
  Sink<String> get input => _streamController.sink;
  Stream<Shorten> get output =>
      _streamController.stream.asyncMap((url) => shortener(url));

  Future<Shorten> shortener(String url) async {
    final response = await http.post(
      Uri.https('goolnk.com', 'api/v1/shorten'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'url': url,
      }),
    );

    if (response.statusCode == 200)
      return Shorten.fromJson(jsonDecode(response.body));
    else
      throw Exception('Erro com a URL');
  }
}
