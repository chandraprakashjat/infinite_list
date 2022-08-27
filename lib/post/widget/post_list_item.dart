import 'package:flutter/material.dart';
import 'package:infinite_list/post/model/post.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({super.key, required this.item});

  final Post item;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: ListTile(
        leading: Text(
          '${item.id}',
          style: textTheme.caption,
        ),
        title: Text(item.title),
        subtitle: Text(item.body),
        isThreeLine: true,
        dense: true,
        trailing: Text('${item.userId}'),
      ),
    );
  }
}
