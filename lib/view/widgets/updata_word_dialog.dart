import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_news/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:hive_news/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:hive_news/controllers/write_data_cubit/write_data_state_cubic.dart';
import 'package:hive_news/view/widgets/arabic_or_english.dart';
import 'package:hive_news/view/widgets/custom_form.dart';
import 'package:hive_news/view/widgets/done_button.dart';

class UpdataWordDialog extends StatefulWidget {
  const UpdataWordDialog(
      {super.key,
      required this.isExample,
      required this.colorCode,
      required this.indexAtDatabase});
  final bool isExample;
  final int colorCode;
  final int indexAtDatabase;

  @override
  State<UpdataWordDialog> createState() => _UpdataWordDialogState();
}

class _UpdataWordDialogState extends State<UpdataWordDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Color(widget.colorCode),
        child: BlocConsumer<WriteDataCubit, WriteDateCubitStates>(
            listener: (context, state) {
          if (state is WriteDateCubitSuccessState) {
            Navigator.pop(context);
          }
          if (state is WriteDateCubitFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(getSnackBar(state));
          }
        }, builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ArabicAndEnglishWidget(
                    colorCode: widget.colorCode,
                    arabicIsSelected: WriteDataCubit.get(context).isArabic),
                SizedBox(
                  height: 20,
                ),
                CustomForm(
                    text: widget.isExample ? 'New Example' : 'New Similar Word',
                    formKey: _formKey),
                SizedBox(
                  height: 20,
                ),
                DoneButton(
                    colorCode: widget.colorCode,
                    ontap: () {
                      if (_formKey.currentState!.validate()) {
                        if (widget.isExample) {
                          WriteDataCubit.get(context)
                              .addExampleWord(widget.indexAtDatabase);
                        } else {
                          WriteDataCubit.get(context)
                              .addSimimarWord(widget.indexAtDatabase);
                        }
                        ReadDataCubit.get(context).getWords();
                      }
                    })
              ],
            ),
          );
        }));
  }

  SnackBar getSnackBar(WriteDateCubitFailedState state) =>
      SnackBar(backgroundColor: Colors.red, content: Text(state.message));
}
