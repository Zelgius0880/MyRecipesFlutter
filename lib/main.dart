import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_recipes_win/dialog/step_dialog.dart';
import 'package:my_recipes_win/model/ingredient.dart';
import 'package:my_recipes_win/model/step.dart';
import 'package:my_recipes_win/recipe_type.dart';
import 'package:my_recipes_win/widget/ingredient_widget.dart';
import 'package:my_recipes_win/widget/step_widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'dialog/qr_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      // Add this line
      supportedLocales: AppLocalizations.supportedLocales,
      // Add this line,
      //localizationsDelegates: AppLocalizations.localizationsDelegates,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

typedef OnItemAdded = void Function(int position, dynamic item);
typedef OnItemRemoved = void Function(int position, Widget widget);
typedef OnItemUpdated = void Function(int position, dynamic item);
typedef OnItemMoved = void Function(int from, int to);

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> _list = [RecipeStep("---")];

  AutoScrollController _scrollController = AutoScrollController();

  TextEditingController nameController = TextEditingController();
  RecipeType dropdownValue = RecipeType.MEAL;

  /// Will used to access the Animated list
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  void moveItem(int from, int to) {
    var temp = _list[to];

    listKey.currentState.setState(() {
      _list[to] = _list[from];
      _list[from] = temp;
    });

    reassignPosition();
  }

  void reassignPosition() {
    var stepPosition = -1;
    for (int i = 1; i < _list.length; ++i) {
      var item = _list[i];
      if (item is Ingredient) {
        item.stepPosition = stepPosition;
      } else if (item is RecipeStep) {
        stepPosition = i;
      }
    }
  }

  void removeItem(int position, Widget widget) {
    setState(() {
      _list.removeAt(position);
      listKey.currentState.removeItem(
          position, (_, animation) => slideIt(context, widget, animation),
          duration: const Duration(milliseconds: 200));
    });

    reassignPosition();
  }

  void addItem(int position, dynamic item) {
    setState(() {
      _list.insert(position, item);
      listKey.currentState
          .insertItem(position, duration: const Duration(milliseconds: 200));

      if (item is Ingredient) {
        _scrollToIndex(max(0, item.stepPosition));
      } else {
        _scrollToIndex(position);
      }
    });
  }

  void updateItem(int position, dynamic item) {
    listKey.currentState.setState(() {
      _list[position] = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(AppLocalizations
            .of(context)
            .helloWorld),
        actions: [
          FlatButton(
              child: Row(children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.qr_code,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Text(
                    AppLocalizations
                        .of(context)
                        .generate
                        .toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ]),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return QrDialog(
                          nameController.text, dropdownValue, _list);
                    });
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min,
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: AppLocalizations
                              .of(context)
                              .name,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: DropdownButton<RecipeType>(
                        value: dropdownValue,
                        icon: Icon(Icons.keyboard_arrow_down),
                        iconSize: 24,
                        elevation: 16,
                        isExpanded: true,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (RecipeType newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: RecipeType.values
                            .map<DropdownMenuItem<RecipeType>>(
                                (RecipeType value) {
                              return DropdownMenuItem<RecipeType>(
                                value: value,
                                child: Text(value.abbreviation(context)),
                              );
                            }).toList(),
                      ),
                    ),
                  )
                ],
              ),
              AnimatedList(
                controller: _scrollController,
                key: listKey,
                shrinkWrap: true,
                initialItemCount: _list.length,
                itemBuilder: (context, position, animation) {
                  return AutoScrollTag(
                      key: ValueKey(position),
                      controller: _scrollController,
                      index: position,
                      child: slideIt(
                          context,
                          (_list[position] is Ingredient)
                              ? IngredientWidget(
                              _list[position],
                              position,
                              position == _list.length -1,
                              removeItem,
                              updateItem,
                              moveItem)
                              : StepWidget(
                              _list[position],
                              position,
                              position == _list.length - 1,
                              removeItem,
                              updateItem,
                              addItem,
                              moveItem),
                          animation));
                },
              ),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
        {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return StepDialog((step) {
                  addItem(_list.length, step);
                });
              })
        },
        tooltip: AppLocalizations
            .of(context)
            .addStep,
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget slideIt(BuildContext context, Widget widget, animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(animation),
      child: widget,
    );
  }

  Future _scrollToIndex(int index) async {
    await _scrollController.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
  }
}
