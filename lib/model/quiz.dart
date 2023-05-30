import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quizal/model/base_factory.dart';

part 'quiz.g.dart';

///
/// Created by alfianhpratama on 29/05/23
///

@JsonSerializable()
class Quiz implements ModelFactory {
  int id;
  String? answer;
  String? image;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  String? question;

  Quiz({
    required this.id,
    this.answer,
    this.image,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.question,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);

  Map<String, dynamic> toJson() => _$QuizToJson(this);
}
