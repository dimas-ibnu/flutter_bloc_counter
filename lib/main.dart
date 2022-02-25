import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_event/cubit/counter_cubit.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Bloc Cubit Counter Demo",
        theme: ThemeData(
            primaryColor: Colors.tealAccent,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Increment / Decrement Bloc"),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Text('Current Value is '),
                    BlocConsumer<CounterCubit, CounterState>(
                        builder: (context, state) {
                      return Text(state.counterValue.toString());
                    }, listener: (context, state) {
                      if (state.wasIncremented == true) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("was Incremented"),
                          duration: Duration(milliseconds: 300),
                        ));
                      } else if (state.wasIncremented == false) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("was decremented"),
                          duration: Duration(milliseconds: 300),
                        ));
                      }
                    }),
                  ],
                ),
              ),
              SizedBox(height: 150),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  tooltip: "Increment",
                  child: Icon(Icons.add),
                ),
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  tooltip: "Decrement",
                  child: Icon(Icons.remove),
                ),
              ])
            ]));
  }
}
