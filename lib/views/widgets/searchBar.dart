import 'package:flutter/material.dart';
import 'package:walpy_app/views/screen/search.dart';

class Search_Bar extends StatelessWidget {
  Search_Bar({super.key});

  // Controller to manage the text input
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.black12,
        border: Border.all(color: Colors.black45),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              // Trigger search on "Go" button press
              textInputAction: TextInputAction.go,
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  // Navigate to the search screen with the entered query
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(query: query),
                    ),
                  );
                }
              },
              decoration: const InputDecoration(
                hintText: "Search Wallpaper",
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              final query = _searchController.text;
              if (query.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(query: query),
                  ),
                );
              }
            },
            child: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
