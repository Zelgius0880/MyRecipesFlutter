import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_recipes_win/dialog/ingredient_dialog.dart';
import 'package:my_recipes_win/model/ingredient.dart';
import '../main.dart';

class IngredientWidget extends StatelessWidget {
  final Ingredient _ingredient;
  final int position;
  final OnItemRemoved _onItemRemoved;
  final OnItemUpdated _onItemUpdated;
  final OnItemMoved _onItemMoved;
  final bool last;

  IngredientWidget(this._ingredient, this.position, this.last,
      this._onItemRemoved, this._onItemUpdated, this._onItemMoved);

  @override
  Widget build(BuildContext context) {
    var children = [
      Text(
          '${_ingredient.quantity} ${_ingredient.unit.abbreviation(
              context)}   '),
      Expanded(flex: 1, child: Text(_ingredient.name)),
      IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            _onItemRemoved(position, this);
          })
    ];

    if (position != 1) {
      children.insert(2, IconButton(
          icon: Icon(Icons.arrow_upward_outlined),
          onPressed: () {
           _onItemMoved(position, position - 1);
          }));
    }


    if (!last) {
      children.insert(2, IconButton(
          icon: Icon(Icons.arrow_downward_outlined),
          onPressed: () {
            _onItemMoved(position, position + 1);
          }));
    }

    return Opacity(
      opacity: _ingredient.optional ? 0.5 : 1,
      child: Container(
        margin: EdgeInsets.only(left: 8, right: 8),
        child: Card(
          child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return IngredientDialog.withIngredient(_ingredient,
                              (ingredient) {
                            _onItemUpdated(position, ingredient);
                          });
                    });
              },
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: children,
                ),
              )),
        ),
      ),
    );
  }
}
