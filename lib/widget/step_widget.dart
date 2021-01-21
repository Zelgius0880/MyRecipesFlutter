import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_recipes_win/dialog/ingredient_dialog.dart';
import 'package:my_recipes_win/dialog/step_dialog.dart';
import 'package:my_recipes_win/main.dart';
import 'package:my_recipes_win/model/step.dart';

class StepWidget extends StatelessWidget {
  final RecipeStep _step;
  final int position;
  final OnItemRemoved _onItemRemoved;
  final OnItemUpdated _onItemUpdated;
  final OnItemAdded _onItemAdded;
  final OnItemMoved _onItemMoved;
  final bool last;

  StepWidget(this._step, this.position, this.last, this._onItemRemoved,
      this._onItemUpdated, this._onItemAdded, this._onItemMoved);

  @override
  Widget build(BuildContext context) {
    var children = [
      Expanded(child: Text(_step.text), flex: 1),
      IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return IngredientDialog((ingredient) {
                    if (position != 0) {
                      ingredient.stepPosition = position; // removing the header
                    }
                    _onItemAdded(position + 1, ingredient);
                  });
                });
          })
    ];


    if (position > 1) {
      children.insert(1, IconButton(
          icon: Icon(Icons.arrow_upward_outlined),
          onPressed: () {
            _onItemMoved(position, position - 1);
          }));
    }


    if (!last && position != 0) {
      children.insert(1, IconButton(
          icon: Icon(Icons.arrow_downward_outlined),
          onPressed: () {
            _onItemMoved(position, position + 1);
          }));
    }


    if (position != 0) {
      children.insert(
          1,
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _onItemRemoved(position, this);
              }));
    }

    return Card(
        color: position == 0 ? Colors.white : Colors.white30.withOpacity(0.50),
        child: position != 0
            ? InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StepDialog.withStep(_step, (step) {
                          _onItemUpdated(position, step);
                        });
                      });
                },
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(children: children),
                ))
            : Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(children: children),
              ));
  }
}
