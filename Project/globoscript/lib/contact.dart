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
        subtitle: Text("We usually respond within 24 hours",
            style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.normal,
                color: Colors.blueAccent)),
      )
    ]);
  }

  void _handleExpansion(int index, bool expanding) {
    // for the demo this was inlined within the callback to make it easier to see
    setState(() {
      _currentlyExpanded = expanding ? index : null;
    });
  }
}
