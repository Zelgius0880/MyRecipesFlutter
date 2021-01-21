///
//  Generated code. Do not modify.
//  source: recipe.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Recipe_Type extends $pb.ProtobufEnum {
  static const Recipe_Type DESSERT = Recipe_Type._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DESSERT');
  static const Recipe_Type MEAL = Recipe_Type._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MEAL');
  static const Recipe_Type OTHER = Recipe_Type._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OTHER');

  static const $core.List<Recipe_Type> values = <Recipe_Type> [
    DESSERT,
    MEAL,
    OTHER,
  ];

  static final $core.Map<$core.int, Recipe_Type> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Recipe_Type valueOf($core.int value) => _byValue[value];

  const Recipe_Type._($core.int v, $core.String n) : super(v, n);
}

class Ingredient_Unit extends $pb.ProtobufEnum {
  static const Ingredient_Unit MILLILITER = Ingredient_Unit._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MILLILITER');
  static const Ingredient_Unit LITER = Ingredient_Unit._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LITER');
  static const Ingredient_Unit UNIT = Ingredient_Unit._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNIT');
  static const Ingredient_Unit TEASPOON = Ingredient_Unit._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TEASPOON');
  static const Ingredient_Unit TABLESPOON = Ingredient_Unit._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TABLESPOON');
  static const Ingredient_Unit GRAMME = Ingredient_Unit._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GRAMME');
  static const Ingredient_Unit KILOGRAMME = Ingredient_Unit._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'KILOGRAMME');
  static const Ingredient_Unit CUP = Ingredient_Unit._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CUP');
  static const Ingredient_Unit PINCH = Ingredient_Unit._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PINCH');

  static const $core.List<Ingredient_Unit> values = <Ingredient_Unit> [
    MILLILITER,
    LITER,
    UNIT,
    TEASPOON,
    TABLESPOON,
    GRAMME,
    KILOGRAMME,
    CUP,
    PINCH,
  ];

  static final $core.Map<$core.int, Ingredient_Unit> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Ingredient_Unit valueOf($core.int value) => _byValue[value];

  const Ingredient_Unit._($core.int v, $core.String n) : super(v, n);
}

