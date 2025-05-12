class Category {
  final String id;
  final String name;
  final String? color;
   

  Category({
    required this.id,
    required this.name,
    this.color,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'].toString(),
      name: json['name'],
      color: json['color'],
 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
 
    };
  }
}
