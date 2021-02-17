import 'package:mobx/mobx.dart';
part 'historic_model.g.dart';

class HistoricModel = _HistoricModelBase with _$HistoricModel;

abstract class _HistoricModelBase with Store {

  _HistoricModelBase({this.title="", this.url=''});

  @observable
  String title;

  @observable
  String url;

  @action
  setTitle(String value) => title = value;

  @action
  setUrl(String value) => url = value; 
}