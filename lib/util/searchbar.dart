import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [TextField(), Icon(Icons.search_rounded)],
      ),
    );
  }
}