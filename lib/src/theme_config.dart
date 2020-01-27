import 'content.dart';

class ThemeConfig {
  String theme;
  var config = LenoxContent();

  String themeConfig({String configFile}) {
    config.setConfig(configFile);
    config.getter();
    theme = config.getTheme();
    // If no theme is provided the default theme is blank
    theme ??= 'blank';
    return theme;
  }
}
