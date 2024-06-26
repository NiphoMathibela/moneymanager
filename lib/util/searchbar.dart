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
            child: SizedBox(
              height: 54,
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(14),
                  border: OutlineInputBorder(),
                  hintText: "Search...",
                  filled: true,
                  fillColor: Color.fromRGBO(245, 245, 245, 1),
                  prefixIcon: Icon(Icons.search_rounded),
                ),
              ),
            ),
          ),
          // const SizedBox(width: 10.0),
          // IconButton(
          //   icon: const Icon(Icons.clear),
          //   onPressed: () {
          //     _searchController.clear();
          //   },
          // ),
        ],
      ),
    );
  }
}