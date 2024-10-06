import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skin_sense/model/history.dart';
import 'package:skin_sense/view/screens/recommendation_screen.dart';

Widget buildHistoryCard(History history, BuildContext context) {
  return Card(
    margin: const EdgeInsets.only(top: 8),
    child: ListTile(
      onTap: () => _navigateToRecommendationScreen(context, history),
      title: Text(history.skinTypeName ?? 'N/A'),
      subtitle: Text(DateFormat('MMMM dd, yyyy hh:mm a')
          .format(history.dateTime ?? DateTime.now())),
    ),
  );
}

void _navigateToRecommendationScreen(BuildContext context, History history) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          RecommendationScreen(storedResult: history.skinTypeName),
    ),
  );
}
