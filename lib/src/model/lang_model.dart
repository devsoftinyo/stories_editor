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
  String? cancel;
  String? save;
  String? quit;
  String? saveSuccess;
  String? error;
  String? emptyDraw;

  Dialog(
      {this.title,
      this.body,
      this.cancel,
      this.save,
      this.quit,
      this.saveSuccess,
      this.error,
      this.emptyDraw});

  Dialog.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    cancel = json['cancel'];
    save = json['save'];
    quit = json['quit'];
    saveSuccess = json['saveSuccess'];
    error = json['error'];
    emptyDraw = json['emptyDraw'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['cancel'] = this.cancel;
    data['save'] = this.save;
    data['quit'] = this.quit;
    data['saveSuccess'] = this.saveSuccess;
    data['error'] = this.error;
    data['emptyDraw'] = this.emptyDraw;
    return data;
  }
}
