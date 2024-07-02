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
                  fillColor: Color.fromRGBO(245, 245, 245, 1)
                ),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Container(
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12)),
            child: IconButton(
              icon: const Icon(Icons.search_rounded, color: Colors.white,),
              onPressed: () {
                _searchController.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}