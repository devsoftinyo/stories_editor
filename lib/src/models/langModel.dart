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
  String? save;

  String? quit;
  String? error;
  String? emptyDraw;

  Dialog(
      {this.title,
      this.body,
      this.delete,
      this.save,
      this.quit,
      this.error,
      this.emptyDraw});

  Dialog.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    delete = json['cancel'];
    save = json['save'];
    quit = json['saveSuccess'];
    error = json['error'];
    emptyDraw = json['emptyDraw'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['cancel'] = this.delete;
    data['save'] = this.save;
    data['saveSuccess'] = this.quit;
    data['error'] = this.error;
    data['emptyDraw'] = this.emptyDraw;
    return data;
  }
}
