import 'package:flutter/cupertino.dart';
import 'package:my_recipes_win/model/step.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Ingredient {
  String name;
  Unit unit;
  double quantity;
  bool optional;
  int stepPosition = -1;

  Ingredient(this.name, this.unit, this.quantity, this.optional);
}

enum Unit {
  MILLILITER,
  LITER,
  UNIT,
  TEASPOON,
  TABLESPOON,
  GRAMME,
  KILOGRAMME,
  CUP,
  PINCH
}

extension Abreviation on Unit {
  abbreviation(BuildContext context) {
    switch (this) {
      case Unit.MILLILITER:
        return AppLocalizations.of(context).milliliter;
      case Unit.LITER:
        return AppLocalizations.of(context).liter;
      case Unit.UNIT:
        return AppLocalizations.of(context).unit;
      case Unit.TEASPOON:
        return AppLocalizations.of(context).teaspoon;
      case Unit.TABLESPOON:
        return AppLocalizations.of(context).tablespoon;
      case Unit.GRAMME:
        return AppLocalizations.of(context).gramme;
      case Unit.KILOGRAMME:
        return AppLocalizations.of(context).kilogramme;
      case Unit.CUP:
        return AppLocalizations.of(context).cup;
      case Unit.PINCH:
        return AppLocalizations.of(context).pinch;
    }
  }
}
