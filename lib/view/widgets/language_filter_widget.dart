import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_news/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:hive_news/controllers/read_data_cubit/read_data_cubit_stata.dart';
import 'package:hive_news/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:hive_news/view/styles/color_manger.dart';

class LanguageFilterWidget extends StatelessWidget {
  const LanguageFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataCubitStates>(
        builder: (context, state) {
      return Text(
        mapgetLanguageFilterEnumToString(
            ReadDataCubit.get(context).languageFilter),
        style: TextStyle(
            color: ColorManger.white,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      );
    });
  }

  String mapgetLanguageFilterEnumToString(LanguageFilter languageFilter) {
    if (languageFilter == LanguageFilter.allWords) {
      return "All Words";
    } else if (languageFilter == LanguageFilter.englishOnly) {
      return "English Only";
    } else
      return "Arabic Only";
  }
}
