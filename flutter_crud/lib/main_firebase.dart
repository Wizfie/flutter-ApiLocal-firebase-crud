import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FirebaseApi(),
    );
  }
}

final nama = TextEditingController();
final email = TextEditingController();
final upnama = TextEditingController();
final upemail = TextEditingController();

class FirebaseApi extends StatefulWidget {
  const FirebaseApi({super.key});

  @override
  State<FirebaseApi> createState() => _FirebaseApiState();
}

class _FirebaseApiState extends State<FirebaseApi> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        scrollable: true,
                        title: const Center(
                            child: Text(
                          "Tambah Data",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        content: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Form(
                              child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: nama,
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.person),
                                    labelText: "Username"),
                              ),
                              TextFormField(
                                controller: email,
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.email),
                                    labelText: "Email"),
                              )
                            ],
                          )),
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () async {
                                await users.add(
                                    {"nama": nama.text, "email": email.text});
                                setState(() {});
                                nama.clear();
                                email.clear();
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pop();
                              },
                              child: const Text("Submit"))
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.add))
        ],
        title: const Text("Firebase crud"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: users.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: snapshot.data!.docs
                    .map(
                      (e) => ListTile(
                        title: Text(e["nama"]),
                        subtitle: Text(e["email"]),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                upnama.text = e["nama"];
                                upemail.text = e["email"];
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        scrollable: true,
                                        title: const Center(
                                            child: Text(
                                          "Edit Data",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                        content: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Form(
                                              child: Column(
                                            children: <Widget>[
                                              TextFormField(
                                                controller: upnama,
                                                decoration:
                                                    const InputDecoration(
                                                        icon:
                                                            Icon(Icons.person),
                                                        labelText: "Username"),
                                              ),
                                              TextFormField(
                                                controller: upemail,
                                                decoration:
                                                    const InputDecoration(
                                                        icon: Icon(Icons.email),
                                                        labelText: "Email"),
                                              )
                                            ],
                                          )),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                users.doc(e.id).update({
                                                  "nama": nama,
                                                  "email": email
                                                });
                                                setState(() {});
                                                nama.clear();
                                                email.clear();
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Update"))
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                users.doc(e.id).delete();
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
