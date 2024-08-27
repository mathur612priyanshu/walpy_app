import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A custom AppBar widget that displays two words with different styles.
/// It uses RichText to combine the words and applies different colors and
/// font weights to each word for a distinctive look.
class CustomAppBar extends StatelessWidget {
  final String word1;
  final String word2;

  /// Constructor to initialize the words displayed in the AppBar.
  CustomAppBar({super.key, required this.word1, required this.word2});

  @override
  Widget build(BuildContext context) {
    return Container(
      // RichText allows combining multiple TextSpans with different styles.
      child: RichText(
        text: TextSpan(
          // The first word with black color and bold style.
          text: word1,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp, // Responsive font size
            fontWeight: FontWeight.w600,
          ),
          children: [
            // The second word with orange accent color and bold style.
            TextSpan(
              text: word2,
              style: TextStyle(
                color: Colors.orangeAccent,
                fontSize: 20.sp, // Responsive font size
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
