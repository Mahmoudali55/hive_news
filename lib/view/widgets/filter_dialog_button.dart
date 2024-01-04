import 'package:flutter/material.dart';
import 'package:hive_news/view/styles/color_manger.dart';
import 'package:hive_news/view/widgets/filter_dialog.dart';

class FilterDialogButton extends StatelessWidget {
  const FilterDialogButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const FilterDialog(),
        );
      },
      child: const CircleAvatar(
        radius: 15,
        backgroundColor: ColorManger.white,
        child: Icon(Icons.filter_list, color: ColorManger.black),
      ),
    );
  }
}
