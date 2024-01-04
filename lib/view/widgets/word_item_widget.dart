import 'package:flutter/material.dart';
import 'package:hive_news/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:hive_news/model/word_model.dart';
import 'package:hive_news/view/screen/word_details_screen.dart';
import 'package:hive_news/view/styles/color_manger.dart';

class WordItemWidget extends StatelessWidget {
  const WordItemWidget({super.key, required this.wordModel});
  final WordModel wordModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WordDetailsScreen(
                      wordModel: wordModel,
                    ))).then((value) async {
          Future.delayed(const Duration(seconds: 1)).then((value) {
            ReadDataCubit.get(context).getWords();
          });
        });
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: getBoxDecoration(),
        child: Center(
            child: Text(wordModel.text,
                style: const TextStyle(
                  color: ColorManger.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ))),
      ),
    );
  }

  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color(wordModel.colorCode),
    );
  }
}
