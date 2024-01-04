import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_news/controllers/read_data_cubit/read_data_cubit_stata.dart';
import 'package:hive_news/hive_constants.dart';
import 'package:hive_news/model/word_model.dart';

class ReadDataCubit extends Cubit<ReadDataCubitStates> {
  static ReadDataCubit get(context) => BlocProvider.of(context);
  ReadDataCubit() : super(ReadDataCubitInitialState());
  final Box _box = Hive.box(HiveConatants.wordsBox);
  LanguageFilter languageFilter = LanguageFilter.allWords;
  SortBy sortBy = SortBy.time;
  SortingType sortingType = SortingType.descending;

  void updateLanguageFilter(LanguageFilter languageFilter) {
    this.languageFilter = languageFilter;
    getWords();
  }

  void updateSorteby(SortBy sortBy) {
    this.sortBy = sortBy;
    getWords();
  }

  void updateSortType(SortingType sortingType) {
    this.sortingType = sortingType;
    getWords();
  }

  void getWords() {
    emit(ReadDataCubitLoadingState());
    try {
      List<WordModel> wordsToReturn =
          List.from(_box.get(HiveConatants.wordsList, defaultValue: []))
              .cast<WordModel>();
      _removeUnwantedWords(wordsToReturn);
      _applySorting(wordsToReturn);

      emit(ReadDataCubitSuccessState(words: wordsToReturn));
    } catch (error) {
      emit(ReadDataCubitFailedState(
          message: 'we have problem at get, plasse try again'));
    }
  }

  void _removeUnwantedWords(List<WordModel> wordsToReturn) {
    if (languageFilter == LanguageFilter.allWords) {
      return;
    }
    for (var i = 0; i < wordsToReturn.length; i++) {
      if ((languageFilter == LanguageFilter.arabicOnly &&
              wordsToReturn[i].isArabic == false) ||
          (languageFilter == LanguageFilter.englishOnly &&
              wordsToReturn[i].isArabic == true)) {
        wordsToReturn.removeAt(i);
        i--;
      }
    }
  }

  void _applySorting(List<WordModel> wordsToReturn) {
    if (sortBy == SortBy.time) {
      if (sortingType == SortingType.ascending) {
        return;
      } else {
        _reverse(wordsToReturn);
      }
    } else {
      wordsToReturn.sort(
          (WordModel a, WordModel b) => a.text.length.compareTo(b.text.length));
      if (sortingType == SortingType.ascending) {
        return;
      } else {
        _reverse(wordsToReturn);
      }
    }
  }

  void _reverse(List<WordModel> wordToReturn) {
    for (var i = 0; i < wordToReturn.length / 2; i++) {
      WordModel temp = wordToReturn[i];
      wordToReturn[i] = wordToReturn[wordToReturn.length - 1 - i];
      wordToReturn[wordToReturn.length - 1 - i] = temp;
    }
  }
}

enum LanguageFilter {
  arabicOnly,
  englishOnly,
  allWords,
}

enum SortBy {
  time,
  wordLength,
}

enum SortingType {
  ascending,
  descending,
}
