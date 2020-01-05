class Link {
  int id;
  String name;
  String url;
  String username;

  Link({this.id, this.name, this.url, this.username});

  Link.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['url'] = this.url;
    data['username'] = this.username;
    return data;
  }
}
