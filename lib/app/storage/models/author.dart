class Author {
  Author(
      {this.id,
      required this.title,
      required this.slug,
      required this.biograpy});

  String? id;
  String title;
  String slug;
  String biograpy;

  factory Author.fromJson(Map parsedJson) {
    return Author(
        id: parsedJson['id'].toString(),
        title: parsedJson['title'],
        slug: parsedJson['slug'],
        biograpy: parsedJson['biography']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'slug': slug, 'biography': biograpy};
  }
}
