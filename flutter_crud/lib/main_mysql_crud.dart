// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, use_build_context_synchronously, duplicate_ignore

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Ambil Data via API - GET
Future<http.Response> getData() async {
  // const lokal = "192.168.43.176";
  final response =
      await http.get(Uri.parse("http://192.168.43.176:8082/api/users/getAll"));
  return response;
}

// Kirim Data via API - POST
Future<http.Response> postData(Map<String, String> data) async {
  final response =
      await http.post(Uri.parse("http://192.168.43.176:8082/api/users/insert"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data));
  print(response.statusCode);
  print(response.body);
  return response;
}

// Ubah Data via API - Update
Future<http.Response> updateData(id) async {
  Map<String, dynamic> data = {
    "nama": up1.text,
    "email": up2.text,
    "usia": up3.text,
  };

  final response = await http.put(
      Uri.parse("http://192.168.43.176:8082/api/users/update/${id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data));
  print(response.statusCode);
  print(response.body);

  return response;
}

// Hapus Data API - DELETE
Future<http.Response> deleteData(int id) async {
  final response = await http.delete(
      Uri.parse("http://192.168.43.176:8082/api/users/delete/${id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
  print(response.statusCode);
  print(response.body);
  return response;
}

final addUser1 = TextEditingController();
final addUser2 = TextEditingController();
final addUser3 = TextEditingController();

final up1 = TextEditingController();
final up2 = TextEditingController();
final up3 = TextEditingController();

class NetworkingResponse extends StatefulWidget {
  const NetworkingResponse({super.key});

  @override
  State<NetworkingResponse> createState() => _NetworkingResponseState();
}

class _NetworkingResponseState extends State<NetworkingResponse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("MyApps"),
          backgroundColor: Colors.red,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    scrollable: true,
                    title: const Text("Tambah Data"),
                    content: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Form(
                          child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: addUser1,
                            decoration: const InputDecoration(
                                icon: Icon(Icons.person_pin_rounded),
                                labelText: "Nama"),
                          ),
                          TextFormField(
                            controller: addUser2,
                            decoration: const InputDecoration(
                                icon: Icon(Icons.email), labelText: "Email"),
                          ),
                          TextFormField(
                            controller: addUser3,
                            decoration: const InputDecoration(
                                icon: Icon(Icons.face), labelText: "Usia"),
                          ),
                        ],
                      )),
                    ),
                    actions: [
                      ElevatedButton(
                        // ignore: duplicate_ignore
                        onPressed: () async {
                          await postData({
                            "nama": addUser1.text,
                            "email": addUser2.text,
                            "usia": addUser3.text,
                          });
                          setState(() {});
                          addUser1.clear();
                          addUser2.clear();
                          addUser3.clear();
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        },
                        child: const Text("Submit"),
                      ),
                    ],
                  );
                });
          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<dynamic> json = jsonDecode(snapshot.data!.body);
                return ListView.builder(
                  itemCount: json.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(json[index]["nama"]),
                      subtitle: Text(json[index]["email"]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Edit
                          IconButton(
                            icon: const Icon(Icons.edit_outlined),
                            onPressed: () {
                              up1.text = json[index]["nama"];
                              up2.text = json[index]["email"];
                              up3.text = json[index]["usia"];
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      scrollable: true,
                                      title: const Text("Update Data"),
                                      content: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Form(
                                            child: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              controller: up1,
                                              decoration: const InputDecoration(
                                                  icon: Icon(
                                                      Icons.person_pin_rounded),
                                                  labelText: "Nama"),
                                            ),
                                            TextFormField(
                                              controller: up2,
                                              decoration: const InputDecoration(
                                                  icon: Icon(Icons.email),
                                                  labelText: "Email"),
                                            ),
                                            TextFormField(
                                              controller: up3,
                                              decoration: const InputDecoration(
                                                  icon: Icon(Icons.face),
                                                  labelText: "Usia"),
                                            ),
                                          ],
                                        )),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            await updateData(
                                              json[index]["id"],
                                            );
                                            up1.clear;
                                            up2.clear;
                                            up3.clear;

                                            setState(() {});
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Update"),
                                        ),
                                      ],
                                    );
                                  });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              await deleteData(json[index]["id"]);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (snapshot.hasData) {
                return Text('${snapshot.error}');
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}

class HttpRequest extends StatelessWidget {
  const HttpRequest({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NetworkingResponse(),
    );
  }
}
