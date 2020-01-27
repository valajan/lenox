// Bulma CSS designer
import 'dart:html';

void main() {
  // h1
  setConfig('h1', 'title is-1');

  // h2
  setConfig('h2', 'subtitle is-2');

  // h3
  setConfig('h3', 'subtitle is-3');

  // button
  setConfig('button', 'button');

  // button in link
  setConfig('a button', 'button is-link');

  // section
  setConfig('section', 'section');

  // input
  setConfig('input', 'input');

  // textarea
  setConfig('textarea', 'textarea');

  // checkbox
  setConfig('label', 'checkbox');

  // table
  setConfig('table', 'table');
}

void setConfig(query, config) {
  query = document.querySelectorAll(query);
  if ('$query' != '[]') {
    var queries = query.toList();
    for (var i = 0; i < queries.length; i++) {
      queries[i].setAttribute('class', config);
    }
  }
}
