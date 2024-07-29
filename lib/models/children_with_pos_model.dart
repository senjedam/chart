import 'package:flutter/cupertino.dart';
import 'level_pos_model.dart';

class ChildrenWithPosModel{
  final double? totalWidth;
  final double? totalHeight;
  final Offset? position;
  final Widget? widget;
  final int? currentIndex;
  final List<LevelPosModel>? levelPoses;

  const ChildrenWithPosModel(
      {this.totalWidth,
        this.totalHeight,
        this.position,
        this.widget,
        this.currentIndex,
        this.levelPoses
      });
}
