import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_recipes_win/model/step.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef StepDialogCallback = void Function(RecipeStep);

class StepDialog extends StatefulWidget {
  final StepDialogCallback callback;
  RecipeStep initial;

  StepDialog(this.callback) {
    this.initial = null;
  }

  StepDialog.withStep(this.initial, this.callback);

  @override
  _StepDialog createState() => _StepDialog(initial, callback);
}

class _StepDialog extends State<StepDialog> {
  final StepDialogCallback callback;

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final controller = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controller.dispose();
    super.dispose();
  }

  RecipeStep initial;

  _StepDialog(this.initial, this.callback);

  @override
  Widget build(BuildContext context) {
    if (initial != null) controller.text = initial.text;

    return AlertDialog(
      title: Text(initial == null
          ? AppLocalizations.of(context).addStep
          : AppLocalizations.of(context).editStep),
      content: TextField(
        controller: controller,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: AppLocalizations.of(context).step,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
            this.callback(RecipeStep(controller.text));
          },
        )
      ],
    );
  }
}
