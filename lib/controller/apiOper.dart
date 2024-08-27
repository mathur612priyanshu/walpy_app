// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:walpy_app/model/photosModel.dart';

// class ApiOperations {
//   static late List<PhotosModel> trendingWallpapers;
//   static Future<List<PhotosModel>> getTrendingWallpapers() async {
//     await http.get(Uri.parse("https://api.pexels.com/v1/curated"), headers: {
//       "Authorization":
//           "hCRILJLTZbrujJ2luzCkrJWiitXtou3q1gum1xGSlAnTucO0b2mWzGz4"
//     }).then((value) {
//       Map<String, dynamic> jsonData = jsonDecode(value.body);
//       List photos = jsonData["photos"];
//       photos.forEach((element) {
//         trendingWallpapers.add(PhotosModel.fromApi2App(element));
//       });
//     });
//     return trendingWallpapers;
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:walpy_app/model/photosModel.dart';
import "package:walpy_app/model/categoryModel.dart";
import 'dart:math';

class ApiOperations {
  static List<PhotosModel> trendingWallpapers = [];
  static List<PhotosModel> searchWallpapersList = [];
  static List<CategoryModel> categoryModelList = [];

  static Future<List<PhotosModel>> getTrendingWallpapers() async {
    final response = await http.get(
      Uri.parse("https://api.pexels.com/v1/curated"),
      headers: {
        "Authorization":
            "hCRILJLTZbrujJ2luzCkrJWiitXtou3q1gum1xGSlAnTucO0b2mWzGz4"
      },
    );
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    List photos = jsonData["photos"];
    trendingWallpapers.clear();
    for (var element in photos) {
      trendingWallpapers.add(PhotosModel.fromApi2App(element));
    }
    return trendingWallpapers;
  }

  static Future<List<PhotosModel>> searchWallpapers(String query) async {
    final response = await http.get(
      Uri.parse(
          "https://api.pexels.com/v1/search?query=$query&per_page=100&page=1"),
      headers: {
        "Authorization":
            "hCRILJLTZbrujJ2luzCkrJWiitXtou3q1gum1xGSlAnTucO0b2mWzGz4"
      },
    );
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    List photos = jsonData["photos"];
    searchWallpapersList.clear();
    for (var element in photos) {
      searchWallpapersList.add(PhotosModel.fromApi2App(element));
    }
    return searchWallpapersList;
  }

  static Future<List<CategoryModel>> getCategoriesList() async {
    List<String> categoryNames = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers"
    ];
    categoryModelList.clear();
    final _random = Random();

    for (var catName in categoryNames) {
      List<PhotosModel> searchResults = await searchWallpapers(catName);
      PhotosModel photoModel = searchResults[_random.nextInt(11)];
      // print("IMG SRC IS HERE");
      // print(photoModel.imgSrc);
      categoryModelList
          .add(CategoryModel(catImgUrl: photoModel.imgSrc, catName: catName));
    }

    return categoryModelList;
  }
}
