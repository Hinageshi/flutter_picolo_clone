import 'package:flutter/material.dart';
import 'package:flutter_picolo_clone/services/json_handler_service.dart';
import 'package:flutter_picolo_clone/view/home_page.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MultiProvider(
      providers: [
        Provider<JsonHandlerService>.value(value: JsonHandlerService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'After Class',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
