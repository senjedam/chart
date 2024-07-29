import 'package:flutter/material.dart';
import '../constants/sizes.dart';
import 'lines/tree_shaped_line_painter.dart';

class LeafGroupWidget extends StatelessWidget {
  final List<Widget> leafChartItemWidgets;
  const LeafGroupWidget(this.leafChartItemWidgets,{super.key});

  @override
  Widget build(BuildContext context) {
    return
      Stack(
        children: [
          SizedBox(
            height: (ChartItemSizes.widgetHeight + ChartItemSizes.widgetPadding / 2) *
                (leafChartItemWidgets.length / 2).ceil(),
            //-ChartItemSizes.widgetPadding/2
            width: ChartItemSizes.widgetWidth * 2 + ChartItemSizes.widgetPadding,
            child: GridView.count(
              crossAxisSpacing: ChartItemSizes.widgetPadding,
              mainAxisSpacing: ChartItemSizes.widgetPadding / 2,
              crossAxisCount: 2,
              childAspectRatio: 2,
              children: leafChartItemWidgets,
            ),
          ),
          Container(
            // color: Colors.red.withOpacity(0.3),
            height: (ChartItemSizes.widgetHeight + ChartItemSizes.widgetPadding / 2) *
                (leafChartItemWidgets.length / 2).ceil(), //-ChartItemSizes.widgetPadding/2
            width: ChartItemSizes.widgetWidth * 2 + ChartItemSizes.widgetPadding,
            child: CustomPaint(
              // size: const Size(50, 50),
              painter: TreeShapedLinePainter(
                  start: const Offset((ChartItemSizes.widgetWidth * 2 + ChartItemSizes.widgetPadding) / 2, 0),
                  strokeWidth: 1.0,
                  // color: Color(FlowChartColors().Blue[1]),
                  color: Colors.grey,
                  nodeCount: leafChartItemWidgets.length),
            ),
          ),
        ],
      );
  }
}