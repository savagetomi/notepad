class Notess {
  int? id;
  String title;
  String categories;
  DateTime createdAt;

  Notess({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.categories,
  });




  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'title' : title,
      'categories' : categories,
      'createdAt' : createdAt.toString(),
    };
  }
}

