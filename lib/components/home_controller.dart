import 'package:mobx/mobx.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_shortener/models/historic_model.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final listHistoric = BehaviorSubject<List<HistoricModel>>.seeded([]);
  final filter = BehaviorSubject<String>.seeded('');

  ObservableStream<List<HistoricModel>> output;

  _HomeControllerBase() {
    output =
        Rx.combineLatest2<List<HistoricModel>, String, List<HistoricModel>>(
      listHistoric.stream,
      filter.stream,
      (list, filter) {
        if (filter.isEmpty) {
          return list;
        } else {
          return list
              .where((element) =>
                  element.title.toLowerCase().contains(filter.toLowerCase()))
              .toList();
        }
      },
    ).asObservable(initialValue: []);
  }

  setFilter(String value) => filter.add(value);

  @action
  addHistoric(HistoricModel model) {
    var list = List<HistoricModel>.from(listHistoric.value);
    list.add(model);
    listHistoric.add(list);
  }

  @action
  removeHistoric(HistoricModel model) {
    var list = List<HistoricModel>.from(listHistoric.value);
    list.removeWhere((historic) => historic.title == model.title);
    listHistoric.add(list);
  }
}
