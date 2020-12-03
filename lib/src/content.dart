import 'dart:io';
import 'package:yaml_config/yaml_config.dart';

class LenoxContent {
  
  String title;

  String subtitle;
  
  String description;
  
  String keywords;
  
  String author;
  
  String language;
  
  String theme;
  
  String config;

  var all;

  String setConfig(myConfig) {
    return config = myConfig;
  }

  void getter() async {
    var config = await YamlConfig.fromFile(File(this.config));
    title = config.getString('title');
    subtitle = config.getString('subtitle');
    description = config.getString('description');
    keywords = config.getString('keywords');
    author = config.getString('author');
    language = config.getString('language');
    theme = config.getString('theme');
    all = config.get('class');
  }

  String getTitle() {
    return title;
  }

  String getSubtitle() {
    return subtitle;
  }

  String getDescription() {
    return description;
  }

  String getKeywords() {
    return keywords;
  }

  String getAuthor() {
    return author;
  }

  String getLanguage() {
    return language;
  }

  String getTheme() {
    return theme;
  }

  Map getAll() {
    return all;
  }
}
