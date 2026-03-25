class Quote {
  late String quote;

  Quote.fromJson(Map<String, dynamic> json) {
    quote = json['fact'] ?? json['quote'] ?? 'No quote available';
  }
}
