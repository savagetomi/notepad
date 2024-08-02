class Note {
  int? id;
  String title;
  String categories;
  DateTime createdAt;

  Note({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.categories,
  });

  Map<String, dynamic> toMap(){
    return {
      'title' : title,
      'categories' : categories,
      'createdAt' : createdAt.toString(),
    };
  }
}

