import 'package:flutter/material.dart';

class ImageColumn extends StatelessWidget {
  const ImageColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Icon(
          Icons.camera_alt_sharp,
          size: 24.0,
          color: Colors.black,
        ),
        Text(
          'Upload Image',
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}
