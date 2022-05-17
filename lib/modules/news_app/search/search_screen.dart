import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/news_app/cubit/cubit_cubit.dart';
import 'package:todo_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DefaultFormFeild(
                  controller: searchController,
                  onChange: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  type: TextInputType.text,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'value must not be empty';
                    }
                    return null;
                  },
                  label: 'modules.news_app.search',
                  prefix: Icons.search,
                ),
              ),
              Expanded(child: articleBuilder(list, context,isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
