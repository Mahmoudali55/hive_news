// ignore_for_file: curly_braces_in_flow_control_structures

class WordModel {
  final int indexAtDatabase;
  final String text;
  final bool isArabic;
  final int colorCode;
  final List<String> arabicSimilarWords;
  final List<String> englishSimilarWords;
  final List<String> arabicExamples;
  final List<String> englishExamples;

  WordModel(
      {required this.indexAtDatabase,
      required this.text,
      required this.isArabic,
      required this.colorCode,
      this.arabicSimilarWords = const [],
      this.englishSimilarWords = const [],
      this.arabicExamples = const [],
      this.englishExamples = const []});
  WordModel decrementIndexAtDataBase() {
    return WordModel(
      indexAtDatabase: indexAtDatabase - 1,
      text: text,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicExamples: arabicExamples,
      arabicSimilarWords: arabicSimilarWords,
      englishExamples: englishExamples,
      englishSimilarWords: englishSimilarWords,
    );
  }

  WordModel deleteExample(int indexExamples, bool isArabicExample) {
    List<String> newExamples = _intinalizeNewExamples(isArabicExample);
    newExamples.removeAt(indexExamples);
    return _getWordAfterCheckExample(newExamples, isArabicExample);
  }

  WordModel addExample(String example, bool isArabicExample) {
    List<String> newExamples = _intinalizeNewExamples(isArabicExample);
    newExamples.add(example);
    return _getWordAfterCheckExample(newExamples, isArabicExample);
  }

  WordModel deletesimilarWord(
      int indexSimalilarWord, bool isArabicSimilarWord) {
    List<String> newSimilarWords =
        _intializeNewSimilarWord(isArabicSimilarWord);

    newSimilarWords.removeAt(indexSimalilarWord);
    return _getWordAfterCheckWords(newSimilarWords, isArabicSimilarWord);
  }

  WordModel addsimilarWord(String similarWord, bool isArabicSimilarWord) {
    List<String> newSimilarWords =
        _intializeNewSimilarWord(isArabicSimilarWord);

    newSimilarWords.add(similarWord);
    return _getWordAfterCheckWords(newSimilarWords, isArabicSimilarWord);
  }

  WordModel _getWordAfterCheckExample(
      List<String> newExamples, bool isArabicExample) {
    return WordModel(
      indexAtDatabase: indexAtDatabase,
      text: text,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicSimilarWords: arabicSimilarWords,
      englishSimilarWords: englishSimilarWords,
      arabicExamples: isArabicExample ? newExamples : arabicExamples,
      englishExamples: !isArabicExample ? newExamples : arabicExamples,
    );
  }

  List<String> _intinalizeNewExamples(bool isArabicExample) {
    if (isArabicExample) {
      return List.from(arabicExamples);
    }
    return List.from(englishExamples);
  }

  List<String> _intializeNewSimilarWord(bool isArabicSimilarWord) {
    if (isArabicSimilarWord) {
      return List.from(arabicSimilarWords);
    } else {
      return List.from(englishSimilarWords);
    }
  }

  WordModel _getWordAfterCheckWords(
      List<String> newSimilarWords, bool isArabicSimilarWord) {
    return WordModel(
      indexAtDatabase: indexAtDatabase,
      text: text,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicSimilarWords:
          isArabicSimilarWord ? newSimilarWords : arabicSimilarWords,
      englishSimilarWords:
          !isArabicSimilarWord ? newSimilarWords : englishSimilarWords,
      arabicExamples: arabicExamples,
      englishExamples: englishExamples,
    );
  }
}
