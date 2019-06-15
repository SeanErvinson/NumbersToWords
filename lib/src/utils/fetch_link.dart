import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nuwo/src/models/link.dart';

class FetchLink {
  Future<List<Link>> fetchLinks() async {
    var response = await _fetchPost();
    if (response.statusCode == 200) {
      var links = (json.decode(response.body) as List)
          .map((link) => Link.fromJson(link))
          .toList();
      return links;
    } else {
      var links = [];
      links.add(Link(
          name: "Email", username: null, url: "seanervinsonong@gmail.com"));
      links.add(Link(
          name: "Twitter",
          username: "@ASean",
          url: "https://www.twitter.com/ASean___"));
      links.add(Link(
          name: "GitHub",
          username: "SeanErvinson",
          url: "https://www.github.com/SeanErvinson"));
      return links;
    }
  }

  Future<http.Response> _fetchPost() {
    return http.get('https://seanervinson.com/api/link/');
  }
}
