import 'dart:html';
void main() {
  document.querySelector('h1').setAttribute('style', 'color: red;');
  document.querySelector('h2').setAttribute('class', 'subtitle is-2');
  document.querySelector('h3').setAttribute('class', 'subtitle is-3');
  document.querySelector('button').setAttribute('class', 'button is-link is-light');
}