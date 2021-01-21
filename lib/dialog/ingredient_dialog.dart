import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_recipes_win/model/ingredient.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef IngredientCallback = void Function(Ingredient);

class IngredientDialog extends StatefulWidget {
  final IngredientCallback callback;
  Ingredient initial;

  IngredientDialog(this.callback) {
    initial = null;
  }

  IngredientDialog.withIngredient(this.initial, this.callback);

  @override
  _IngredientDialog createState() => _IngredientDialog(initial, callback);
}

class _IngredientDialog extends State<IngredientDialog> {
  final IngredientCallback callback;

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Unit dropdownValue = Unit.GRAMME;
  bool optional = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  Ingredient initial;

  _IngredientDialog(this.initial, this.callback);

  @override
  void initState() {
    super.initState();
    if (initial != null) {
      dropdownValue = initial.unit;
      optional = initial.optional;
      nameController.text = initial.name;
      quantityController.text = "${initial.quantity}";
    }
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text(initial == null
          ? AppLocalizations
          .of(context)
          .addIngredient
          : AppLocalizations
          .of(context)
          .editIngredient),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: AppLocalizations
                      .of(context)
                      .ingredient,
                ),
                validator: (value) {
                  return value.isNotEmpty
                      ? null
                      : AppLocalizations
                      .of(context)
                      .fieldRequired;
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: quantityController,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: false, decimal: true),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: AppLocalizations
                            .of(context)
                            .quantity,
                      ),
                      validator: (value) {
                        return isNumeric(value) && double.parse(value) >= 0
                            ? null
                            : AppLocalizations
                            .of(context)
                            .notANumber;
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: DropdownButton<Unit>(
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
                      onChanged: (Unit newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items:
                      Unit.values.map<DropdownMenuItem<Unit>>((Unit value) {
                        return DropdownMenuItem<Unit>(
                          value: value,
                          child: Text(value.abbreviation(context)),
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),

            Row(
                children: [
                  Expanded(
                      flex: 1,
                      child:
                      Text(AppLocalizations.of(context).optional,  textAlign: TextAlign.right,)
                  ),

                  Checkbox(value: optional, onChanged: (value) {
                    setState(() {
                      optional = value;
                    });
                  }),
                ]
            )
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Navigator.pop(context);
              callback(Ingredient(nameController.value.text, dropdownValue,
                  double.parse(quantityController.value.text),optional));
            }
          },
        )
      ],
    );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
