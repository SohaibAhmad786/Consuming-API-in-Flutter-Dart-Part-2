import 'dart:convert';

import 'package:api_part2/Model/PhotosModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShowApiData extends StatefulWidget {
  const ShowApiData({Key? key}) : super(key: key);

  @override
  State<ShowApiData> createState() => _ShowApiDataState();
}

List<PhotosModel> plist = [];

class _ShowApiDataState extends State<ShowApiData> {
  Future<List<PhotosModel>> getPhotos() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      plist.clear();
      for (var i in data) {
        plist.add(PhotosModel.fromJson(i));
      }
      return plist;
    } else {
      return plist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Consuming API",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotos(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text(
                      "Loading",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: plist.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(plist[index].url.toString()),
                            ),
                            title: Text(
                              plist[index].id.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              plist[index].title.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  plist[index].thumbnailUrl.toString()),
                            ),
                          );
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}
