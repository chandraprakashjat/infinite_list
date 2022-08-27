import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    //ignore:avoid_print
    print('On Change ${bloc.runtimeType} $change');
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);

    //ignore:avoid_print
    print('On onCreate ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);

    //ignore:avoid_print
    print(' On Event ${bloc.runtimeType} $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);

    //ignore:avoid_print
    print(' onTransition ${bloc.runtimeType} $transition');
  }
}
