// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class Main_Page extends StatelessWidget {
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final genderController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     CollectionReference users = firestore.collection("users");

//     return MaterialApp(
//       theme: ThemeData.light(),
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           toolbarHeight: 50,
//           centerTitle: true,
//           leadingWidth: 200,
//           title: const Text(
//             "CRUD FIREBASE",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 fontSize: 18,
//                 color: Color.fromARGB(255, 12, 12, 12),
//                 fontWeight: FontWeight.bold),
//           ),
//           backgroundColor: Color.fromARGB(255, 248, 248, 248),
//           actions: [
//             IconButton(
//               icon: Icon(
//                 Icons.add,
//                 size: 35,
//                 color: Color.fromARGB(255, 70, 14, 14),
//               ),
//               onPressed: () {
//                 showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                           title: Form(
//                             // key: _keyDialogForm,
//                             child: Column(
//                               children: <Widget>[
//                                 TextFormField(
//                                   controller: nameController,
//                                   decoration: const InputDecoration(
//                                       icon: Icon(Icons.people),
//                                       hintText: "Input Your Name"),
//                                   // maxLength: 8,
//                                   textAlign: TextAlign.start,
//                                 ),
//                                 TextFormField(
//                                   controller: emailController,
//                                   decoration: const InputDecoration(
//                                       icon: Icon(Icons.email),
//                                       hintText: "Input Your Email"),
//                                   // maxLength: 8,
//                                   textAlign: TextAlign.start,
//                                 ),
//                                 TextFormField(
//                                   controller: genderController,
//                                   decoration: const InputDecoration(
//                                       icon: Icon(Icons.man),
//                                       hintText: "Input Your Gender"),
//                                   // maxLength: 8,
//                                   textAlign: TextAlign.start,
//                                   onSaved: (val) {
//                                     // titleController.text = val;
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                           actions: [
//                             IconButton(
//                               onPressed: () {
//                                 users.add(
//                                   {
//                                     'nama': nameController.text,
//                                     'email': emailController.text,
//                                     'gender': genderController.text,
//                                   },
//                                 );

//                                 nameController.clear();
//                                 emailController.clear();
//                                 genderController.clear();

//                                 Navigator.of(context).pop();
//                               },
//                               icon: const Icon(
//                                 Icons.add,
//                               ),
//                             ),
//                           ],
//                         ));
//               },
//             )
//           ],
//         ),
//         body: Container(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 10,
//               ),
//               StreamBuilder<QuerySnapshot>(
//                 stream: users.snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return Column(
//                         children: snapshot.data!.docs
//                             .map(
//                               (e) => Card(
//                                 color: Colors.white60,
//                                 child: ListTile(
//                                   leading: CircleAvatar(
//                                     backgroundColor:
//                                         Color.fromARGB(255, 15, 15, 15),
//                                     foregroundColor:
//                                         Color.fromARGB(255, 203, 132, 39),
//                                     child: Text(e["nama"][0] ?? "A"),
//                                   ),
//                                   title: Text(e['nama'] ?? ""),
//                                   subtitle: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         e['email'],
//                                       ),
//                                       Text(
//                                         e['gender'],
//                                       ),
//                                     ],
//                                   ),
//                                   trailing: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       IconButton(
//                                         icon: Icon(
//                                           Icons.edit_note,
//                                           color: Colors.green,
//                                         ),
//                                         onPressed: () {
//                                           nameController.text = e["nama"];
//                                           emailController.text = e["email"];
//                                           genderController.text = e["gender"];
//                                           showDialog(
//                                               context: context,
//                                               builder: (context) => AlertDialog(
//                                                     title: Form(
//                                                       // key: _keyDialogForm,
//                                                       child: Column(
//                                                         children: <Widget>[
//                                                           TextFormField(
//                                                             controller:
//                                                                 nameController,
//                                                             decoration: const InputDecoration(
//                                                                 icon: Icon(Icons
//                                                                     .people),
//                                                                 hintText:
//                                                                     "Input Your Name"),
//                                                             // maxLength: 8,
//                                                             textAlign:
//                                                                 TextAlign.start,
//                                                           ),
//                                                           TextFormField(
//                                                             controller:
//                                                                 emailController,
//                                                             decoration: const InputDecoration(
//                                                                 icon: Icon(Icons
//                                                                     .email),
//                                                                 hintText:
//                                                                     "Input Your Email"),
//                                                             // maxLength: 8,
//                                                             textAlign:
//                                                                 TextAlign.start,
//                                                           ),
//                                                           TextFormField(
//                                                             controller:
//                                                                 genderController,
//                                                             decoration:
//                                                                 const InputDecoration(
//                                                                     icon: Icon(
//                                                                         Icons
//                                                                             .man),
//                                                                     hintText:
//                                                                         "Input Your Gender"),
//                                                             // maxLength: 8,
//                                                             textAlign:
//                                                                 TextAlign.start,
//                                                             onSaved: (val) {
//                                                               // titleController.text = val;
//                                                             },
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     actions: [
//                                                       IconButton(
//                                                         onPressed: () {
//                                                           users
//                                                               .doc(e.id)
//                                                               .update(
//                                                             {
//                                                               'nama':
//                                                                   nameController
//                                                                       .text,
//                                                               'email':
//                                                                   emailController
//                                                                       .text,
//                                                               'gender':
//                                                                   genderController
//                                                                       .text,
//                                                             },
//                                                           );

//                                                           nameController
//                                                               .clear();
//                                                           emailController
//                                                               .clear();
//                                                           genderController
//                                                               .clear();

//                                                           Navigator.of(context)
//                                                               .pop();
//                                                         },
//                                                         icon: const Icon(
//                                                           Icons.edit_attributes,
//                                                           color: Colors.green,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ));
//                                         },
//                                       ),
//                                       IconButton(
//                                         icon: Icon(
//                                           Icons.delete_outline,
//                                           color: Colors.red,
//                                         ),
//                                         onPressed: () {
//                                           users.doc(e.id).delete();
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             )
//                             .toList());
//                   } else {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
