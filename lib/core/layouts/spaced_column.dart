// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:randy_fuerte_technical_assessment/core/layouts/spaced_linear_layout.dart';

/// A custom widget similar to [Column], but allows
/// setting the [spacing] between each [children].
class SpacedColumn extends SpacedLinearLayout {
  const SpacedColumn({
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.children,
    super.spacing,
  });

  @override
  final Axis axis = Axis.vertical;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textBaseline: textBaseline,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      children: getChildren(),
    );
  }
}
