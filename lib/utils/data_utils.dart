import '../models/json_models/chart_item_model.dart';

generateTreeData(List<ChartItemModel> items, int level, String? parentId, int maxLevel) {
  List<ChartItemModel> childrenItems = [];
  for (ChartItemModel item in items) {
    if (item.parentId == parentId) {
      item.level = level;
      List tmp = generateTreeData(items, level + 1, item.uuid, maxLevel);
      item.children =tmp[0];
      maxLevel =tmp[1];
      childrenItems.add(item);
    }
    maxLevel = maxLevel < level ? level : maxLevel;
  }
  return [childrenItems,maxLevel];
}