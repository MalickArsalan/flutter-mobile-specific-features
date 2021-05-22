import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const String emailSupportUrl = "mailto:support@globomantics.com";
const String emailCeoUrl = "mailto:federico@globomantics.com";

const String telTechUrl = "tel:+4477779112231";
const String telLangUrl = "tel:+4477779112233";
const String telSalesUrl = "tel:+4477779112235";

const String smsSupportUrl = "sms:+4477779112237";
const String smsCeoUrl = "sms:+4477779112239";

class ContactWidget extends StatefulWidget {
  @override
  _ContactState createState() {
    return _ContactState();
  }
}

class _ContactState extends State<ContactWidget> {
  int _currentlyExpanded;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ExpansionTile(
        key: UniqueKey(),
        initiallyExpanded: _currentlyExpanded == 1,
        onExpansionChanged: (v) => _handleExpansion(1, v),
        title: Text("Contact us by email",
            style: TextStyle(
                fontSize: 29.0,
                fontWeight: FontWeight.normal,
                color: Colors.blueAccent)),
        subtitle: Text(
          "We usually respond within 24 hours",
          style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.normal,
              color: Colors.blueAccent),
        ),
        children: [
          ListTile(
            title: Text(
              "Email Support",
              style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.blueAccent),
            ),
            subtitle: Text(
              "Get in touch with our wonderful support team",
              style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.blueAccent),
            ),
            trailing: FutureBuilder(
              future: canLaunch(emailSupportUrl),
              builder: (context, snapshot) {
                return IconButton(
                  icon: Icon(Icons.email_outlined),
                  color: Colors.pinkAccent,
                  onPressed: snapshot.hasData && snapshot.data
                      ? () => launch(emailSupportUrl)
                      : null,
                );
              },
            ),
          ),
          ListTile(
            title: Text(
              "Email the CEO",
              style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.blueAccent),
            ),
            subtitle: Text(
              "You can contact Federico Mestrone himself!",
              style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.blueAccent),
            ),
            trailing: FutureBuilder(
              future: canLaunch(emailCeoUrl),
              builder: (context, snapshot) {
                return IconButton(
                    icon: Icon(Icons.email_outlined),
                    color: Colors.pinkAccent,
                    onPressed: snapshot.hasData && snapshot.data
                        ? () => launch(emailCeoUrl)
                        : null);
              },
            ),
          ),
        ],
      ),
      ExpansionTile(
        key: UniqueKey(),
        initiallyExpanded: _currentlyExpanded == 2,
        onExpansionChanged: (v) => _handleExpansion(2, v),
        title: Text("Give us a call",
            style: TextStyle(
                fontSize: 29.0,
                fontWeight: FontWeight.normal,
                color: Colors.blueAccent)),
        subtitle: Text("Monday to Friday, from 9am to 5pm",
            style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.normal,
                color: Colors.blueAccent)),
        children: [
          ListTile(
            title: Text("Phone Technical Support",
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.blueAccent)),
            subtitle: Text("for any technical issue with the app",
                style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.blueAccent)),
            trailing: FutureBuilder(
                future: canLaunch(telTechUrl),
                builder: (context, snapshot) {
                  return IconButton(
                      icon: Icon(Icons.phone),
                      color: Colors.indigoAccent,
                      onPressed: snapshot.hasData && snapshot.data
                          ? () => launch(telTechUrl)
                          : null);
                }),
          ),
          ListTile(
            title: Text("Phone Language Support",
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.blueAccent)),
            subtitle: Text("if you have Japanese-related questions",
                style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.blueAccent)),
            trailing: FutureBuilder(
                future: canLaunch(telLangUrl),
                builder: (context, snapshot) {
                  return IconButton(
                      icon: Icon(Icons.phone),
                      color: Colors.indigoAccent,
                      onPressed: snapshot.hasData && snapshot.data
                          ? () => launch(telLangUrl)
                          : null);
                }),
          ),
          ListTile(
            title: Text("Phone Sales",
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.blueAccent)),
            subtitle: Text(
                "to place a bulk order for your employees or students",
                style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.blueAccent)),
            trailing: FutureBuilder(
                future: canLaunch(telSalesUrl),
                builder: (context, snapshot) {
                  return IconButton(
                      icon: Icon(Icons.phone),
                      color: Colors.indigoAccent,
                      onPressed: snapshot.hasData && snapshot.data
                          ? () => launch(telSalesUrl)
                          : null);
                }),
          )
        ],
      ),
      ExpansionTile(
        key: UniqueKey(),
        initiallyExpanded: _currentlyExpanded == 3,
        onExpansionChanged: (v) => _handleExpansion(3, v),
        title: Text("Send us a text message",
            style: TextStyle(
                fontSize: 29.0,
                fontWeight: FontWeight.normal,
                color: Colors.blueAccent)),
        subtitle: Text("We aim to text back within 12 hours",
            style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.normal,
                color: Colors.blueAccent)),
        children: [
          ListTile(
            title: Text("Text Support",
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.blueAccent)),
            subtitle: Text("Get in touch with our wonderful support team",
                style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.blueAccent)),
            trailing: FutureBuilder(
                future: canLaunch(smsSupportUrl),
                builder: (context, snapshot) {
                  return IconButton(
                      icon: Icon(Icons.sms_outlined),
                      color: Colors.green,
                      onPressed: snapshot.hasData && snapshot.data
                          ? () => launch(smsSupportUrl)
                          : null);
                }),
          ),
          ListTile(
            title: Text("Text the CEO",
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.blueAccent)),
            subtitle: Text("You can text Federico Mestrone himself!",
                style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.blueAccent)),
            trailing: FutureBuilder(
                future: canLaunch(smsCeoUrl),
                builder: (context, snapshot) {
                  return IconButton(
                      icon: Icon(Icons.sms_outlined),
                      color: Colors.green,
                      onPressed: snapshot.hasData && snapshot.data
                          ? () => launch(smsCeoUrl)
                          : null);
                }),
          )
        ],
      ),
    ]);
  }

  void _handleExpansion(int index, bool expanding) {
    // for the demo this was inlined within the callback to make it easier to see
    setState(() {
      _currentlyExpanded = expanding ? index : null;
    });
  }
}
