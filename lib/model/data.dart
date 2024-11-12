import 'package:puzzle/main.dart';

class Data {
  String? appName;
  String? appIcon;
  String? cover;
  String? mainColor;
  String? contact;
  String? about;
  String? privacy;
  String? terms;
  List<Intro>? intro;
  List<Puzzles>? puzzles;
  List<AdConfig>? adConfig;

  Data({
    this.appName,
    this.appIcon,
    this.cover,
    this.mainColor,
    this.contact,
    this.about,
    this.privacy,
    this.terms,
    this.intro,
    this.puzzles,
    this.adConfig,
  });

  Data.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'];
    appIcon = json['app_icon'];
    cover = json['cover'];
    mainColor = json['main_color'];
    contact = json['contact'];
    about = json['about'];
    privacy = json['privacy'];
    terms = json['terms'];
    if (json['ad_priority'] != null) {
      adConfig = <AdConfig>[];
      json['ad_priority'].forEach((v) {
        adConfig!.add(AdConfig.fromJson(v));
      });

      adConfig!.sort((a, b) => a.priority!.compareTo(b.priority!));

      switch (adConfig![0].network) {
        case 'AdMob':
          selectedAdNetwork = AdNetwork.admob;
          break;
        case 'UnityAds':
          selectedAdNetwork = AdNetwork.unity;
          break;
        case 'MetaAds':
          selectedAdNetwork = AdNetwork.facebook;
          break;
        case 'AppLovin':
          selectedAdNetwork = AdNetwork.applovin;
          break;
      }
    }

    if (json['intro'] != null) {
      intro = <Intro>[];
      json['intro'].forEach((v) {
        intro!.add(Intro.fromJson(v));
      });
    }
    if (json['puzzles'] != null) {
      puzzles = <Puzzles>[];
      json['puzzles'].forEach((v) {
        puzzles!.add(Puzzles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_name'] = appName;
    data['app_icon'] = appIcon;
    data['cover'] = cover;
    data['main_color'] = mainColor;
    data['contact'] = contact;
    data['about'] = about;
    data['privacy'] = privacy;
    data['terms'] = terms;
    if (intro != null) {
      data['intro'] = intro!.map((v) => v.toJson()).toList();
    }
    if (puzzles != null) {
      data['puzzles'] = puzzles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Intro {
  String? title;
  String? description;
  String? icon;

  Intro({this.title, this.description, this.icon});

  Intro.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}

class AdConfig {
  String? network;
  int? priority;

  AdConfig({this.network, this.priority});

  AdConfig.fromJson(Map<String, dynamic> json) {
    network = json['network'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['network'] = network;
    data['priority'] = priority;
    return data;
  }
}

class Puzzles {
  List<String>? images;
  String? level;

  Puzzles({this.images, this.level});

  Puzzles.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['images'] = images;
    data['level'] = level;
    return data;
  }
}
