import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_news/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:hive_news/controllers/read_data_cubit/read_data_cubit_stata.dart';
import 'package:hive_news/view/styles/color_manger.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataCubitStates>(
        builder: (context, state) {
      return Dialog(
        backgroundColor: ColorManger.black,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getLabText('Language'),
                getFilterpramField(context),
                getLabText('Sort By'),
                getSortedByFlitter(context),
                getLabText('Sorting Type'),
                getSortedTypeFlitter(context),
              ]),
        ),
      );
    });
  }

  Widget _getFilterField(
      {required List<String> labls,
      required List<VoidCallback> ontaps,
      required List<bool> conditionOfActivation}) {
    return Row(children: [
      for (int i = 0; i < labls.length; i++)
        InkWell(
          onTap: ontaps[i],
          child: Container(
            padding: EdgeInsets.all(10),
            height: 40,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: ColorManger.white,
                  width: 2,
                ),
                color: conditionOfActivation[i]
                    ? ColorManger.white
                    : ColorManger.black),
            child: Center(
              child: Text(
                labls[i],
                style: TextStyle(
                  color: conditionOfActivation[i]
                      ? ColorManger.black
                      : ColorManger.white,
                ),
              ),
            ),
          ),
        )
    ]);
  }

  Widget getFilterpramField(BuildContext context) {
    return _getFilterField(labls: [
      'Arabic',
      'English',
      'All'
    ], ontaps: [
      () => ReadDataCubit.get(context)
          .updateLanguageFilter(LanguageFilter.arabicOnly),
      () => ReadDataCubit.get(context)
          .updateLanguageFilter(LanguageFilter.englishOnly),
      () => ReadDataCubit.get(context)
          .updateLanguageFilter(LanguageFilter.allWords),
    ], conditionOfActivation: [
      ReadDataCubit.get(context).languageFilter == LanguageFilter.arabicOnly,
      ReadDataCubit.get(context).languageFilter == LanguageFilter.englishOnly,
      ReadDataCubit.get(context).languageFilter == LanguageFilter.allWords,
    ]);
  }

  Widget getSortedByFlitter(BuildContext context) {
    return _getFilterField(
      labls: ['Time', 'Word Length'],
      ontaps: [
        () => ReadDataCubit.get(context).updateSorteby(SortBy.time),
        () => ReadDataCubit.get(context).updateSorteby(SortBy.wordLength),
      ],
      conditionOfActivation: [
        ReadDataCubit.get(context).sortBy == SortBy.time,
        ReadDataCubit.get(context).sortBy == SortBy.wordLength,
      ],
    );
  }

  Widget getSortedTypeFlitter(BuildContext context) {
    return _getFilterField(
      labls: ['Ascending', 'Descending'],
      ontaps: [
        () => ReadDataCubit.get(context).updateSortType(SortingType.ascending),
        () => ReadDataCubit.get(context).updateSortType(SortingType.descending),
      ],
      conditionOfActivation: [
        ReadDataCubit.get(context).sortingType == SortingType.ascending,
        ReadDataCubit.get(context).sortingType == SortingType.descending,
      ],
    );
  }

  Widget getLabText(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: ColorManger.white),
    );
  }
}
