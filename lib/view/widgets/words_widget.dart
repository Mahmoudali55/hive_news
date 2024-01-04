import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_news/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:hive_news/controllers/read_data_cubit/read_data_cubit_stata.dart';
import 'package:hive_news/model/word_model.dart';
import 'package:hive_news/view/widgets/exception_widget.dart';
import 'package:hive_news/view/widgets/loading_widgets.dart';
import 'package:hive_news/view/widgets/word_item_widget.dart';

class WordsWidget extends StatelessWidget {
  const WordsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataCubitStates>(
        builder: (context, state) {
      if (state is ReadDataCubitSuccessState) {
        if (state.words.isEmpty) {
          return _getEmptyWordsWidget();
        }
        return _getWordsWidget(state.words);
      } else if (state is ReadDataCubitFailedState) {
        return _widgetFailedWidget(state.message);
      } else {
        return _getLoadingWidget();
      }
    });
  }

  Widget _getWordsWidget(List<WordModel> words) {
    return GridView.builder(
        itemCount: words.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 2 / 1.5),
        itemBuilder: (context, index) {
          return WordItemWidget(wordModel: words[index]);
        });
  }

  Widget _getEmptyWordsWidget() {
    return ExceptionWidget(
      iconData: Icons.list_rounded,
      message: 'Empty words list',
    );
  }

  Widget _widgetFailedWidget(String message) {
    return ExceptionWidget(
      iconData: Icons.error_outline_rounded,
      message: message,
    );
  }

  Widget _getLoadingWidget() {
    return LoadingWidget();
  }
}
