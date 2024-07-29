import 'entity_model.dart';
import 'node_type_model.dart';

class ChartItemModel{
  final int? id;
  final String? uuid;
  final String? parentId;
  final NodeTypeModel? nodeType;
  final EntityModel? entity;
  final String? subtitle;
  final String? description;

  late int level=0;
  late double rightPos=0;
  late double totalWidth=0;

  late List<ChartItemModel>? children;


  ChartItemModel(
      {this.id,
      this.uuid,
      this.parentId,
      this.nodeType,
      this.entity,
      this.subtitle,
      this.description,
      });

  factory ChartItemModel.fromMap(Map<String, dynamic> data) {
    return ChartItemModel(
      id: data['id'] as int?,
      uuid: data['uuid'] as String?,
      parentId: data['parent_id'] as String?,
      nodeType: data['node_type'] == null
          ? null
          : NodeTypeModel.fromMap(data['node_type'] as Map<String, dynamic>),
      entity: data['entity'] == null
          ? null
          : EntityModel.fromMap(data['entity'] as Map<String, dynamic>),
      subtitle: data['subtitle'] as String?,
      description: data['description'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'uuid': uuid,
        'parent_id': parentId,
        'node_type': nodeType?.toMap(),
        'entity': entity?.toMap(),
        'subtitle': subtitle,
        'description': description,
      };
}
