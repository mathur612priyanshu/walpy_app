import 'package:flutter/material.dart';
import 'package:walpy_app/controller/apiOper.dart';
import 'package:walpy_app/model/photosModel.dart';
import 'package:walpy_app/views/screen/fullScreen.dart';
import 'package:walpy_app/views/widgets/CustomAppBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryScreen extends StatefulWidget {
  final String catName;
  final String catImgUrl;

  const CategoryScreen(
      {super.key, required this.catImgUrl, required this.catName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<PhotosModel> categoryResults = [];
  bool isLoading = true;

  // Fetches wallpapers related to the selected category
  GetCatRelWall() async {
    categoryResults = await ApiOperations.searchWallpapers(widget.catName);

    setState(() {
      isLoading = false; // Set loading to false once data is fetched
    });
  }

  @override
  void initState() {
    GetCatRelWall(); // Initiate API call to fetch category-related wallpapers
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const CustomAppBar(
          word1: "Walpy", // First part of the app title
          word2: "App", // Second part of the app title
        ),
      ),
      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator(), // Show loading indicator while fetching data
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Category image with overlay and text
                  Stack(
                    children: [
                      // Category image background
                      Image.network(
                        height: 150.h,
                        width: 1.sw, // Full screen width
                        fit: BoxFit.cover,
                        widget.catImgUrl,
                      ),
                      // Semi-transparent overlay to darken the image
                      Container(
                        height: 150.h,
                        width: 1.sw, // Full screen width
                        color: Colors.black38,
                      ),
                      // Positioned text on top of the image
                      Positioned(
                        left: 120.w, // Responsive left padding
                        top: 40.h, // Responsive top padding
                        child: Column(
                          children: [
                            Text(
                              "Category",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              widget.catName,
                              style: TextStyle(
                                fontSize: 30.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h), // Responsive spacing

                  // Grid view of category-related wallpapers
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 10.w), // Responsive margin
                    height: 700.h,
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 400.h, // Height of each grid item
                        crossAxisCount: 2, // Number of columns in the grid
                        crossAxisSpacing:
                            13.w, // Horizontal spacing between grid items
                        mainAxisSpacing:
                            10.h, // Vertical spacing between grid items
                      ),
                      itemCount: categoryResults.length, // Number of wallpapers
                      itemBuilder: (context, index) => GridTile(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullScreen(
                                  imgUrl: categoryResults[index].imgSrc,
                                ),
                              ),
                            );
                          },
                          child: Hero(
                            tag: categoryResults[index].imgSrc,
                            child: Container(
                              height: 400.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                color: Colors.amberAccent,
                                borderRadius: BorderRadius.circular(
                                    20.r), // Responsive border radius
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    20.r), // Responsive border radius
                                child: Image.network(
                                  height: 400.h,
                                  width: 50.w,
                                  fit: BoxFit.cover,
                                  categoryResults[index].imgSrc,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
