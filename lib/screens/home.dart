import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import '../functions/db_funs.dart';
import '../model/data_model.dart';
import 'update.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text(
    "Student records",
  );

  @override
  void initState() {
    getAllStudent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        title: Center(child: cusSearchBar),
        backgroundColor: Colors.amber,
        actions: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                if (cusIcon.icon == Icons.search) {
                  cusIcon = Icon(
                    Icons.cancel,
                    color: Colors.black,
                  );
                  cusSearchBar = TextField(
                    onChanged: (value) {
                      search(value);
                    },
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: 'Search',
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  );
                } else {
                  cusIcon = Icon(
                    Icons.search,
                    color: Colors.black,
                  );
                  cusSearchBar = Text("Student records");
                }
              });
            },
            child: SizedBox(
              width: 100,
              child: cusIcon,
            ),
          ),
        ],
      ),
      // appbar
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          color: Colors.amber,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder: (context, value, child) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemBuilder: (ctx, index) {
              log(studentListNotifier.value[index].name);
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60)),
                elevation: 20,
                child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60)),
                    tileColor: Colors.black,
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: FileImage(File(value[index].img))),
                    title: Text(
                      value[index].name,
                      style: TextStyle(color: Colors.amber),
                    ),
                    subtitle: Text(
                      value[index].age,
                      style: TextStyle(color: Colors.amber),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.amber),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Delete?"),
                              content: Text(
                                  "Are you sure you want to delete this item?"),
                              actions: [
                                Center(
                                    child: Image.asset(
                                  'images/delete1.gif',
                                  height: 200,
                                  width: 200,
                                )),
                                TextButton(
                                  child: Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text("Delete"),
                                  onPressed: () {
                                    deleteStudent(ctx, value[index].id);

                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    onTap: () {
                      final student = StudentModel(
                          age: value[index].age,
                          name: value[index].name,
                          phone: value[index].phone,
                          domain: value[index].domain,
                          img: value[index].img,
                          id: value[index].id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Updates(model: student),
                        ),
                      );
                    }),
              );
            },
            separatorBuilder: (ctx, index) {
              return const Divider();
            },
            itemCount: studentListNotifier.value.length,
          ),
        ),
      ),
    );
  }
}
