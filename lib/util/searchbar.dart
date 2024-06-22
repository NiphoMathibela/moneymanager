import 'package:flutter/material.dart';

class SearchBarDebt extends StatefulWidget {
  const SearchBarDebt({super.key});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBarDebt> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Search...",
                filled: true,
                fillColor: Color.fromRGBO(245, 245, 245, 1),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
            },
          ),
        ],
      ),
    );
  }
}