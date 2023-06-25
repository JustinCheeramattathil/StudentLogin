import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pr_2/provider/provider_statemanagement.dart';
import 'package:provider/provider.dart';

import '../../functions/db_funs.dart';
import '../../model/data_model.dart';
import '../update_screen/update_std.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        title: Center(child: context.watch<providerclass>().cusSearchBar),
        backgroundColor: Colors.amber,
        actions: <Widget>[
          Consumer<providerclass>(
            builder: (context, value, child) {
              return InkWell(
                onTap: () {
                  context.read<providerclass>().transform();
                },
                child: SizedBox(
                  width: 100,
                  child: value.cusIcon,
                ),
              );
            },
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
      body: Consumer<providerclass>(
        builder: (context, value, child) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemBuilder: (ctx, index) {
              final data = value.StudentList[index];
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60)),
                elevation: 20,
                child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60)),
                    tileColor: Colors.black,
                    leading: CircleAvatar(
                        radius: 30, backgroundImage: FileImage(File(data.img))),
                    title: Text(
                      data.name,
                      style: TextStyle(color: Colors.amber),
                    ),
                    subtitle: Text(
                      data.age,
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
                                    value.deleteStudent(
                                        context, data.id.toString());

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
                          age: data.age,
                          name: data.name,
                          phone: data.phone,
                          domain: data.domain,
                          img: data.img,
                          id: data.id);
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
            itemCount: value.StudentList.length,
          ),
        ),
      ),
    );
  }
}
