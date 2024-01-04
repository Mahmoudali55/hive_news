import 'package:flutter/material.dart';
import 'package:hive_news/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:hive_news/view/styles/color_manger.dart';

class ArabicAndEnglishWidget extends StatelessWidget {
  const ArabicAndEnglishWidget(
      {super.key, required this.colorCode, required this.arabicIsSelected});
  final int colorCode;
  final bool arabicIsSelected;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      getContainerDesign(true, context),
      const SizedBox(
        width: 5,
      ),
      getContainerDesign(false, context),
    ]);
  }

  InkWell getContainerDesign(bool buildIsArabic, BuildContext context) {
    return InkWell(
      onTap: () => WriteDataCubit.get(context).updateIsAribic(buildIsArabic),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ColorManger.white, width: 2),
          color: buildIsArabic == arabicIsSelected
              ? ColorManger.white
              : Color(colorCode),
        ),
        child: Center(
          child: Text(
            buildIsArabic ? 'ar' : 'en',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: !(buildIsArabic == arabicIsSelected)
                  ? ColorManger.white
                  : Color(colorCode),
            ),
          ),
        ),
      ),
    );
  }
}
