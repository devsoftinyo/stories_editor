class langModel {
  Dialog? dialog;

  langModel({this.dialog});

  langModel.fromJson(Map<String, dynamic> json) {
    dialog =
        json['dialog'] != null ? new Dialog.fromJson(json['dialog']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dialog != null) {
      data['dialog'] = this.dialog!.toJson();
    }
    return data;
  }
}

class Dialog {
  String? title;
  String? body;
  String? delete;
  String? quit;
  String? share;
  String? tapToType;

  Dialog(
      {this.title,
      this.body,
      this.delete,
      this.quit,
      this.share,
      this.tapToType});

  Dialog.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    delete = json['delete'];
    quit = json['quit'];
    share = json['share'];
    tapToType = json['tapToType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['delete'] = this.delete;
    data['quit'] = this.quit;
    data['share'] = this.share;
    data['tapToType'] = this.tapToType;
    return data;
  }
}
