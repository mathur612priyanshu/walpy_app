import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walpy_app/controller/apiOper.dart';
import 'package:walpy_app/model/photosModel.dart';
import 'package:walpy_app/views/screen/fullScreen.dart';
import 'package:walpy_app/views/widgets/customAppBar.dart';
import 'package:walpy_app/views/widgets/searchBar.dart';

class SearchScreen extends StatefulWidget {
  final String query; // The search query passed from the previous screen.

  // Constructor to initialize the query.
  SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<PhotosModel> searchResults = []; // List to store search results.

  // Function to fetch search results based on the query.
  Future<void> getSearchResult() async {
    searchResults = await ApiOperations.searchWallpapers(widget.query);
    setState(() {}); // Update the UI with the search results.
  }

  @override
  void initState() {
    super.initState();
    getSearchResult(); // Fetch search results when the screen initializes.
  }

  @override
  Widget build(BuildContext context) {
    // Show a loading indicator if search results are not yet available.
    if (searchResults.isEmpty) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return ScreenUtilInit(
      designSize: const Size(400, 875),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: CustomAppBar(
            word1: 'Walpy', // First part of the app title.
            word2: 'App', // Second part of the app title.
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Search bar at the top of the screen.
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Search_Bar(),
              ),
              SizedBox(height: 10.h), // Responsive spacing.

              // Grid view to display search results.
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                height:
                    MediaQuery.of(context).size.height, // Responsive height.
                child: GridView.builder(
                  physics:
                      BouncingScrollPhysics(), // Bouncing effect when scrolling.
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 400.h, // Height of each grid item.
                    crossAxisCount: 2, // Two columns in the grid.
                    crossAxisSpacing:
                        13.w, // Horizontal spacing between grid items.
                    mainAxisSpacing:
                        13.h, // Vertical spacing between grid items.
                  ),
                  itemCount: searchResults.length, // Number of grid items.
                  itemBuilder: (context, index) => GridTile(
                    child: InkWell(
                      onTap: () {
                        // Navigate to the full screen view when an item is tapped.
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreen(
                              imgUrl: searchResults[index].imgSrc,
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: searchResults[index].imgSrc, // Hero animation tag.
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.amberAccent, // Background color.
                            borderRadius:
                                BorderRadius.circular(20.r), // Rounded corners.
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                20.r), // Rounded corners for the image.
                            child: Image.network(
                              searchResults[index].imgSrc, // Display the image.
                              fit: BoxFit
                                  .cover, // Cover the entire area of the container.
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
      ),
    );
  }
}
