import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quizal/model/base_factory.dart';
import 'package:quizal/model/quiz.dart';

part 'topic.g.dart';

///
/// Created by alfianhpratama on 29/05/23
///

@JsonSerializable()
class Topic implements ModelFactory {
  String topic;
  List<Quiz>? quiz;

  Topic({required this.topic, this.quiz});

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);

  Map<String, dynamic> toJson() => _$TopicToJson(this);
}
