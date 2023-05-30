import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizal/utils/widgets/loading_dialog.dart';

///
/// Created by alfianhpratama on 28/05/23
///

abstract class BaseCubit<State> extends Cubit<State> {
  final loadingDialog = LoadingDialog();

  BaseCubit(super.initialState);

  Future<void> getData();
}
