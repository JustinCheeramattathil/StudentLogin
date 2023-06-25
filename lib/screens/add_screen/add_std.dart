import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pr_2/provider/provider_statemanagement.dart';
import 'package:provider/provider.dart';

import '../../functions/db_funs.dart';
import '../../model/data_model.dart';
import '../list_student/list_screen.dart';
import 'widgets/imagecolumn.dart';

class Add extends StatefulWidget {
  Add({super.key});

  final TextEditingController _name = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _domain = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
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
        title: Center(child: Text('Add student')),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
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
                  ? AssetImage('images/avatar.png')
                  : FileImage(File(image!.path)) as ImageProvider,
              radius: 70,
              backgroundColor: Colors.amber,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  backgroundColor: Colors.amber,
                  minimumSize: Size(200, 50)),
              child: ImageColumn(),
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
                                    size: 24.0,
                                    color: Colors.black,
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
                      labelStyle: TextStyle(color: Colors.amber),
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
                      labelStyle: TextStyle(color: Colors.amber),
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
                      prefixText: "+91 ",
                      labelText: 'phone',
                      labelStyle: TextStyle(color: Colors.amber),
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
                      labelStyle: TextStyle(color: Colors.amber),
                      hintText: 'Enter your domain',
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
                        minimumSize: Size(200, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () {
                      log(widget._name.text);
                      addClick(context);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Submit',
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
    final img = image!.path;

    if (widget._formkey.currentState!.validate()) {
      final student = StudentModel(
          id: DateTime.now().millisecond.toString(),
          name: name,
          age: age,
          phone: phone,
          domain: domain,
          img: img);

      // await addStudent(student);
      await Provider.of<providerclass>(context, listen: false)
          .addStudent(student);

      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
        content: Text('data added successfully...'),
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
