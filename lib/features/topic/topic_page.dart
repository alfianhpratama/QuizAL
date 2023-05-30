import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizal/features/topic/controller/topic_cubit.dart';
import 'package:quizal/utils/widgets/container_state_handler.dart';
import 'package:quizal/utils/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

///
/// Created by alfianhpratama on 28/05/23
///

class TopicPage extends StatelessWidget {
  static const String routeName = '/topic';

  const TopicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TopicCubit>(
      create: (context) => TopicCubit(context),
      child: const TopicScreen(),
    );
  }
}

class TopicScreen extends StatelessWidget {
  const TopicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TopicCubit>();
    final searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Topics')),
      body: BlocBuilder<TopicCubit, TopicState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(4.w, 4.w, 4.w, 0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    isDense: true,
                    hintText: 'Search Topic',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 3.w,
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  onChanged: cubit.onTypingSearch,
                ),
              ),
              Expanded(
                child: ContainerStateHandler(
                  status: state.status,
                  loading: const Center(child: CircularProgressIndicator()),
                  child: ListView.separated(
                    padding: EdgeInsets.all(4.w),
                    itemBuilder: (ctx, index) {
                      return CustomButton(
                        onPressed: () => cubit.onChooseTopic(state.data[index]),
                        borderRadius: BorderRadius.circular(2.w),
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(4.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  state.data[index].topic,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Icon(Icons.arrow_forward_ios, size: 4.w),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => SizedBox(height: 1.6.w),
                    itemCount: state.data.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
