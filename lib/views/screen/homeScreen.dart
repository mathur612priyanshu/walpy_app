import 'package:flutter/material.dart';
import 'package:walpy_app/controller/apiOper.dart';
import 'package:walpy_app/model/categoryModel.dart';
import 'package:walpy_app/model/photosModel.dart';
import 'package:walpy_app/views/screen/FullScreen.dart';
import 'package:walpy_app/views/widgets/CustomAppBar.dart';
import 'package:walpy_app/views/widgets/SearchBar.dart';
import 'package:walpy_app/views/widgets/catBlock.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List to store trending wallpapers fetched from the API
  List<PhotosModel> trendingWallList = [];

  // List to store categories fetched from the API
  List<CategoryModel> catModList = [];

  // Flags to indicate loading state for categories and wallpapers
  bool isLoadingcat = true;
  bool isLoading = true;

  // Method to fetch categories from the API
  GetCatDetails() async {
    catModList = await ApiOperations.getCategoriesList();

    setState(() {
      if (catModList.isNotEmpty) {
        isLoadingcat =
            false; // Set loading state to false when data is available
      }
    });
  }

  // Method to fetch trending wallpapers from the API
  GetTrendingWallpapers() async {
    trendingWallList = await ApiOperations.getTrendingWallpapers();

    setState(() {
      if (trendingWallList.isNotEmpty) {
        isLoading = false; // Set loading state to false when data is available
      }
    });
  }

  // Initial setup when the screen is created
  @override
  void initState() {
    super.initState();
    GetCatDetails(); // Fetch categories
    GetTrendingWallpapers(); // Fetch trending wallpapers
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(400, 875), // Design size for responsiveness
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: CustomAppBar(
            word1: "Walpy", // First part of the app title
            word2: "App", // Second part of the app title
          ),
        ),
        body: Column(
          children: [
            // Search bar widget with responsive padding
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Search_Bar(),
            ),
            SizedBox(height: 20.h), // Responsive vertical spacing

            // Horizontal list of categories or shimmer effect while loading
            Container(
              height: 50.h,
              width: MediaQuery.of(context).size.width,
              child: isLoadingcat
                  ? Shimmer.fromColors(
                      // Shimmer effect while categories are loading
                      child: Container(
                        width: double.infinity,
                        height: 20.h,
                        color: Colors.red,
                      ),
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: catModList.length,
                      itemBuilder: (context, index) => CatBlock(
                        // Category block displaying category image and name
                        categoryImgSrc: catModList[index].catImgUrl,
                        categoryName: catModList[index].catName,
                      ),
                    ),
            ),
            SizedBox(height: 20.h), // Responsive vertical spacing

            // Expanded widget to make the GridView take up available space
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  // Reload the screen when the user pulls down to refresh
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: isLoading
                    ? const Center(
                        // Show a loading indicator while wallpapers are being fetched
                        child: CircularProgressIndicator(),
                      )
                    : GridView.builder(
                        // Grid view of trending wallpapers
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 400.h, // Height of each grid item
                          crossAxisCount: 2, // Number of columns in the grid
                          crossAxisSpacing:
                              13.w, // Horizontal spacing between grid items
                          mainAxisSpacing:
                              10.h, // Vertical spacing between grid items
                        ),
                        itemCount: trendingWallList.length,
                        itemBuilder: (context, index) => GridTile(
                          child: InkWell(
                            onTap: () {
                              // Navigate to the full-screen view of the wallpaper when tapped
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullScreen(
                                    imgUrl: trendingWallList[index].imgSrc,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              // Hero animation for smooth transition to the full-screen view
                              tag: trendingWallList[index].imgSrc,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.amberAccent,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.r),
                                  child: Image.network(
                                    trendingWallList[index].imgSrc,
                                    height: 800.h,
                                    width: 50.w,
                                    fit: BoxFit.cover,
                                  ),
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
