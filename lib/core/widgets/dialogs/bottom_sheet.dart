import 'package:flutter/material.dart';

class BottomSheetWidget {
  static final BottomSheetWidget _instance = BottomSheetWidget._internal();

  factory BottomSheetWidget() {
    return _instance;
  }

  BottomSheetWidget._internal();

  void showBottomSheet({
    required BuildContext context,
    required String status,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(status),
              ),
            ],
          ),
        );
      },
    );
  }
}
