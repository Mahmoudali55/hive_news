import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_news/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:hive_news/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:hive_news/hive_constants.dart';
import 'package:hive_news/model/word_type_adapter.dart';
import 'package:hive_news/view/screen/home_screen.dart';
import 'package:hive_news/view/styles/them_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(wordTypeAdapter());
  await Hive.openBox(HiveConatants.wordsBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WriteDataCubit()),
        BlocProvider(
          create: (context) => ReadDataCubit()..getWords(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeManager.getTheme(),
        home: const HomeScreen(),
      ),
    );
  }
}
