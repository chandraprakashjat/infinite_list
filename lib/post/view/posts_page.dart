import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_list/post/bloc/post_bloc.dart';
import 'package:http/http.dart' as http;

import 'view.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      create: (_) => PostBloc(httpClient: http.Client())..add(PostFetch()),
      child: const PostList(),
    );
  }
}
