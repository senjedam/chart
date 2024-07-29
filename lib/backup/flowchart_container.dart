// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:organizational_chart/constants/colors.dart';
// import 'package:organizational_chart/models/children_with_pos_model.dart';
// import 'package:organizational_chart/models/json_models/chart_item_model.dart';
// import 'package:organizational_chart/utils/data_utils.dart';
// import 'package:organizational_chart/utils/tree_utils.dart';
// import 'constants/sizes.dart';
//
// class FlowChartContainer extends StatefulWidget {
//   const FlowChartContainer({super.key});
//
//   @override
//   State<FlowChartContainer> createState() => _FlowChartContainerState();
// }
//
// class _FlowChartContainerState extends State<FlowChartContainer> with SingleTickerProviderStateMixin{
//   double widgetWidth = ChartItemSizes.widgetWidth;
//   double widgetHeight = ChartItemSizes.widgetHeight;
//   double widgetPadding = ChartItemSizes.widgetPadding;
//
//   List<ChartItemModel> _items = [];
//   int maxLevel = 0;
//   late double containerWidth = 0;
//   late double containerHeight = 0;
//   Widget? chartWidget;
//   List<String> notContainUUID = [];
//
//   final ValueNotifier<bool> flowChartChangedValueNotifier = ValueNotifier<bool>(false);
//   final ValueNotifier<bool> dataLoadedNotifier = ValueNotifier<bool>(false);
//
//   AnimationController? _controller;
//   Animation<double>? _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     readJson();
//
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 1000),
//       vsync: this,
//     );
//
//     _animation = CurvedAnimation(
//       parent: _controller!,
//       curve: Curves.easeInOut,
//     );
//   }
//
//   Future<void> readJson() async {
//     final String response = await rootBundle.loadString('json/chart.json');
//     final data = await json.decode(response);
//     _items = List<ChartItemModel>.from(data["items"].map((model) {
//       return ChartItemModel.fromMap(model);
//     }));
//
//     var tmp = generateTreeData(List.from(_items), 0, null, 0);
//     _items = tmp[0];
//     maxLevel = tmp[1];
//
//     dataLoadedNotifier.value = true;
//   }
//
//   void flowChartItemOnTapFunc(String uuid) {
//     if (notContainUUID.contains(uuid)) {
//       notContainUUID.removeWhere((element) => element == uuid);
//     } else {
//       notContainUUID.add(uuid);
//     }
//     flowChartChangedValueNotifier.value = !flowChartChangedValueNotifier.value;
//   }
//
//   void refreshTheTreeData() {
//     ChildrenWithPosModel childrenWithPosModel = getChildrenWithPos(
//         _items[0], maxLevel, flowChartItemOnTapFunc, notContainUUID);
//     containerWidth = childrenWithPosModel.totalWidth!;
//     containerHeight = childrenWithPosModel.totalHeight!;
//     chartWidget = childrenWithPosModel.widget!;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     ScrollController scrollControllerHorizontal = ScrollController();
//     ScrollController scrollControllerVertical = ScrollController();
//
//     return ValueListenableBuilder<bool>(
//       valueListenable: dataLoadedNotifier,
//       builder: (context, dataLoaded, child) {
//         if (!dataLoaded) {
//           return const Center(child: CircularProgressIndicator());
//         } else {
//           return InteractiveViewer(
//             boundaryMargin: const EdgeInsets.all(50.0),
//             minScale: 0.05,
//             maxScale: 10.0,
//             child: SingleChildScrollView(
//               controller: scrollControllerHorizontal,
//               scrollDirection: Axis.vertical,
//               child: SingleChildScrollView(
//                 controller: scrollControllerVertical,
//                 scrollDirection: Axis.horizontal,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ValueListenableBuilder<bool>(
//                     valueListenable: flowChartChangedValueNotifier,
//                     builder: (context, value, child) {
//                       refreshTheTreeData();
//                       return Column(
//                         children: [
//                           Container(
//                             color: const Color(0xffeeeeee),
//                             width: containerWidth,
//                             height: containerHeight,
//                             child: chartWidget,
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
// }