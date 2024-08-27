class PhotosModel {
  String imgSrc;
  PhotosModel({
    required this.imgSrc,
  });
  static fromApi2App(Map<String, dynamic> photoMap) {
    // print("hello${photoMap.length}");
    return PhotosModel(imgSrc: (photoMap["src"])["portrait"]);
  }
}
