import 'package:flutter/material.dart';

class PostLoader extends StatelessWidget {
  const PostLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: SizedBox(
          width: 25,
          height: 25,
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
