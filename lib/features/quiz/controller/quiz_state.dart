part of 'quiz_cubit.dart';

@freezed
class QuizState with _$QuizState {
  const factory QuizState({
    @Default(DataStateStatus.initial) DataStateStatus status,
    @Default(0) double timer,
    Quiz? activeQuiz,
  }) = _QuizState;
}
