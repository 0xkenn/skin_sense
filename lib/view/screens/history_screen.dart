import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skin_sense/controller/history_controller.dart';
import 'package:skin_sense/model/history.dart';
import 'package:skin_sense/view/screens/recommendation_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final HistoryController controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromRGBO(223, 211, 195, 1),
          automaticallyImplyLeading: false,
          title: const Text(
            "History",
            style: TextStyle(fontWeight: FontWeight.w100),
          )),
      backgroundColor: const Color.fromRGBO(223, 211, 195, 1),
      body: GetBuilder<HistoryController>(
          builder: (cont) => ListView.builder(
              itemCount: cont.historyLength,
              itemBuilder: (context, index) {
                if (cont.historyLength > 0) {
                  int reverseIndex = cont.historyLength - 1 - index;
                  History? history = cont.observalbeBox.getAt(reverseIndex);
                  return Card(
                    margin: const EdgeInsets.only(top: 8),
                    child: ListTile(
                      onTap: () {
                        String? skint = history!.skinTypeName;

                        //String? skint = history?.skinTypeName;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecommendationScreen(
                                      storedResult: skint,
                                    )));
                      },
                      title: Text(history?.skinTypeName ?? 'N/A'),
                      subtitle: Text(DateFormat('MMMM dd, yyyy hh:mm a')
                          .format(history?.dateTime ?? DateTime.now())
                          .toString()),
                    ),
                  );
                }

                return const Center(
                  child: Text('No history Found!'),
                );
              })),
    );
  }
}
