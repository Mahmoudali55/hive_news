import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_news/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:hive_news/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:hive_news/controllers/write_data_cubit/write_data_state_cubic.dart';
import 'package:hive_news/view/styles/color_manger.dart';
import 'package:hive_news/view/widgets/arabic_or_english.dart';
import 'package:hive_news/view/widgets/color_widgets.dart';
import 'package:hive_news/view/widgets/custom_form.dart';
import 'package:hive_news/view/widgets/done_button.dart';

class AddWordDialog extends StatefulWidget {
  const AddWordDialog({super.key});

  @override
  State<AddWordDialog> createState() => _AddWordDialogState();
}

class _AddWordDialogState extends State<AddWordDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: BlocConsumer<WriteDataCubit, WriteDateCubitStates>(
            listener: (context, state) {
      if (state is WriteDateCubitSuccessState) {
        Navigator.pop(context);
      }
      if (state is WriteDateCubitFailedState) {
        ScaffoldMessenger.of(context).showSnackBar(getSnackbar(state.message));
      }
    }, builder: (context, state) {
      return AnimatedContainer(
        padding: EdgeInsets.all(15),
        duration: const Duration(milliseconds: 750),
        color: Color(WriteDataCubit.get(context).colorCode),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ArabicAndEnglishWidget(
                arabicIsSelected: WriteDataCubit.get(context).isArabic,
                colorCode: WriteDataCubit.get(context).colorCode),
            const SizedBox(
              height: 10,
            ),
            ColorWidget(activeColor: WriteDataCubit.get(context).colorCode),
            const SizedBox(
              height: 10,
            ),
            CustomForm(text: 'New Word', formKey: formKey),
            SizedBox(
              height: 10,
            ),
            DoneButton(
                colorCode: WriteDataCubit.get(context).colorCode,
                ontap: () {
                  if (formKey.currentState!.validate()) {
                    WriteDataCubit.get(context).addWord();
                    ReadDataCubit.get(context).getWords();
                  }
                }),
          ],
        ),
      );
    }));
  }

  SnackBar getSnackbar(String message) => SnackBar(
        content: Text(message),
        backgroundColor: ColorManger.red,
      );
}
