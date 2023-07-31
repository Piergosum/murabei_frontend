class Subject {
  Subject({
    this.id,
    required this.title,
    required this.slug,
  });

  String? id;
  String title;
  String slug;

  factory Subject.fromJson(Map parsedJson) {
    return Subject(
        id: parsedJson['id'].toString(),
        title: parsedJson['title'],
        slug: parsedJson['slug']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
    };
  }
}
