class Drink {
  String name;
  String imagePath;

  Drink({
    required this.name,
    required this.imagePath,
  });

  String get _name => name;
  String get _imagePath => imagePath;
}