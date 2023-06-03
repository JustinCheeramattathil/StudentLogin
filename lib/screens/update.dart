import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../functions/db_funs.dart';
import '../model/data_model.dart';
import 'home.dart';

class Updates extends StatefulWidget {
  Updates({super.key, required this.model});
  StudentModel model;
  int? index;

  final TextEditingController _name = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _domain = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  State<Updates> createState() => _UpdatesState();
}

class _UpdatesState extends State<Updates> {
  @override
  void initState() {
    widget._name.text = widget.model.name;
    widget._age.text = widget.model.age;

    widget._phone.text = widget.model.phone;
    widget._domain.text = widget.model.domain;
    super.initState();
  }

  File? image;
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
  }

  Future gallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white24,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Colors.amber,
        title: Center(
          child: Text(
            ' Edit student',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
            child: CircleAvatar(
              backgroundImage: image == null
                  ? FileImage(File(widget.model.img))
                  : FileImage(File(image!.path)) as ImageProvider,
              radius: 70,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  minimumSize: Size(150, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 10),
              child: Column(
                children: const [
                  Icon(
                    Icons.camera_alt_sharp,
                    size: 24.0,
                    color: Colors.black,
                  ),
                  Text(
                    'Edit Image',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.black,
                  context: context,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  builder: (BuildContext) {
                    return SizedBox(
                        height: 200,
                        child: Column(
                          children: [
                            SizedBox(height: 48),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  minimumSize: Size(200, 50)),
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.camera,
                                    color: Colors.black,
                                    size: 24.0,
                                  ),
                                  Text(
                                    'Camera',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              onPressed: () => pickImage(),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  minimumSize: Size(200, 50)),
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.photo,
                                    size: 24.0,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    'Gallery',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              onPressed: () => gallery(),
                            ),
                            // SizedBox(height: 10),
                            // ElevatedButton(
                            //   style: ElevatedButton.styleFrom(
                            //       backgroundColor: Colors.red,
                            //       shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(30)),
                            //       minimumSize: Size(200, 50)),
                            //   child: Column(
                            //     children: const [
                            //       Icon(
                            //         Icons.cancel,
                            //         size: 24.0,
                            //       ),
                            //       Text('Cancel'),
                            //     ],
                            //   ),
                            //   onPressed: () {
                            //     Navigator.pop(context);
                            //   },
                            // ),
                          ],
                        ));
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Form(
              key: widget._formkey,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: widget._name,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      hintText: 'Enter your full name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field cannot be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: widget._age,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      hintText: 'Enter your age',
                      // prefixIcon: Icon(Icons.numbers),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field cannot be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: widget._phone,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'phone',
                      hintText: 'Enter your phone number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        // return 'Field cannot be empty';
                        return 'Phone number (+x xxx-xxx-xxxx)';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: widget._domain,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Domain',
                      hintText: 'Enter your domain',
                      // prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field cannot be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 10,
                      minimumSize: Size(200, 50),
                    ),
                    onPressed: () {
                      log(widget._name.text);
                      addClick(context);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Update',
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.send,
                          size: 24.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                )
              ]))
        ],
      ),
    );
  }

  Future<void> addClick(BuildContext ctx) async {
    final name = widget._name.text.trim();
    final age = widget._age.text.trim();
    final phone = widget._phone.text.trim();
    final domain = widget._domain.text.trim();

    if (widget._formkey.currentState!.validate()) {
      final student = StudentModel(
          id: widget.model.id,
          name: name,
          age: age,
          phone: phone,
          domain: domain,
          img: image == null ? widget.model.img : image!.path);

      await updateStudent(student);

      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
        content: Text('data updated successfully...'),
        margin: EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ));
      Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (context) {
        return const Home();
      }));
    }
  }
}
