class Book {
  Book({
    this.id,
    required this.title,
    required this.authorId,
    required this.titleSlug,
    required this.price,
    required this.format,
    required this.publisher,
    required this.pubDate,
    required this.edition,
    required this.lexile,
    required this.pages,
    required this.dimensions,
    required this.overview,
    required this.excerpt,
    required this.synopsis,
    required this.toc,
    required this.editorialReviews,
  });

  String? id;
  String title;
  String authorId;
  String titleSlug;
  String price;
  String format;
  String publisher;
  String pubDate;
  String edition;
  String lexile;
  String pages;
  String dimensions;
  String overview;
  String excerpt;
  String synopsis;
  String toc;
  String editorialReviews;

  factory Book.fromJson(Map parsedJson) {
    String pubDate = parsedJson['pubdate'];
    print(parsedJson['title']);
    print('DATA AQUIII');
    print(pubDate);
    String convertedPubDate =
        '${pubDate.substring(8, 10)}/${pubDate.substring(5, 7)}/${pubDate.substring(0, 4)}';
    return Book(
      id: parsedJson['id'].toString(),
      title: parsedJson['title'],
      authorId: parsedJson['author_id'].toString(),
      titleSlug: parsedJson['title_slug'],
      price: parsedJson['price'],
      format: parsedJson['format'],
      publisher: parsedJson['publisher'],
      pubDate: convertedPubDate,
      edition: parsedJson['edition'],
      lexile: parsedJson['lexile'],
      pages: parsedJson['pages'].toString(),
      dimensions: parsedJson['dimensions'],
      overview: parsedJson['overview'],
      excerpt: parsedJson['excerpt'],
      synopsis: parsedJson['synopsis'],
      toc: parsedJson['toc'],
      editorialReviews: parsedJson['editorial_reviews'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'authorId': authorId,
      'titleSlug': titleSlug,
      'price': price,
      'format': format,
      'publisher': publisher,
      'pubDate': pubDate,
      'edition': edition,
      'lexile': lexile,
      'pages': pages,
      'dimensions': dimensions,
      'overview': overview,
      'excerpt': excerpt,
      'synopsis': synopsis,
      'toc': toc,
      'editorialReviews': editorialReviews,
    };
  }
}
