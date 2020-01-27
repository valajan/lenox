# Lenox
A simple static site generator written in [Dart](https://dart.dev/)

## How to start

**Install dependencies**
```
git clone https://github.com/valajan/lenox.git
cd lenox
pub get
```

**Start Lenox**
```
dart main.dart
```
The *main.dart* file is the entry file of Lenox  

**Generate static files**
```
pub run build.dart
```

**Launch webdev server**

```
webdev serve build
```
[Webdev](https://pub.dev/packages/webdev) package can only works if the build.yaml file is present.  
You can configure it with your own desire !  
Optionnaly you can create a web folder and delete the unnecessary build.yaml file.  

## Theming

**Choose or create your own theme !**  
Two themes are availables at the moment (blank & bulma).  
You can create your own theme, just add a folder in themes directory.  
Add a layout.html base file and it's ready !  

To use your theme go to the config.yaml file in the config directory and replace the theme name by the new one
```
theme: mySuperTheme
# theme name must be match with the folder name
```

## License
Licensed under the [MIT License](https://github.com/valajan/lenox/blob/master/LICENSE).
