class NodeTypeModel {
  final int? id;
  final String? title;
  final String? parent;

  const NodeTypeModel(
      {this.id,
      this.title,
      this.parent,});

  factory NodeTypeModel.fromMap(Map<String, dynamic> data) {
    return NodeTypeModel(
      id: data['id'] as int?,
      title: data['title'] as String?,
      parent: data['parent'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'parent': parent,
      };
}
