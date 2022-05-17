import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/components.dart';

import '../../../layout/news_app/cubit/cubit_cubit.dart';


class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context, state) {
        },
      builder: (context, state) {
        var list=NewsCubit.get(context).sports;
        return articleBuilder(list,context);
      },
    );
  }
}
