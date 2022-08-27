part of 'post_bloc.dart';

enum PostStatus { initial, success, fail }

class PostState extends Equatable {
  const PostState(
      {this.hasReachMax = false,
      this.postStatus = PostStatus.initial,
      this.list = const <Post>[]});

  final List<Post> list;
  final PostStatus postStatus;
  final bool hasReachMax;

  PostState copyWith(
      {List<Post>? list, PostStatus? postStatus, bool? hasReachMax}) {
    return PostState(
        list: list ?? this.list,
        postStatus: postStatus ?? this.postStatus,
        hasReachMax: hasReachMax ?? this.hasReachMax);
  }

  @override
  List<Object?> props() => [list, postStatus, hasReachMax];
}
