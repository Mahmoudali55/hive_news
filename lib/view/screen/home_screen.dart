// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_news/view/styles/color_manger.dart';
import 'package:hive_news/view/widgets/add_word_dialage.dart';
import 'package:hive_news/view/widgets/color_widgets.dart';
import 'package:hive_news/view/widgets/filter_dialog_button.dart';
import 'package:hive_news/view/widgets/language_filter_widget.dart';
import 'package:hive_news/view/widgets/words_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _getFloatingActionButton(context),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(children: [
              LanguageFilterWidget(),
              Spacer(),
              FilterDialogButton()
            ]),
            SizedBox(
              height: 10,
            ),
            Expanded(child: WordsWidget()),
          ],
        ),
      ),
    );
  }

  FloatingActionButton _getFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: ColorManger.white,
      onPressed: () => showDialog(
          context: context, builder: (context) => const AddWordDialog()),
      child: const Icon(Icons.add, color: ColorManger.black),
    );
  }
}
