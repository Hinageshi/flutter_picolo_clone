class Quote {
  final String _content;
  final String _author;

  Quote(String content, {String author})
      : _content = content,
        _author = author;

  String get content => _content;
  String get author => _author;
}
