import 'package:create_tag_getx_sample/tag_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

var suggestTag = [
  "Pizza",
  "Pasta",
  "Spagetti",
  "Beefsteak",
  "Drink",
  "Cocacola",
  "Fanta",
  "Pepsi",
  "Hambuger",
  "Ok"
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final controller = Get.put(TagStateController());
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                    controller: textController,
                    onEditingComplete: () {
                      controller.listTags.add(textController.text);
                      textController.clear();
                    },
                    autofocus: false,
                    style: DefaultTextStyle.of(context)
                        .style
                        .copyWith(fontStyle: FontStyle.italic, fontSize: 20),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Tag')),
                suggestionsCallback: (String pattern) {
                  return suggestTag.where(
                      (e) => e.toLowerCase().contains(pattern.toLowerCase()));
                },
                onSuggestionSelected: (String suggestion) =>
                    controller.listTags.add(suggestion),
                itemBuilder: (BuildContext context, String itemData) {
                  return ListTile(
                    leading: Icon(Icons.tag),
                    title: Text(itemData),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(() => controller.listTags.length == 0
                ? Center(
                    child: Text('No Tag　Selected'),
                  )
                : Wrap(
                    children: controller.listTags
                        .map((element) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Chip(
                                label: Text(element),
                                deleteIcon: Icon(Icons.clear),
                                onDeleted: () => controller.listTags.remove(element),
                              ),
                        ))
                        .toList(),
                  ))
          ],
        ),
      ),
    );
  }
}
