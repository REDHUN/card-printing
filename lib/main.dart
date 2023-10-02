import 'package:cardprinting/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var KcolorScheme = ColorScheme.fromSeed(
  // brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 12, 19, 65),
);
final theme = ThemeData(
    useMaterial3: true,
    colorScheme: KcolorScheme,
    textTheme: GoogleFonts.latoTextTheme(),
    elevatedButtonTheme:
        ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
    cardTheme: CardTheme(color: KcolorScheme.secondaryContainer));
void main(List<String> args) {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Card'),
              backgroundColor: Theme.of(context).copyWith().primaryColorDark,
            ),
            body: const HomePage()));
  }
}
