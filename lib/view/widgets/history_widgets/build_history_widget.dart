import 'package:flutter/material.dart';
import 'package:skin_sense/controller/history_controller.dart';
import 'package:skin_sense/model/history.dart';
import 'package:skin_sense/view/widgets/history_widgets/history_card_widget.dart';

Widget buildHistoryList(HistoryController controller) {
  return ListView.builder(
    itemCount: controller.historyLength,
    itemBuilder: (context, index) {
      int reverseIndex = controller.historyLength - 1 - index;
      History? history = controller.observalbeBox.getAt(reverseIndex);

      if (history != null) {
        return buildHistoryCard(history, context);
      } else {
        return const SizedBox
            .shrink(); // Return an empty widget if history is null
      }
    },
  );
}
