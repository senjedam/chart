class EntityModel{
  final String? uuid;
  final String? title;
  final String? image;

  const EntityModel(
      {this.uuid,
      this.title,
      this.image});

  factory EntityModel.fromMap(Map<String, dynamic> data) {
    return EntityModel(
      uuid: data['uuid'] as String?,
      title: data['title'] as String?,
      image: data['image'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'uuid': uuid,
        'title': title,
        'image': image,
      };
}
