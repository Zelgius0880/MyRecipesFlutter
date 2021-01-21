import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_recipes_win/model/ingredient.dart';
import 'package:my_recipes_win/model/step.dart';
import 'package:my_recipes_win/proto/recipe.pb.dart' as Proto;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../recipe_type.dart';

class QrDialog extends StatefulWidget {
  final List<dynamic> _list;
  final RecipeType type;
  final String name;

  QrDialog(this.name, this.type, this._list);

  @override
  _QrDialog createState() => _QrDialog(this.name, this.type, this._list);
}

class _QrDialog extends State<QrDialog> {
  final List<dynamic> _list;
  final RecipeType type;
  final String name;

  _QrDialog(this.name, this.type, this._list);

  @override
  Widget build(BuildContext context) {
    Proto.Recipe_Type t;
    switch (type) {
      case RecipeType.MEAL:
        t = Proto.Recipe_Type.MEAL;
        break;
      case RecipeType.DESSERT:
        t = Proto.Recipe_Type.DESSERT;
        break;
      case RecipeType.OTHER:
        t = Proto.Recipe_Type.OTHER;
        break;
    }

    var listStep = _list.sublist(1).where((element) => element is RecipeStep);

    var listIngredients = _list
        .sublist(1)
        .where((element) => element is Ingredient)
        .map((e) => e as Ingredient)
        .toList();

    var mapStep = Map<RecipeStep, Proto.Step>();
    listStep.map((e) => e as RecipeStep).toList().asMap().forEach((index, e) {
      mapStep[e] = e.map(index + 1);
    });

    List<Proto.Ingredient> ingredients = [];

    listIngredients
        .where((element) => element.stepPosition == -1)
        .toList()
        .asMap()
        .forEach((index, element) {
      ingredients.add(element.map(index));
    });

    mapStep.forEach((step, protoStep) {
      listIngredients
          .where((i) => i.stepPosition == _list.indexOf(step))
          .toList()
          .asMap()
          .forEach((index, ingredient) {
        ingredients.add(ingredient.map(index, step: protoStep));
      });
    });

    var recipe = Proto.Recipe(
        name: this.name, type: t, ingredients: ingredients, steps: mapStep.values);
    var bytes = recipe.writeToBuffer();

    var archive = Archive();
    archive.addFile(ArchiveFile("", bytes.length, bytes));
    var compressed = ZipEncoder().encode(archive);
    var base64 = Base64Encoder().convert(compressed);

    return AlertDialog(
      title: Text(AppLocalizations.of(context).qrCode),
      content: Container(
          height: 350,
          width: 350,
          child: QrImage(
            data: base64,
            version: QrVersions.auto,
            size: 200.0,
          )),
      actions: <Widget>[
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}

extension ProtoUnit on Unit {
  get proto {
    switch (this) {
      case Unit.MILLILITER:
        return Proto.Ingredient_Unit.MILLILITER;
      case Unit.LITER:
        return Proto.Ingredient_Unit.LITER;
      case Unit.UNIT:
        return Proto.Ingredient_Unit.UNIT;
      case Unit.TEASPOON:
        return Proto.Ingredient_Unit.TEASPOON;
      case Unit.TABLESPOON:
        return Proto.Ingredient_Unit.TABLESPOON;
      case Unit.GRAMME:
        return Proto.Ingredient_Unit.GRAMME;
      case Unit.KILOGRAMME:
        return Proto.Ingredient_Unit.KILOGRAMME;
      case Unit.CUP:
        return Proto.Ingredient_Unit.CUP;
      case Unit.PINCH:
        return Proto.Ingredient_Unit.PINCH;
    }
  }
}

extension ProtoStep on RecipeStep {
  Proto.Step map(int order) {
    return Proto.Step(name: this.text, order: order);
  }
}

extension ProtoIngredient on Ingredient {
  Proto.Ingredient map(int order, {Proto.Step step}) {
    return Proto.Ingredient(
        name: name,
        quantity: quantity,
        unit: unit.proto,
        sortOrder: order,
        step: step,
        isOptional: optional);
  }
}
