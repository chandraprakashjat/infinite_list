import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_list/app_bloc_observer.dart';
import 'package:infinite_list/my_app.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
