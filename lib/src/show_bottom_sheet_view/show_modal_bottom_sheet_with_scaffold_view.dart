// ignore_for_file: unused_element

import 'package:flutter/material.dart';

final class ShowModalBottomSheetWithScaffoldView extends StatefulWidget {
  const ShowModalBottomSheetWithScaffoldView({super.key});

  @override
  State<ShowModalBottomSheetWithScaffoldView> createState() => _ShowModalBottomSheetWithScaffoldViewState();
}

class _ShowModalBottomSheetWithScaffoldViewState extends State<ShowModalBottomSheetWithScaffoldView> {
  late final DraggableScrollableController _draggableScrollableController;

  @override
  void initState() {
    _draggableScrollableController = DraggableScrollableController();
    super.initState();
  }

  @override
  void dispose() {
    _draggableScrollableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
      child: Scaffold(
        bottomNavigationBar: _BottomNavBar(draggableScrollableController: _draggableScrollableController),
        bottomSheet: _BottomSheetWidget(draggableScrollableController: _draggableScrollableController),
        body: Column(
          children: [
            Expanded(
                child: Container(
              color: Colors.black,
            ))
          ],
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final DraggableScrollableController draggableScrollableController;
  const _BottomNavBar({
    super.key,
    required this.draggableScrollableController,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: _BottomButton(
                    text: "Close Sheet",
                    onPressed: () {
                      draggableScrollableController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.fastLinearToSlowEaseIn);
                    },
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _BottomButton(
                    text: "Open Sheet",
                    onPressed: () {
                      draggableScrollableController.animateTo(1, duration: const Duration(milliseconds: 300), curve: Curves.fastLinearToSlowEaseIn);
                    },
                    textColor: Colors.white,
                  ),
                ),
              ],
            )
          ]),
        ));
  }
}

class _BottomButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Color color;
  final Color textColor;

  const _BottomButton({required this.text, required this.onPressed, this.color = Colors.deepOrange, this.textColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: const BorderSide(color: Colors.grey)),
          maximumSize: const Size(double.maxFinite, kMinInteractiveDimension * .9),
          fixedSize: const Size(double.maxFinite, kMinInteractiveDimension * .9),
          minimumSize: const Size(double.maxFinite, kMinInteractiveDimension * .9),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ));
  }
}

class _BottomSheetWidget extends StatelessWidget {
  final DraggableScrollableController draggableScrollableController;
  const _BottomSheetWidget({super.key, required this.draggableScrollableController});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(12)), color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(margin: const EdgeInsets.symmetric(vertical: 4), width: 32, height: 4, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8))),
          Flexible(
            child: DraggableScrollableSheet(
              controller: draggableScrollableController,
              expand: false,
              initialChildSize: .0,
              maxChildSize: .6,
              minChildSize: .0,
              builder: (context, scrollController) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(child: ListView.builder(itemBuilder: (context, index) => ListTile(title: Text("Item $index")), controller: scrollController, itemCount: 100)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
