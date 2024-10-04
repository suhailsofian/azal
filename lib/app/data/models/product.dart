class Product {
  final int id;
  final String name;
  final String image;
  final String description;
  final String body;


  Product(
    this.id,
    this.name,
    this.image,
    this.description,
    this.body,
    
  );

  factory Product.fromJsonEn(dynamic json) {
    return Product(
        json['id'] as int,
        json['name_en'] as String,
        json['image'] as String,
        json['description_en'] as String,
        json['body_en'] as String);
    // json[1]['image_path'] as String);
  }

  factory Product.fromJsonAr(dynamic json) {
    return Product(
        json['id'] as int,
        json['name_ar'] as String,
        json['image'] as String,
        json['description_ar'] as String,
        json['body_ar'] as String);
    // json[1]['image_path'] as String);
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'description': description,
        'body': body,
        // 'imagePath': imagePath,
      };
}
