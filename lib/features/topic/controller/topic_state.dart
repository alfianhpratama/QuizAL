part of 'topic_cubit.dart';

@freezed
class TopicState with _$TopicState {
  const factory TopicState({
    @Default(DataStateStatus.initial) DataStateStatus status,
    @Default([]) List<Topic> data,
  }) = _TopicState;
}
