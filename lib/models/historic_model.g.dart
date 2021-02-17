// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historic_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HistoricModel on _HistoricModelBase, Store {
  final _$titleAtom = Atom(name: '_HistoricModelBase.title');

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  final _$urlAtom = Atom(name: '_HistoricModelBase.url');

  @override
  String get url {
    _$urlAtom.reportRead();
    return super.url;
  }

  @override
  set url(String value) {
    _$urlAtom.reportWrite(value, super.url, () {
      super.url = value;
    });
  }

  final _$_HistoricModelBaseActionController =
      ActionController(name: '_HistoricModelBase');

  @override
  dynamic setTitle(String value) {
    final _$actionInfo = _$_HistoricModelBaseActionController.startAction(
        name: '_HistoricModelBase.setTitle');
    try {
      return super.setTitle(value);
    } finally {
      _$_HistoricModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUrl(String value) {
    final _$actionInfo = _$_HistoricModelBaseActionController.startAction(
        name: '_HistoricModelBase.setUrl');
    try {
      return super.setUrl(value);
    } finally {
      _$_HistoricModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
title: ${title},
url: ${url}
    ''';
  }
}
