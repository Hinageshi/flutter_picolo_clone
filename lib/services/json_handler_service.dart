import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_picolo_clone/model/quote.dart';

class JsonHandlerService {
  dynamic _quotesJsonData;
  dynamic _namesJsonData;
  dynamic _rulesJsonData;

  JsonHandlerService();

  Future load(BuildContext context) async {
    await loadQuotes(context);
    //await loadNames(context);
    //await loadRules(context);
  }

  Future loadQuotes(BuildContext context) async {
    String quotes = await DefaultAssetBundle.of(context)
        .loadString("assets/data/quotes.json");
    _quotesJsonData = json.decode(quotes);
  }

  Future loadNames(BuildContext context) async {
    String names = await DefaultAssetBundle.of(context)
        .loadString("assets/data/names.json");
    _namesJsonData = json.decode(names);
  }

  Future loadRules(BuildContext context) async {
    String rules = await DefaultAssetBundle.of(context)
        .loadString("assets/data/rules.json");
    _rulesJsonData = json.decode(rules);
  }

  Quote getRandomQuote() {
    if (_quotesJsonData != null) {
      var random = new Random();
      int nb = random.nextInt(_quotesJsonData["number_of_quotes"] - 1);
      return new Quote(_quotesJsonData["quotes"][nb]["quote"],
          author: _quotesJsonData["quotes"][nb]["author"]);
    } else {
      throw new Exception("Quotes data is not yet loaded.");
    }
  }

  String getRandomName() {
    if (_namesJsonData != null) {
      var random = new Random();
      int nb = random.nextInt(_namesJsonData["number_of_names"] - 1);
      return _namesJsonData["names"][nb];
    } else {
      throw new Exception("Names data is not yet loaded.");
    }
  }
}
