import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_list/post/bloc/post_bloc.dart';

import '../post.dart';

class PostList extends StatelessWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post List'),
      ),
      body: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
        switch (state.postStatus) {
          case PostStatus.initial:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case PostStatus.success:
            if (state.list.isEmpty) {
              return const Center(
                child: Text('No Post Found'),
              );
            }

            return ListView.builder(
                controller: context.read<PostBloc>().scrollController,
                itemCount: state.hasReachMax
                    ? state.list.length
                    : state.list.length + 1,
                itemBuilder: (context, index) {
                  return index >= state.list.length
                      ? const PostLoader()
                      : PostListItem(item: state.list[index]);
                });

          case PostStatus.fail:
            return const Center(
              child: Text('Error in Post Load'),
            );
        }
      }),
    );
  }
}
