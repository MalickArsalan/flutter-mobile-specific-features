import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SampleCodeWidget extends StatefulWidget {
  @override
  _SampleCodeState createState() {
    return _SampleCodeState();
  }
}

class _SampleCodeState extends State<SampleCodeWidget> {
  bool forceSafariVC = false;
  bool forceWebView = false;
  bool enableJavaScript = false;
  bool enableDomStorage = false;
  // bool universalLinksOnly = false;
  Brightness statusBarBrightness = Brightness.dark;
  String urlString = "";

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(13.0),
          child: TextField(
            onChanged: (value) {
              setState(() => urlString = value);
            },
            decoration: InputDecoration(
              labelText: 'URL',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ListTile(
          title: Text(
            'forceSafariVC',
          ),
          leading: Switch(
              value: forceSafariVC,
              activeColor: Color(Colors.blueAccent.value),
              onChanged: (bool value) {
                setState(() {
                  forceSafariVC = value;
                });
              }),
        ),
        ListTile(
          title: Text(
            'forceWebView',
          ),
          leading: Switch(
              value: forceWebView,
              activeColor: Color(Colors.blueAccent.value),
              onChanged: (bool value) {
                setState(() {
                  forceWebView = value;
                });
              }),
        ),
        ListTile(
          title: Text(
            'enableJavaScript',
          ),
          leading: Switch(
              value: enableJavaScript,
              activeColor: Color(Colors.blueAccent.value),
              onChanged: (bool value) {
                setState(() {
                  enableJavaScript = value;
                });
              }),
        ),
        ListTile(
          title: Text(
            'enableDomStorage',
          ),
          leading: Switch(
              value: enableDomStorage,
              activeColor: Color(Colors.blueAccent.value),
              onChanged: (bool value) {
                setState(() {
                  enableDomStorage = value;
                });
              }),
        ),
        // ListTile(
        //   title: Text(
        //     'universalLinksOnly',
        //   ),
        //   leading: Switch(
        //       value: universalLinksOnly,
        //       activeColor: Color(Colors.blueAccent.value),
        //       onChanged: (bool value) { setState(() { universalLinksOnly = value; }); }
        //   ),
        // ),
        ListTile(
          title: Text(
            'statusBarBrightness',
          ),
          leading: Switch(
              value: statusBarBrightness == Brightness.light,
              activeColor: Color(Colors.black.value),
              inactiveThumbColor: Color(Colors.white.value),
              onChanged: (bool value) {
                setState(() {
                  statusBarBrightness = (statusBarBrightness == Brightness.light
                      ? Brightness.dark
                      : Brightness.light);
                });
              }),
        ),
        TextButton(
          child: Text('Can Launch URL?'),
          onPressed: () async {
            bool isOk = await canLaunch(urlString);
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Can Launch the URL?"),
                    content: Text(isOk ? "YES, PLEASE :)" : "NO, SORRY :("),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Ok',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  );
                });
          },
        ),
        FutureBuilder(
            future: canLaunch(urlString),
            builder: (context, snapshot) {
              return TextButton(
                  child: Text('Launch URL'),
                  onPressed: snapshot.hasData && snapshot.data
                      ? () {
                          launch(
                            urlString,
                            forceSafariVC: forceSafariVC,
                            statusBarBrightness: statusBarBrightness,
                            forceWebView: forceWebView,
                            enableJavaScript: enableJavaScript,
                            enableDomStorage: enableDomStorage,
                            // universalLinksOnly: universalLinksOnly,
                          );
                        }
                      : null);
            })
      ],
    );
  }
}
