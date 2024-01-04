import 'package:flutter/material.dart';
import 'package:hive_news/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:hive_news/view/styles/color_manger.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({super.key, required this.text, required this.formKey});
  final String text;
  final GlobalKey<FormState> formKey;

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: TextFormField(
            autofocus: true,
            controller: textEditingController,
            maxLines: 2,
            minLines: 1,
            cursorColor: ColorManger.white,
            decoration: getInputDecoration(),
            onChanged: (value) => WriteDataCubit.get(context).updateText(value),
            validator: (value) {
              return _validator(value, WriteDataCubit.get(context).isArabic);
            }));
  }

  String? _validator(String? value, bool isArabic) {
    if (value == null || value.trim().length == 0) {
      return 'Please Enter Text';
    }
    for (var i = 0; i < value.length; i++) {
      CharType charType = _getCharType(value.codeUnitAt(i));
      if (charType == CharType.notVaild) {
        return 'Please Enter Vaild Text ${i + 1} not valid';
      } else if (charType == CharType.arabic && isArabic == false) {
        return 'Please Enter Vaild Text ${i + 1} not english';
      } else if (charType == CharType.english && isArabic == true) {
        return 'Please Enter Vaild Text ${i + 1} not arabic';
      }
    }
  }

  CharType _getCharType(int asciicode) {
    if ((asciicode >= 65 && asciicode <= 90) ||
        (asciicode >= 97 && asciicode <= 122)) {
      return CharType.english;
    } else if (asciicode >= 1569 && asciicode <= 1610) {
      return CharType.arabic;
    } else if (asciicode == 32) {
      return CharType.space;
    }
    return CharType.notVaild;
  }

  InputDecoration getInputDecoration() {
    return InputDecoration(
        label: Text(widget.text, style: TextStyle(color: ColorManger.white)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: ColorManger.white, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: ColorManger.white, width: 2)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: ColorManger.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: ColorManger.red, width: 2)));
  }
}

enum CharType {
  arabic,
  english,
  space,
  notVaild,
}
