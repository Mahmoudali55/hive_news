import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_news/controllers/write_data_cubit/write_data_state_cubic.dart';
import 'package:hive_news/hive_constants.dart';
import 'package:hive_news/model/word_model.dart';

class WriteDataCubit extends Cubit<WriteDateCubitStates> {
  WriteDataCubit() : super(WriteDateCubitIntialState());
  static WriteDataCubit get(context) => BlocProvider.of(context);
  final Box box = Hive.box(HiveConatants.wordsBox);
  String text = '';
  bool isArabic = true;
  int colorCode = 0xFF4A47A3;
  void updateText(String text) {
    this.text = text;
  }

  void updateIsAribic(bool isArabic) {
    this.isArabic = isArabic;
    emit(WriteDateCubitIntialState());
  }

  void updateColorCode(int colorCode) {
    this.colorCode = colorCode;
    emit(WriteDateCubitIntialState());
  }

  void addWord() {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFormDatabase();
      words.add(WordModel(
          indexAtDatabase: words.length,
          text: text,
          isArabic: isArabic,
          colorCode: colorCode));
      box.put(HiveConatants.wordsList, words);
    }, 'we have problem when we add word');
  }

  void deleteWord(int indexAtDatabase) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFormDatabase();
      words.removeAt(indexAtDatabase);
      for (var i = indexAtDatabase; i < words.length; i++) {
        words[i] = words[i].decrementIndexAtDataBase();
      }
      box.put(HiveConatants.wordsList, words);
    }, 'we have problem when we delete word');
  }

  void _tryAndCatchBlock(VoidCallback methodToExecute, String message) {
    emit(WriteDateCubitLoadingState());
    try {
      methodToExecute.call();
      emit(WriteDateCubitSuccessState());
    } catch (error) {
      emit(WriteDateCubitFailedState(message: message));
    }
  }

  List<WordModel> _getWordsFormDatabase() =>
      List.from(box.get(HiveConatants.wordsList, defaultValue: []))
          .cast<WordModel>();
  void addSimimarWord(int indexAtDatabase) {
    _tryAndCatchBlock(
      () {
        List<WordModel> words = _getWordsFormDatabase();
        words[indexAtDatabase] =
            words[indexAtDatabase].addsimilarWord(text, isArabic);
        box.put(HiveConatants.wordsList, words);
      },
      'we have problems when we add Similar word',
    );
  }

  void addExampleWord(int indexAtDatabase) {
    _tryAndCatchBlock(
      () {
        List<WordModel> words = _getWordsFormDatabase();
        words[indexAtDatabase] =
            words[indexAtDatabase].addExample(text, isArabic);
        box.put(HiveConatants.wordsList, words);
      },
      'we have problems when we add Example word',
    );
  }

  void deleteSimimarWord(
      int indexAtDatabase, int indexAtSimilarWord, bool isArabicSimilarWord) {
    _tryAndCatchBlock(
      () {
        List<WordModel> words = _getWordsFormDatabase();
        words[indexAtDatabase] = words[indexAtDatabase]
            .deletesimilarWord(indexAtSimilarWord, isArabicSimilarWord);
        box.put(HiveConatants.wordsList, words);
      },
      'we have problems when we delete Similar word',
    );
  }

  void deleteExampleWord(
      int indexAtDatabase, int indexAtExamples, bool isArabicExample) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFormDatabase();
      words[indexAtDatabase] = words[indexAtDatabase]
          .deleteExample(indexAtExamples, isArabicExample);
      box.put(HiveConatants.wordsList, words);
    }, 'we have problems when we delete Example word');
  }
}
