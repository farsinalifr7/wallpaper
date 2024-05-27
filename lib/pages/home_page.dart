import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
      backgroundColor: Colors.grey[300],
      //backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
              child: MasonryGridView.builder(
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
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
                        padding: const EdgeInsets.all(1.2),
                        child: Container(
                          decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.all(
                              //   Radius.circular(16),
                              // ),
                              color: Colors.grey),
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Load more",
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
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
