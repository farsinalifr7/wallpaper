import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:walpaper/pages/image_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List images = [];
  int pageNumber = 0;
  @override
  void initState() {
    fetchApi();
    super.initState();
  }

  Future fetchApi() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=50"),
        headers: {
          "Authorization":
              "LT5gu6XvhNKz1GGD8r4B9hXzhxqvUrqlqqUNjm41hqzBfl09fH4009Y3"
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result["photos"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      body: Column(
        children: <Widget>[
          Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 1 / 1.2),
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImagePage(
                              image: images[index]["src"]["large2x"],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.grey),
                          child: Image.network(
                            images[index]["src"]["tiny"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  })),
          Container(
            height: 50,
            color: Colors.black,
            child: InkWell(
              onTap: () {
                loadMore();
              },
              child: Container(
                child: const Center(
                  child: Text(
                    "Load more",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void loadMore() async {
    pageNumber++;
    String url =
        "https://api.pexels.com/v1/curated?per_page=50&page=$pageNumber";

    await http.get(Uri.parse(url), headers: {
      "Authorization":
          "LT5gu6XvhNKz1GGD8r4B9hXzhxqvUrqlqqUNjm41hqzBfl09fH4009Y3"
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result["photos"]);
      });
    });
  }
}
