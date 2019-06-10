import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class CountBLoC {
  int _count;
  StreamController<int> _countController;

  CountBLoC() {
    _count = 0;
    _countController = StreamController<int>.broadcast();
  }

  Stream<int> get value => _countController.stream;

  increment() {
    _countController.sink.add(++_count);
  }

  dispose() {
    _countController.close();
  }
}

class BlocProvider extends InheritedWidget {
  final CountBLoC bLoC = CountBLoC();

  BlocProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static CountBLoC of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).bLoC;
}

void main() => runApp(RootBloc());

class RootBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        home: TestBloc(),
      ),
    );
  }
}

class TestBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => bloc.increment(),
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<int>(
          stream: bloc.value,
          initialData: 0,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            return Text(
              'You hit me: ${snapshot.data} times',
              style: Theme.of(context).textTheme.display1,
            );
          }),
    );
  }
}

class KeepAlive extends StatefulWidget {
  @override
  _KeepAliveState createState() => _KeepAliveState();
}

class _KeepAliveState extends State<KeepAlive>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  bool get wantKeepAlive => true;
}
