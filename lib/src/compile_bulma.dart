import 'package:lenox/src/autoloader.dart';
import 'package:markdown/markdown.dart';

class CompileBulma {
  var config = LenoxContent();
  dynamic main(markdown) async {
    config.setConfig('themes/bulma/bulma.yaml');
    await config.getter();
    var data = config.getAll();
    var convertor = await markdownToHtml(markdown,
            inlineSyntaxes: <InlineHtmlSyntax>[InlineHtmlSyntax()])
        .replaceAll('#button', '<button>')
        .replaceAll('button#', '</button>');
    await data.forEach((key, value) => 
      convertor = convertor.replaceAll('<$key>', '<$key class="$value">')
    );
    return convertor;
  }
}
