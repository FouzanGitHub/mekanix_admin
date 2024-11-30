import 'dart:convert';

AnalyticsData analyticsDataFromJson(String str) =>
    AnalyticsData.fromJson(json.decode(str));

String analyticsDataToJson(AnalyticsData data) => json.encode(data.toJson());

class AnalyticsData {
  List<LoginActivity>? loginActivity;
  List<AccountCreationActivity>? accountCreationActivity;
  List<EngineActivity>? engineActivity;
  List<FormBuilderActivity>? formBuilderActivity;
  List<TemplateActivity>? templateActivity;

  AnalyticsData({
    this.loginActivity,
    this.accountCreationActivity,
    this.engineActivity,
    this.formBuilderActivity,
    this.templateActivity,
  });

  factory AnalyticsData.fromJson(Map<String, dynamic> json) => AnalyticsData(
        loginActivity: json["login_activity"] == null
            ? []
            : List<LoginActivity>.from(
                json["login_activity"].map((x) => LoginActivity.fromJson(x))),
        accountCreationActivity: json["account_creation_activity"] == null
            ? []
            : List<AccountCreationActivity>.from(
                json["account_creation_activity"]
                    .map((x) => AccountCreationActivity.fromJson(x))),
        engineActivity: json["engine_activity"] == null
            ? []
            : List<EngineActivity>.from(
                json["engine_activity"].map((x) => EngineActivity.fromJson(x))),
        formBuilderActivity: json["form_builder_activity"] == null
            ? []
            : List<FormBuilderActivity>.from(json["form_builder_activity"]
                .map((x) => FormBuilderActivity.fromJson(x))),
        templateActivity: json["template_activity"] == null
            ? []
            : List<TemplateActivity>.from(json["template_activity"]
                .map((x) => TemplateActivity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "login_activity": loginActivity == null
            ? []
            : List<dynamic>.from(loginActivity!.map((x) => x.toJson())),
        "account_creation_activity": accountCreationActivity == null
            ? []
            : List<dynamic>.from(
                accountCreationActivity!.map((x) => x.toJson())),
        "engine_activity": engineActivity == null
            ? []
            : List<dynamic>.from(engineActivity!.map((x) => x.toJson())),
        "form_builder_activity": formBuilderActivity == null
            ? []
            : List<dynamic>.from(formBuilderActivity!.map((x) => x.toJson())),
        "template_activity": templateActivity == null
            ? []
            : List<dynamic>.from(templateActivity!.map((x) => x.toJson())),
      };
}

class AccountCreationActivity {
  int? accountCreationCount;
  String? month;

  AccountCreationActivity({
    this.accountCreationCount,
    this.month,
  });

  factory AccountCreationActivity.fromJson(Map<String, dynamic> json) =>
      AccountCreationActivity(
        accountCreationCount: json["account_creation_count"],
        month: json["month"],
      );

  Map<String, dynamic> toJson() => {
        "account_creation_count": accountCreationCount,
        "month": month,
      };
}

class EngineActivity {
  int? engineCreationCount;
  String? month;

  EngineActivity({
    this.engineCreationCount,
    this.month,
  });

  factory EngineActivity.fromJson(Map<String, dynamic> json) => EngineActivity(
        engineCreationCount: json["engine_creation_count"],
        month: json["month"],
      );

  Map<String, dynamic> toJson() => {
        "engine_creation_count": engineCreationCount,
        "month": month,
      };
}

class FormBuilderActivity {
  int? formBuilderActivity;
  String? month;

  FormBuilderActivity({
    this.formBuilderActivity,
    this.month,
  });

  factory FormBuilderActivity.fromJson(Map<String, dynamic> json) =>
      FormBuilderActivity(
        formBuilderActivity: json["form_builder_activity"],
        month: json["month"],
      );

  Map<String, dynamic> toJson() => {
        "form_builder_activity": formBuilderActivity,
        "month": month,
      };
}

class TemplateActivity {
  int? formBuilderActivity;
  String? month;

  TemplateActivity({
    this.formBuilderActivity,
    this.month,
  });

  factory TemplateActivity.fromJson(Map<String, dynamic> json) =>
      TemplateActivity(
        formBuilderActivity: json["form_builder_activity"],
        month: json["month"],
      );

  Map<String, dynamic> toJson() => {
        "form_builder_activity": formBuilderActivity,
        "month": month,
      };
}

class LoginActivity {
  int? loginCount;
  String? month;

  LoginActivity({
    this.loginCount,
    this.month,
  });

  factory LoginActivity.fromJson(Map<String, dynamic> json) => LoginActivity(
        loginCount: json["login_count"],
        month: json["month"],
      );

  Map<String, dynamic> toJson() => {
        "login_count": loginCount,
        "month": month,
      };
}
