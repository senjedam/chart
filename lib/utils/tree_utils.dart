import 'package:flutter/material.dart';
import '../constants/sizes.dart';
import '../models/json_models/chart_item_model.dart';
import '../models/children_with_pos_model.dart';
import '../models/level_pos_model.dart';
import '../widgets/flowchart_item.dart';
import '../widgets/leaf_widget_group.dart';
import '../widgets/lines/s_shaped_line_painter.dart';

ChildrenWithPosModel getChildrenWithPos(ChartItemModel nodeItem, int maxLevel,
    Function(String) onTap, List<String> notContainUUID) {
  double widgetWidth = ChartItemSizes.widgetWidth;
  double widgetHeight = ChartItemSizes.widgetHeight;
  double widgetPadding = ChartItemSizes.widgetPadding;

  double totalWidth = 0;
  double totalHeight = 0;

  double rightBrothersWidth = 0;
  List<Widget> chartItemWidgets = [];
  List<Offset> toPositionList = [];

  List<LevelPosModel> soliPoses = List.generate(
      maxLevel, (index) => LevelPosModel(rightPos: null, leftPos: null));
  double soliGapSize = 0;

  List<ChartItemModel>? items = nodeItem.children;

  for (int i = 0; i < items!.length; i++) {
    ChartItemModel item = items[i];
    ChildrenWithPosModel itemData;

    if (item.children == null || item.children!.isEmpty) {
      itemData = getLeafChildrenWithPos(items, i, maxLevel);
      if (itemData.currentIndex != null) {
        i = itemData.currentIndex!;
      }
    } else {
      itemData = getChildrenWithPos(item, maxLevel, onTap, notContainUUID);
    }

    double? minGapSize;
    int theMinLevel = 0;
    if (i == 0) {
      soliPoses = itemData.levelPoses!;
      minGapSize = 0;
    } else {
      double maxsize = 0;
      for (int j = 0; j < maxLevel; j++) {
        if (itemData.levelPoses![j].rightPos != null) {
          double gapSize = -(soliPoses[j].leftPos ?? 0) +
              itemData.levelPoses![j]!
                  .rightPos!; //itemData.levelPoses![i].rightPos!;
          if (minGapSize == null || minGapSize > gapSize) {
            minGapSize = gapSize;
            theMinLevel = j;
          }
        }
      }
      for (int j = 0; j < maxLevel; j++) {
        // if(itemData.levelPoses![j]!.rightPos!=null)
        maxsize = (soliPoses[j].leftPos ?? 0) > maxsize
            ? (soliPoses[j].leftPos ?? 0)
            : maxsize;
      }

      minGapSize = minGapSize == null ? 0 : minGapSize! + maxsize;
      soliGapSize += minGapSize;

      for (int j = 0; j < maxLevel; j++) {
        if (itemData.levelPoses![j]!.leftPos != null) {
          if (item.children == null || item.children!.isEmpty) {
            soliPoses[j].leftPos =
                maxsize + itemData.levelPoses![j].leftPos! - soliGapSize;
            soliPoses[j].rightPos =
                maxsize + itemData.levelPoses![j].rightPos! - soliGapSize;
          } else {
            soliPoses[j].leftPos = maxsize +
                itemData.levelPoses![j].leftPos! -
                soliGapSize +
                widgetPadding;
            // soliPoses[j].rightPos=maxsize+itemData.levelPoses![j].rightPos!-soliGapSize;
          }
        }
      }
    }
    minGapSize = 0;
    soliGapSize = 0;

    item.totalWidth = itemData.totalWidth!;
    item.rightPos = rightBrothersWidth -
        minGapSize; //-minGapSize/2!;//-minGapSize!; //add brothers widths

    toPositionList.add(Offset(
        rightBrothersWidth + itemData.position!.dx - minGapSize!,
        widgetHeight + widgetPadding));
    totalHeight = itemData.totalHeight! > totalHeight
        ? itemData.totalHeight!
        : totalHeight;
    totalWidth += item.totalWidth + widgetPadding;
    rightBrothersWidth +=
        item.totalWidth + widgetPadding - minGapSize; //-minGapSize;

    //add each group of nodes/leaf
    chartItemWidgets.add(Positioned(
        right: item.rightPos,
        top: 1 * (widgetHeight + widgetPadding), //ToDo
        child: itemData.widget!));
  }

  totalWidth = totalWidth - widgetPadding;
  totalHeight += widgetHeight + widgetPadding;
  nodeItem.rightPos = totalWidth / 2 - widgetWidth / 2; //-soliGapSize;
  nodeItem.totalWidth = totalWidth;

  if (false && notContainUUID.contains(nodeItem.uuid)) {
    chartItemWidgets = [];
    // chartItemWidgets=[];
  } else {
    //add lines from Parent
    for (int j = 0; j < toPositionList.length; j++) {
      Widget widget = Positioned(
        right: (totalWidth + widgetPadding) / 2,
        child: CustomPaint(
          size: const Size(50, 50),
          painter: SShapedLinePainter(
            // start: Offset(widgetWidth / 2+soliGapSize, widgetHeight),
            start: Offset(widgetWidth / 2, widgetHeight),
            end: Offset(
                (totalWidth / 2 - toPositionList[j].dx), toPositionList[j].dy),
            cornerRadius: 10.0,
            strokeWidth: 1.0,
            // color: FlowChartColors.blue[1],
            color: Colors.grey,
          ),
        ),
      );
      chartItemWidgets.add(widget);
    }
  }
  // var tmp = AnimatedContainer(
  //     duration: const Duration(milliseconds: 700),
  //     curve: Curves.easeInOut,
  //     height: notContainUUID.contains(nodeItem.uuid) ? 0 : totalHeight,
  //     child: Stack(
  //       children: chartItemWidgets,
  //     ));
  var tmp = AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      opacity: notContainUUID.contains(nodeItem.uuid) ? 0.0 : 1.0,
      child: Stack(
        children: chartItemWidgets,
      ));

  chartItemWidgets = [tmp];

  //add ParentNode
  chartItemWidgets.add(Positioned(
      right: nodeItem.rightPos,
      top: 0, // (widgetHeight + widgetPadding),
      child: FlowChartItemWidget(
          nodeItem.nodeType!.id!,
          nodeItem.subtitle!,
          nodeItem.description!,
          nodeItem.entity!.title!,
          null,
          onTap,
          nodeItem.uuid!,
          !notContainUUID.contains(nodeItem.uuid))));

  //put all the nodes in a stack
  var myStack = Container(
    height: totalHeight,
    width: totalWidth,
    color: Colors.amberAccent.withOpacity(0.01),
    // color: Colors.green.withOpacity(0.1),
    child: Stack(
      children: chartItemWidgets,
    ),
  );

  soliPoses[nodeItem.level] = LevelPosModel(
      leftPos: totalWidth / 2 + widgetWidth / 2,
      rightPos: totalWidth / 2 - widgetWidth / 2);

  return ChildrenWithPosModel(
      totalWidth: totalWidth,
      totalHeight: totalHeight,
      position: Offset(
          totalWidth / 2 - widgetWidth / 2, widgetHeight + widgetPadding),
      widget: myStack,
      levelPoses: soliPoses);
}

getLeafChildrenWithPos(
    List<ChartItemModel> items, int currentIndex, int maxLevel) {
  double widgetWidth = ChartItemSizes.widgetWidth;
  double widgetHeight = ChartItemSizes.widgetHeight;
  double widgetPadding = ChartItemSizes.widgetPadding;

  int? leafSearchStopIndex;
  List<Widget> leafWidgets = [];

  for (int i = currentIndex; i < items.length; i++) {
    //searching in brothers
    if (items[i].children != null && items[i].children!.isNotEmpty) {
      //if ith node is first none-leaf brother
      leafSearchStopIndex = i - 1;
      break;
    }
    leafWidgets.add(FlowChartItemWidget(
        items[i].nodeType!.id!,
        items[i].subtitle!,
        items[i].description!,
        items[i].entity!.title!,
        null,
        null,
        items[i].uuid!,
        null));
  }
  List<LevelPosModel> levelPoses =
      List.generate(maxLevel, (index) => LevelPosModel());

  if (leafWidgets.length == 1) {
    // if single leaf
    levelPoses[items[currentIndex].level] =
        LevelPosModel(rightPos: 0, leftPos: widgetWidth);
    return ChildrenWithPosModel(
        totalWidth: widgetWidth,
        totalHeight: widgetHeight,
        position: Offset(0, widgetHeight + widgetPadding),
        widget: leafWidgets[0],
        levelPoses: levelPoses);
  }
  //else if multiple brother leaf
  for (int i = 0; i < leafWidgets.length / 2; i++) {
    if (items[currentIndex].level + i < maxLevel) {
      levelPoses[items[currentIndex].level + i] =
          LevelPosModel(rightPos: 0, leftPos: 2 * widgetWidth + widgetPadding);
    }
  }
  return ChildrenWithPosModel(
      totalWidth: 2 * widgetWidth + widgetPadding,
      totalHeight:
          (widgetHeight + widgetPadding) * (leafWidgets.length / 2).ceil(),
      position: Offset(
          (widgetWidth + widgetPadding) / 2, widgetHeight + widgetPadding),
      widget: LeafGroupWidget(leafWidgets),
      currentIndex: leafSearchStopIndex ?? leafWidgets.length,
      levelPoses: levelPoses);
}
