import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skin_sense/controller/history_controller.dart';
import 'package:skin_sense/helper/get_index.dart';
import 'package:skin_sense/model/data.dart';

List<String> names = <String>[
  "Do's",
  "Dont's'",
  'Ingredients',
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
    // ignore: prefer_typing_uninitialized_variables
    var predictedSkinType;

    if (widget.storedResult == "NULL") {
      predictedSkinType = controller.observalbeBox
          .getAt(controller.historyLength - 1)
          ?.skinTypeName;
    } else {
      predictedSkinType = widget.storedResult;
    }

    const colorScheme = Color.fromRGBO(248, 237, 2277, 1);
    const Color oddItemColor = Color.fromRGBO(208, 184, 168, 0.70);
    const Color evenItemColor = Color.fromRGBO(248, 237, 2277, 1);
    const int tabsCount = 3;
    final skinIndex = skinTypeInfo[getIndex(predictedSkinType)];

    if (controller.historyLength < 0) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(248, 237, 221, 1),
          title: Text("Skin Type $predictedSkinType"),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  right: 20), // Adjust the right margin as needed
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
                      horizontal: 20, vertical: 12), // Adjust padding if needed
                  textStyle: const TextStyle(
                      fontSize: 14), // Adjust font size if needed
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/camera');
                },
                child: Row(
                  mainAxisSize: MainAxisSize
                      .min, // Ensures the row is as small as possible
                  children: [
                    Text(
                      "Camera",
                      style: GoogleFonts.salsa(
                          fontSize: 15,
                          color: Colors.black), // Styling for text
                    ),
                    const SizedBox(width: 8), // Space between text and icon
                    const Icon(
                      Icons.camera_alt_rounded, // Icon to display
                      size: 20.0, // Size of the icon
                      color: Colors.black, // Color of the icon
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
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
                  padding: const EdgeInsets.only(
                      right: 20), // Adjust the right margin as needed
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
                    icon: const Icon(Icons.assignment),
                    text: names[2],
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Container(
                  color: Colors.white70,
                  child: ListView.builder(
                    itemCount:
                        skinTypeInfo[getIndex(predictedSkinType)].dos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        tileColor: index.isOdd ? oddItemColor : evenItemColor,
                        title: Text(skinIndex.dos[index]),
                      );
                    },
                  ),
                ),
                Container(
                  color: Colors.white70,
                  child: ListView.builder(
                    itemCount:
                        skinTypeInfo[getIndex(predictedSkinType)].donts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          tileColor: index.isOdd ? oddItemColor : evenItemColor,
                          title: Text(
                            skinIndex.donts[index],
                          ));
                    },
                  ),
                ),
                Container(
                  color: Colors.white70,
                  child: ListView.builder(
                    itemCount: skinTypeInfo[getIndex(predictedSkinType)]
                        .dayIngredients
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          tileColor: index.isOdd ? oddItemColor : evenItemColor,
                          title: Text(
                            skinIndex.dayIngredients[index],
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
