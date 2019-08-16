import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_picolo_clone/model/quote.dart';
import 'package:flutter_picolo_clone/model/rule.dart';
import 'package:provider/provider.dart';

class JsonHandlerService {
  dynamic _quotesJsonData;
  dynamic _namesJsonData;
  dynamic _rulesJsonData;

  JsonHandlerService();

  Future load(BuildContext context) async {
    await loadQuotes(context);
    await loadNames(context);
    await loadRules(context);
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
      int nb = random.nextInt(_quotesJsonData["number_of_quotes"]);
      return new Quote(_quotesJsonData["quotes"][nb]["quote"],
          author: _quotesJsonData["quotes"][nb]["author"]);
    } else {
      throw new Exception("Quotes data is not yet loaded.");
    }
  }

  String getRandomName() {
    if (_namesJsonData != null) {
      var random = new Random();
      int nb = random.nextInt(_namesJsonData["number_of_names"]);
      return _namesJsonData["names"][nb];
    } else {
      throw new Exception("Names data is not yet loaded.");
    }
  }

  Rule getRandomRule() {
    if (_rulesJsonData != null) {
      var random = new Random();
      int nb = random.nextInt(_rulesJsonData["number_of_rules"]);
      if (_rulesJsonData["rules"][nb]["end_rule"] != null)
        return new Rule(
            _rulesJsonData["rules"][nb]["id"],
            _rulesJsonData["rules"][nb]["rule"],
            _rulesJsonData["rules"][nb]["number_of_players"],
            _rulesJsonData["rules"][nb]["type"],
            endContent: _rulesJsonData["rules"][nb]["end_rule"]);
      else
        return new Rule(
            _rulesJsonData["rules"][nb]["id"],
            _rulesJsonData["rules"][nb]["rule"],
            _rulesJsonData["rules"][nb]["number_of_players"],
            _rulesJsonData["rules"][nb]["type"]);
    } else {
      throw new Exception("Rules data is not yet loaded.");
    }
  }

  Future<List<Rule>> getRulesList(BuildContext context, int nb) async {
    List<Rule> rules = [];
    if (nb > 0 && _rulesJsonData["number_of_rules"] >= nb) {
      List<int> ids = [];
      while (rules.length != nb) {
        Rule rule = Provider.of<JsonHandlerService>(context).getRandomRule();
        if (!ids.contains(rule.id)) {
          rules.add(rule);
          ids.add(rule.id);
        }
      }
    } else {
      if (nb < 0)
        throw new Exception(
            "Cannot call getRulesList with parameter inferior to 0");
      if (_rulesJsonData["number_of_rules"] < nb)
        throw new Exception(
            "Cannot call getRulesList with parameter superior to number of rules in JSON file. Current number of rules is ${_rulesJsonData["number_of_rules"]}");
    }
    return rules;
  }
}
