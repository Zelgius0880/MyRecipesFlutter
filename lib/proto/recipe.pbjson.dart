///
//  Generated code. Do not modify.
//  source: recipe.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const Recipe$json = const {
  '1': 'Recipe',
  '2': const [
    const {'1': 'name', '3': 1, '4': 2, '5': 9, '10': 'name'},
    const {'1': 'imageUrl', '3': 2, '4': 1, '5': 9, '10': 'imageUrl'},
    const {'1': 'type', '3': 3, '4': 2, '5': 14, '6': '.tutorial.Recipe.Type', '10': 'type'},
    const {'1': 'steps', '3': 4, '4': 3, '5': 11, '6': '.tutorial.Step', '10': 'steps'},
    const {'1': 'ingredients', '3': 5, '4': 3, '5': 11, '6': '.tutorial.Ingredient', '10': 'ingredients'},
  ],
  '4': const [Recipe_Type$json],
};

const Recipe_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'DESSERT', '2': 0},
    const {'1': 'MEAL', '2': 1},
    const {'1': 'OTHER', '2': 2},
  ],
};

const Step$json = const {
  '1': 'Step',
  '2': const [
    const {'1': 'name', '3': 1, '4': 2, '5': 9, '10': 'name'},
    const {'1': 'order', '3': 2, '4': 2, '5': 5, '10': 'order'},
  ],
};

const Ingredient$json = const {
  '1': 'Ingredient',
  '2': const [
    const {'1': 'quantity', '3': 1, '4': 2, '5': 1, '10': 'quantity'},
    const {'1': 'name', '3': 2, '4': 2, '5': 9, '10': 'name'},
    const {'1': 'imageUrl', '3': 3, '4': 1, '5': 9, '10': 'imageUrl'},
    const {'1': 'sortOrder', '3': 4, '4': 2, '5': 5, '10': 'sortOrder'},
    const {'1': 'step', '3': 5, '4': 1, '5': 11, '6': '.tutorial.Step', '10': 'step'},
    const {'1': 'unit', '3': 6, '4': 2, '5': 14, '6': '.tutorial.Ingredient.Unit', '10': 'unit'},
    const {'1': 'isOptional', '3': 7, '4': 1, '5': 8, '10': 'isOptional'},
  ],
  '4': const [Ingredient_Unit$json],
};

const Ingredient_Unit$json = const {
  '1': 'Unit',
  '2': const [
    const {'1': 'MILLILITER', '2': 1},
    const {'1': 'LITER', '2': 2},
    const {'1': 'UNIT', '2': 3},
    const {'1': 'TEASPOON', '2': 4},
    const {'1': 'TABLESPOON', '2': 5},
    const {'1': 'GRAMME', '2': 6},
    const {'1': 'KILOGRAMME', '2': 7},
    const {'1': 'CUP', '2': 8},
    const {'1': 'PINCH', '2': 9},
  ],
};

