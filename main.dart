// Utilisation basique du routeur
// Import du router
import 'lib/src/autoloader.dart';
// Déclaration de la fonction main non async

Future<void> main() async {
  await Prebuild().main();
  // Appel de l'objet Router avec une configuration minimale
  // On peut utiliser des options myView, errorPage et myPort
  await Router()
  // Démarrage du router qui s'occupe de créer un serveur web
  // D'écouter les requêtes et de retourner un résultat en
  // Fonction du fichier de configuration qui est indispensable
  // Paramètre logger optionnel
    .router(logger: false);
  // Configuration du router avec le fichier de configuration
  // renseigné plus haut
    // ..config(routeConfig);
  // app.build();
}