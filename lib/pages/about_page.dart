import 'package:flutter/material.dart';
import 'package:nuwo/values/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: LightGreen,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          backgroundColor: Colors.white,
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: LightGreen,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 16, 0, 32),
                      child: Image(
                        image: AssetImage('assets/images/logo_square.png'),
                        width: 96,
                        height: 96,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    color: Colors.white,
                    child: ListView(
                      children: <Widget>[
                        ListTile(
                          title: Text('Developed by: SeanErvinson'),
                        ),
                        ListTile(
                          title: Text('SeanErvinson'),
                          leading: Image(
                            image: AssetImage('assets/images/github.png'),
                            height: 32,
                          ),
                          onTap: () =>
                              _launchURL('https://github.com/SeanErvinson'),
                        ),
                        ListTile(
                          title: Text('@ASean___'),
                          leading: Image(
                            image: AssetImage('assets/images/twitter.png'),
                            height: 32,
                          ),
                          onTap: () =>
                              _launchURL('https://twitter.com/ASean___'),
                        ),
                        ListTile(
                          title: Text('Website'),
                          leading: Image(
                            image: AssetImage('assets/images/internet.png'),
                            height: 32,
                          ),
                          onTap: () => _launchURL('https://seanervinson.com'),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: GestureDetector(
                      onTap: () => _launchURL(
                          'https://seanervinson.com/projects/nuwo/privacy-policy'),
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                            fontSize: 16, decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
