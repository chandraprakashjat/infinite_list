import 'dart:convert';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';
import 'dart:async';
import '../post.dart';

part 'post_event.dart';
part 'post_state.dart';

const throttleDuration = Duration(milliseconds: 1000);
const _postLimit = 20;

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;
  final scrollController = ScrollController();
  PostBloc({required this.httpClient}) : super(const PostState()) {
    on<PostFetch>(_mapPostFetchEvent,
        transformer: throttleDroppable(throttleDuration));

    scrollController.addListener(_onScroll);
  }

  FutureOr<void> _mapPostFetchEvent(
      PostFetch event, Emitter<PostState> emit) async {
    //ignore:avoid_print
    print('_mapPostFetchEvent');
    if (state.hasReachMax) return;
    try {
      if (state.postStatus == PostStatus.initial) {
        List<Post> list = await _fetchPost();
        emit(state.copyWith(
            list: list, hasReachMax: false, postStatus: PostStatus.success));
      } else {
        List<Post> loadList = await _fetchPost(state.list.length);

        emit(loadList.isEmpty
            ? state.copyWith(hasReachMax: true)
            : state.copyWith(
                list: [...List.of(state.list), ...loadList],
                hasReachMax: false));
      }
    } catch (error) {
      emit(state.copyWith(postStatus: PostStatus.fail));
    }
  }

/*
 * Fetch Post from Server
 */

  Future<List<Post>> _fetchPost([int start = 0]) async {
    var header = <String, String>{'_start': '$start', '_limit': '$_postLimit'};

    Uri uri = Uri.https('jsonplaceholder.typicode.com', 'posts', header);

    http.Response response = await httpClient.get(uri);

    if (response.statusCode == 200) {
      var decodeJson = jsonDecode(response.body);

      List<Post> list =
          (decodeJson as List).map((e) => Post.fromJson(e)).toList();

      return list;
    }

    throw 'Error in Post Fetch';
  }

  void _onScroll() {
    if (_reachBottom) add(PostFetch());
  }

  bool get _reachBottom {
    if (!scrollController.hasClients) return false;

    final maxScroll = scrollController.position.maxScrollExtent;

    final currentScroll = scrollController.offset;

    return currentScroll >= maxScroll * .9;
  }

  @override
  Future<void> close() {
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    return super.close();
  }
}
