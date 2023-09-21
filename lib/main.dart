import 'package:flutter/material.dart';
import 'package:stackoverflow_answers/src/show_bottom_sheet_view/show_modal_bottom_sheet_with_scaffold_view.dart';

void main() {
  runApp(const MainAppWidget());
}

final class MainAppWidget extends StatelessWidget {
  const MainAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.deepOrange),
      home: const ShowModalBottomSheetWithScaffoldView(),
    );
  }
}
