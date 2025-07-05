class BibleBook {
  final String name;
  final String slug;
  final String abbreviation;

  BibleBook({
    required this.name,
    required this.slug,
    required this.abbreviation,
  });

  factory BibleBook.fromJson(Map<String, dynamic> json) {
    return BibleBook(
      name: json['name'] ?? '',
      slug: json['abbrev']?['pt'] ?? '',  // <- slug vem do abbrev pt
      abbreviation: json['abbrev']?['pt'] ?? '',
    );
  }
}
