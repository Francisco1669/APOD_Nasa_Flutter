// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ApodModel {
  final String? copyright;
  final DateTime? date;
  final String? explanation;
  final String? hdurl;
  final String? mediaType;
  final String? serviceVersion;
  final String? thumbnailUrl;
  final String? title;
  final String? url;

  const ApodModel({
    this.copyright,
    this.date,
    this.explanation,
    this.hdurl,
    this.mediaType,
    this.serviceVersion,
    this.thumbnailUrl,
    this.title,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'copyright': copyright,
      'date': date?.millisecondsSinceEpoch,
      'explanation': explanation,
      'hdurl': hdurl,
      'mediaType': mediaType,
      'serviceVersion': serviceVersion,
      'thumbnairlUrl': thumbnailUrl,
      'title': title,
      'url': url,
    };
  }

  factory ApodModel.fromMap(Map<String, dynamic> map) {
    return ApodModel(
      copyright: map['copyright'] != null ? map['copyright'] as String : null,
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'] as int)
          : null,
      explanation:
          map['explanation'] != null ? map['explanation'] as String : null,
      hdurl: map['hdurl'] != null ? map['hdurl'] as String : null,
      mediaType: map['mediaType'] != null ? map['mediaType'] as String : null,
      serviceVersion: map['serviceVersion'] != null
          ? map['serviceVersion'] as String
          : null,
      thumbnailUrl:
          map['thumbnairlUrl'] != null ? map['thumbnairlUrl'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApodModel.fromJson(Map<String, dynamic> json) {
    return ApodModel(
      copyright: json['copyright'] ?? '',
      date: json['date'],
      explanation: json['explanation'],
      hdurl: json['hdurl'],
      mediaType: json['media_type'],
      serviceVersion: json['service_version'],
      thumbnailUrl: json['thumbnail_url'],
      title: json['title'],
      url: json['url'],
    );
  }
}
