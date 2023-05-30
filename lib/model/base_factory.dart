import 'dart:developer';

import 'package:quizal/engine/converter.dart';
import 'package:quizal/model/topic.dart';

///
/// Created by alfianhpratama on 28/05/23
///

factoryModel(String type, {Map<String, dynamic>? json}) {
  switch (type) {
    case 'Topic':
      return json != null ? Topic.fromJson(json) : Topic(topic: '');
    case 'String':
      return json ?? '-';
    case 'dynamic':
      return json != null ? DefaultModel(json) : DefaultModel({});
    default:
      throw '$type factory unimplemented!';
  }
}

abstract class ModelFactory {
  factory ModelFactory.fromJson(Type type, Map<String, dynamic> json) {
    String strType = type.toString().trim().replaceAll("?", "");
    return factoryModel(strType, json: json);
  }
}

class DefaultModel implements ModelFactory {
  dynamic result;
  String? warning;

  DefaultModel(this.result, {this.warning}) {
    log('$warning');
  }
}

class ListFactory<T> {
  List<T> data;

  ListFactory({this.data = const []});

  factory ListFactory.fromJson(List<dynamic>? json) {
    if (json == null) return ListFactory();
    List<T>? data = <T>[];
    data = json.map((i) => Converter<T>().fromJson(i as Object)).toList();
    return ListFactory<T>(data: data);
  }
}
