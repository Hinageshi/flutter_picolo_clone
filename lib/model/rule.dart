enum Type { RULE, BUG, VIRUS, GAME, SHOT }

class Rule {
  final int _id;
  final String _content;
  final String _endContent;
  final int _nbPlayers;
  final Type _type;

  Rule(int id, String content, int nbPlayers, String type, {String endContent})
      : _id = id,
        _content = content,
        _nbPlayers = nbPlayers,
        _type = getTypeFromString(type),
        _endContent = endContent;

  static Type getTypeFromString(String type) {
    switch (type) {
      case "rule":
        return Type.RULE;
      case "bug":
        return Type.BUG;
      case "virus":
        return Type.VIRUS;
      case "game":
        return Type.GAME;
      case "shot":
        return Type.SHOT;
      default:
        return Type.RULE;
    }
  }

  int get id => _id;
  String get content => _content;
  String get endContent => _endContent != null ? _endContent : "";
  int get nbPlayers => _nbPlayers;
  Type get type => _type;
  String get typeAsString => _type.toString().split(".")[1];
}
