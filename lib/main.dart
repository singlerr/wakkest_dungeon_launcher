import 'dart:io';
import 'dart:io' show Platform;

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:process_run/shell.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => const Launcher(),
  ));
}

class Launcher extends StatelessWidget {
  const Launcher({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wakest Dungeon Launcher',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const LauncherPage(title: 'Wakest Dungeon Launcher v1.0'),
    );
  }
}

class LauncherPage extends StatefulWidget {
  const LauncherPage({super.key, required this.title});

  final String title;

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {

  String _test = "";
  void launch() async {
    String executable = "\"runtime\\windows\\bin\\java.exe\"";
    if (Platform.isMacOS) {
      executable = "./runtime/macosx/bin/java";
    }
    setState(() {
      _test = Directory.current.path;
    });
    String script =
        "$executable -jar ${Directory.current.path}\\app\\desktop-1.0.jar";
    await Shell().run(script, onProcess: (process) {
      exit(1);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 500,
              height: 100,
              child: ElevatedButton(
                onPressed: launch,
                child: Text(_test,
                    style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontSize: 50,
                        fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
