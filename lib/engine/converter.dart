import 'package:json_annotation/json_annotation.dart';
import 'package:quizal/model/base_factory.dart';

///
/// Created by alfianhpratama on 28/05/23
///

class Converter<T> implements JsonConverter<T, Object> {
  const Converter();

  @override
  T fromJson(Object json) {
    if (json is Map<String, dynamic>) {
      return ModelFactory.fromJson(T, json) as T;
    }
    return json as T;
  }

  @override
  Object toJson(T object) => (object as Object);
}

class ConverterForceString implements JsonConverter<String?, dynamic> {
  const ConverterForceString();

  @override
  String? fromJson(dynamic json) {
    if (json == null || json.toString().isEmpty) return null;
    return json.toString();
  }

  @override
  String? toJson(String? object) => object;
}
