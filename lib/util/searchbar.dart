import 'package:flutter/material.dart';

class SearchBarDebt extends StatelessWidget {
  final searchController;
  final VoidCallback searchDb;

  const SearchBarDebt({super.key, required this.searchDb, required this.searchController});

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
                controller: searchController,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(14),
                    border: OutlineInputBorder(),
                    hintText: "Search...",
                    filled: true,
                    fillColor: Color.fromRGBO(245, 245, 245, 1)),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Container(
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(12)),
            child: IconButton(
              icon: const Icon(
                Icons.search_rounded,
                color: Colors.white,
              ),
              onPressed: searchDb,
            ),
          ),
        ],
      ),
    );
  }
}
