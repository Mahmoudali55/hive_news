// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_news/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:hive_news/controllers/read_data_cubit/read_data_cubit_stata.dart';
import 'package:hive_news/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:hive_news/controllers/write_data_cubit/write_data_state_cubic.dart';
import 'package:hive_news/model/word_model.dart';
import 'package:hive_news/view/widgets/exception_widget.dart';
import 'package:hive_news/view/widgets/loading_widgets.dart';
import 'package:hive_news/view/widgets/updata_word_button.dart';
import 'package:hive_news/view/widgets/updata_word_dialog.dart';
import 'package:hive_news/view/widgets/word_info_widget.dart';

class WordDetailsScreen extends StatefulWidget {
  const WordDetailsScreen({super.key, required this.wordModel});
  final WordModel wordModel;

  @override
  State<WordDetailsScreen> createState() => _WordDetailsScreenState();
}

class _WordDetailsScreenState extends State<WordDetailsScreen> {
  late WordModel _wordModel;
  @override
  void initState() {
    super.initState();
    _wordModel = widget.wordModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: BlocBuilder<ReadDataCubit, ReadDataCubitStates>(
        builder: (context, state) {
          if (state is ReadDataCubitSuccessState) {
            int index = state.words.indexWhere((element) =>
                element.indexAtDatabase == _wordModel.indexAtDatabase);
            _wordModel = state.words[index];
            return getSuccessBody(context);
          } else if (state is ReadDataCubitFailedState) {
            return ExceptionWidget(
                iconData: Icons.error, message: state.message);
          }
          return LoadingWidget();
        },
      ),
    );
  }

  ListView getSuccessBody(BuildContext context) {
    return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        children: [
          _getLabelText('Word'),
          SizedBox(
            height: 10,
          ),
          WordInfoWidget(
            color: Color(_wordModel.colorCode),
            text: _wordModel.text,
            isArabic: _wordModel.isArabic,
          ),
          SizedBox(
            height: 20,
          ),
          Row(children: [
            _getLabelText('Similar Words'),
            Spacer(),
            UpdataWordButton(
              color: Color(_wordModel.colorCode),
              ontap: () => showDialog(
                  context: context,
                  builder: ((context) => UpdataWordDialog(
                      indexAtDatabase: _wordModel.indexAtDatabase,
                      isExample: false,
                      colorCode: _wordModel.colorCode))),
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          for (int i = 0; i < _wordModel.arabicSimilarWords.length; i++)
            WordInfoWidget(
                color: Color(_wordModel.colorCode),
                text: _wordModel.arabicSimilarWords[i],
                isArabic: true,
                onpressed: () => _deleteArabicSimilarWord(i)),
          SizedBox(
            height: 20,
          ),
          for (int i = 0; i < _wordModel.englishSimilarWords.length; i++)
            WordInfoWidget(
                color: Color(_wordModel.colorCode),
                text: _wordModel.englishSimilarWords[i],
                isArabic: false,
                onpressed: () => _deleteEnglishsimilar(i)),
          SizedBox(
            height: 20,
          ),
          Row(children: [
            _getLabelText('Examples'),
            Spacer(),
            UpdataWordButton(
              ontap: () => showDialog(
                  context: context,
                  builder: ((context) => UpdataWordDialog(
                      indexAtDatabase: _wordModel.indexAtDatabase,
                      isExample: true,
                      colorCode: _wordModel.colorCode))),
              color: Color(_wordModel.colorCode),
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          for (int i = 0; i < _wordModel.arabicExamples.length; i++)
            WordInfoWidget(
                color: Color(_wordModel.colorCode),
                text: _wordModel.arabicExamples[i],
                isArabic: true,
                onpressed: () => _deleteArabicExample(i)),
          SizedBox(
            height: 20,
          ),
          for (int i = 0; i < _wordModel.englishExamples.length; i++)
            WordInfoWidget(
                color: Color(_wordModel.colorCode),
                text: _wordModel.englishExamples[i],
                isArabic: false,
                onpressed: () => _deleteEnglishExample(i)),
        ]);
  }

  void _deleteEnglishExample(int index) {
    WriteDataCubit.get(context).deleteExampleWord(
      _wordModel.indexAtDatabase,
      index,
      false,
    );
    ReadDataCubit.get(context).getWords();
  }

  void _deleteArabicExample(int index) {
    WriteDataCubit.get(context).deleteExampleWord(
      _wordModel.indexAtDatabase,
      index,
      true,
    );
    ReadDataCubit.get(context).getWords();
  }

  void _deleteEnglishsimilar(int index) {
    WriteDataCubit.get(context).deleteSimimarWord(
      _wordModel.indexAtDatabase,
      index,
      false,
    );
    ReadDataCubit.get(context).getWords();
  }

  void _deleteArabicSimilarWord(int index) {
    WriteDataCubit.get(context).deleteSimimarWord(
      _wordModel.indexAtDatabase,
      index,
      true,
    );
    ReadDataCubit.get(context).getWords();
  }

  AppBar getAppBar(BuildContext context) {
    return AppBar(
      foregroundColor: Color(_wordModel.colorCode),
      title: Text('Word Details',
          style: TextStyle(color: Color(_wordModel.colorCode))),
      actions: [
        IconButton(
            onPressed: () => _deleteWord(context), icon: Icon(Icons.delete))
      ],
    );
  }

  void _deleteWord(BuildContext context) {
    WriteDataCubit.get(context).deleteWord(_wordModel.indexAtDatabase);
    Navigator.pop(context);
  }

  Widget _getLabelText(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Color(_wordModel.colorCode),
          fontSize: 20,
          fontWeight: FontWeight.bold),
    );
  }
}
