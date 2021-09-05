import 'package:flutter/material.dart';
import 'package:gundart/gundart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? futureResult;

  // final _textCtl = TextEditingController(text: 'dir');
  Gun? gun;

  void _incrementCounter() {
    gun?
    // setState(() {
    //   futureResult = Gun.init();
    // });
  }

  @override
  void initState() {
    super.initState();
    Gun.getInstance().then((value) => gun = value);
  }

  @override
  void dispose() {
    // _textCtl.dispose();
    gun?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.ac_unit),
        onPressed: _incrementCounter,
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, limits) {
            double width = limits.maxWidth;
            if (width > 500) width = 500;
            return Container(
              width: width,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  // TextField(
                  //   controller: _textCtl,
                  //   decoration: InputDecoration(
                  //     suffixIcon: IconButton(
                  //       icon: Icon(Icons.close),
                  //       onPressed: () {
                  //         _textCtl.clear();
                  //       },
                  //     ),
                  //   ),
                  //   onSubmitted: (str) {
                  //     _incrementCounter();
                  //   },
                  // ),
                  // SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: [
                        // FutureBuilder<String>(
                        //   future: futureResult,
                        //   builder: (context, snap) {
                        //     if (snap.connectionState == ConnectionState.waiting)
                        //       return CircularProgressIndicator();
                        //     return Text('${snap.data}');
                        //   },
                        // ),
                        // Text('${futureResult}'),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
