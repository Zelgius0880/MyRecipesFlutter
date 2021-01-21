
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum RecipeType {
  MEAL,
  DESSERT,
  OTHER,
}

extension Abreviation on RecipeType {
  abbreviation(BuildContext context) {
    switch (this) {
      case RecipeType.MEAL:
        return AppLocalizations.of(context).meal;
      case RecipeType.DESSERT:
        return AppLocalizations.of(context).dessert;
      case RecipeType.OTHER:
        return AppLocalizations.of(context).other;
    }
  }
}
