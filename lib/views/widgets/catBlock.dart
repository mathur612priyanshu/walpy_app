import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walpy_app/views/screen/category.dart';

class CatBlock extends StatelessWidget {
  final String categoryName; // The name of the category.
  final String categoryImgSrc; // The URL of the category image.

  // Constructor to initialize the category name and image source.
  CatBlock({
    super.key,
    required this.categoryName,
    required this.categoryImgSrc,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Wraps the container with an InkWell to detect taps.
      onTap: () {
        // Navigate to the CategoryScreen when tapped.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryScreen(
              catImgUrl: categoryImgSrc,
              catName: categoryName,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: 7.w), // Responsive horizontal margin.
        child: Stack(
          children: [
            // Displays the category image with rounded corners.
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(12.r), // Responsive border radius.
              child: Image.network(
                categoryImgSrc, // Image source.
                height: 50.h, // Responsive height.
                width: 100.w, // Responsive width.
                fit: BoxFit
                    .cover, // Ensures the image covers the entire container.
              ),
            ),
            // Overlay with a semi-transparent black color to enhance text visibility.
            Container(
              height: 50.h, // Responsive height.
              width: 100.w, // Responsive width.
              decoration: BoxDecoration(
                color: Colors.black26, // Semi-transparent black overlay.
                borderRadius:
                    BorderRadius.circular(12.r), // Responsive border radius.
              ),
            ),
            // Positioned text to display the category name.
            Positioned(
              top: 15.h, // Responsive top positioning.
              left: 30.w, // Responsive left positioning.
              child: Text(
                categoryName, // Category name text.
                style: TextStyle(
                  color: Colors.white, // White text color for visibility.
                  fontWeight: FontWeight.w600, // Semi-bold font weight.
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
