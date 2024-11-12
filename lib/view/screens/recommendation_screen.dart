import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skin_sense/controller/history_controller.dart';
import 'package:skin_sense/controller/get_index_controller.dart';
import 'package:skin_sense/model/data.dart';
// import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';

List<String> names = <String>[
  "Do's",
  "Dont's",
  'Day \nIngredients',
  'Night Ingredients', // Fourth tab
];

class RecommendationScreen extends StatefulWidget {
  final String? storedResult;
  const RecommendationScreen({super.key, required this.storedResult});

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  var controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    var predictedSkinType;

    if (widget.storedResult == "NULL") {
      predictedSkinType = controller.observalbeBox
          .getAt(controller.historyLength - 1)
          ?.skinTypeName;
    } else {
      predictedSkinType = widget.storedResult;
    }

    const colorScheme = Color.fromRGBO(248, 237, 227, 1);
    const Color oddItemColor = Color.fromRGBO(208, 184, 168, 0.70);
    const Color evenItemColor = Color.fromRGBO(248, 237, 227, 1);
    const int tabsCount = 4; // Updated tab count to 4
    final skinIndex = skinTypeInfo[getIndex(predictedSkinType)];

    if (controller.historyLength < 0) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(248, 237, 221, 1),
          title: Text("Skin Type $predictedSkinType"),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.popAndPushNamed(context, "/home");
                  dispose();
                },
              ),
            ),
          ],
        ),
        backgroundColor: colorScheme,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Oops! No Recommendation found, Please Scan your face to provide recommendations",
                  style: GoogleFonts.salsa(
                      fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/camera');
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Camera",
                        style: GoogleFonts.salsa(
                            fontSize: 15, color: Colors.black),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.camera_alt_rounded,
                        size: 20.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return PopScope(
      canPop: true,
      child: DefaultTabController(
        initialIndex: 1,
        length: tabsCount,
        child: Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                    icon: const Icon(Icons.home),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, "/home");
                      dispose();
                    },
                  ),
                ),
              ],
              backgroundColor: const Color.fromRGBO(248, 237, 227, 1),
              notificationPredicate: (ScrollNotification notification) {
                return notification.depth == 1;
              },
              scrolledUnderElevation: 4.0,
              shadowColor: Theme.of(context).shadowColor,
              bottom: TabBar(
                indicatorColor: const Color.fromRGBO(197, 112, 92, 1),
                labelColor: const Color.fromRGBO(197, 112, 92, 1),
                tabs: <Widget>[
                  Tab(
                    icon: const Icon(Icons.check),
                    text: names[0],
                  ),
                  Tab(
                    icon: const Icon(Icons.do_not_disturb_alt_rounded),
                    text: names[1],
                  ),
                  Tab(
                    icon: const Icon(Icons.sunny),
                    child: Text(
                      names[2],
                      textAlign:
                          TextAlign.center, // To center the text across lines
                      style: const TextStyle(
                          fontSize: 12), // Adjust the font size if needed
                    ),
                  ),
                  Tab(
                    icon: const Icon(
                        Icons.nightlight_round), // New icon for 4th tab
                    child: Text(
                      names[3],
                      textAlign:
                          TextAlign.center, // To center the text across lines
                      style: const TextStyle(
                          fontSize: 12), // Adjust the font size if needed
                    ), // Fourth tab name
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                // Do's Tab
                Container(
                  color: Colors.white70,
                  child: ListView.builder(
                    itemCount: skinIndex.dos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        tileColor: index.isOdd ? oddItemColor : evenItemColor,
                        title: Text(skinIndex.dos[index]),
                      );
                    },
                  ),
                ),
                // Don'ts Tab
                Container(
                  color: Colors.white70,
                  child: ListView.builder(
                    itemCount: skinIndex.donts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        tileColor: index.isOdd ? oddItemColor : evenItemColor,
                        title: Text(skinIndex.donts[index]),
                      );
                    },
                  ),
                ),
                // Day Ingredients Tab (with text wrapping)
                Container(
                  color: Colors.white70,
                  child: ListView.builder(
                    itemCount: skinIndex.dayIngredients.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        tileColor: index.isOdd ? oddItemColor : evenItemColor,
                        title: Text(
                          skinIndex.dayIngredients[index],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          softWrap:
                              true, // Allows text to wrap onto the next line
                        ),
                      );
                    },
                  ),
                ),
                // Night Ingredients Tab (with text wrapping)
                Container(
                  color: Colors.white70,
                  child: ListView.builder(
                    itemCount: skinIndex.nightIngredients.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        tileColor: index.isOdd ? oddItemColor : evenItemColor,
                        title: Text(
                          skinIndex.nightIngredients[index],
                          style: const TextStyle(
                            fontSize: 16,
                          ),

                          softWrap:
                              true, // Allows text to wrap onto the next line
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
