import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import './intro.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _darkTheme = false;

  Future<void> _launch(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    }
  }

  Future<void> _launchEmail(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not Launch $url';
    }
  }

  Future _showDialog(BuildContext context) async {
    // flutter defined function
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Developer"),
          content: new Text("Aditya Kushwaha"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future _showSetting(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Setting"),
          content: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text("Dark Theme"),
                trailing: Switch(
                    value: _darkTheme,
                    onChanged: (changed) {
                      setState(() {
                        _darkTheme = changed;
                      });
                    }),
              ),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Center(
                child: Text(
              "Task Manager",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            )),
          ),
          ListTile(
            leading: Icon(
              Icons.collections_bookmark,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              "Instructions",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => App()));
            },
          ),
          ListTile(
            leading:
                Icon(Icons.clear_all, color: Theme.of(context).primaryColor),
            title: Text(
              "About",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () async {
              await _showDialog(context);
            },
          ),
          ListTile(
            leading:
                Icon(Icons.settings, color: Theme.of(context).primaryColor),
            title: Text(
              "Settings",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () async {
              await _showSetting(context);
            },
          ),
          ListTile(
            leading:
                Icon(Icons.content_copy, color: Theme.of(context).primaryColor),
            title: Text(
              "Github",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () =>
                _launch("https://github.com/kaditya97/task_manager_app"),
            trailing: Icon(Icons.open_in_new, color: Colors.blue),
          ),
          ListTile(
            leading: Icon(Icons.email, color: Theme.of(context).primaryColor),
            title: Text(
              "Feedback",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => _launchEmail(
                'mailto:kaditya9711@gmail.com?subject=TaskManager%20app%20feedback&body=Suggestion'),
            trailing: Icon(Icons.open_in_new, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
