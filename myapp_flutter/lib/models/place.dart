class Place {
  final String key;
  final String name;
  final String imageURL;
  final double latitude;
  final double longitude;

  Place({
    this.key,
    this.name,
    this.imageURL,
    this.latitude,
    this.longitude,
  });

  Place copyWith(
      {String key,
      String name,
      String imageURL,
      double latitude,
      double longitude}) {
    return Place(
        key: key ?? this.key,
        name: name ?? this.name,
        imageURL: imageURL ?? this.imageURL,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude);
  }
}
