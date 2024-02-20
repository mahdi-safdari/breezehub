import 'package:breezehub/features/feature_weather/domain/entities/suggest_city_entity.dart';

/// data : [{"id":3100738,"wikiDataId":"Q1357107","type":"ADM2","city":"Tehri Garhwal district","name":"Tehri Garhwal district","country":"India","countryCode":"IN","region":"Uttarakhand","regionCode":"UT","regionWdId":"Q1499","latitude":30.38,"longitude":78.48,"population":618931,"distance":null,"placeType":"ADM2"},{"id":57751,"wikiDataId":"Q3616","type":"CITY","city":"Tehran","name":"Tehran","country":"Iran","countryCode":"IR","region":"Tehran Province","regionCode":"23","regionWdId":"Q590866","latitude":35.7,"longitude":51.416666666,"population":8693706,"distance":null,"placeType":"CITY"},{"id":3497399,"wikiDataId":"Q643031","type":"ADM2","city":"Tehran County","name":"Tehran County","country":"Iran","countryCode":"IR","region":"Tehran Province","regionCode":"23","regionWdId":"Q590866","latitude":35.683333333,"longitude":51.4,"population":8737510,"distance":null,"placeType":"ADM2"}]
/// metadata : {"currentOffset":0,"totalCount":3}

class SuggestCityModel extends SuggestCityEntity {
  const SuggestCityModel({
    super.data,
    super.metadata,
  });

  factory SuggestCityModel.fromJson(Map<String, dynamic> json) {
    final List<Data> data = [];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
    return SuggestCityModel(
      data: data,
      metadata: json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null,
    );
  }
}

/// currentOffset : 0
/// totalCount : 3

class Metadata {
  num? currentOffset;
  num? totalCount;

  Metadata({this.currentOffset, this.totalCount});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      currentOffset: json['currentOffset'],
      totalCount: json['totalCount'],
    );
  }
}

/// id : 3100738
/// wikiDataId : "Q1357107"
/// type : "ADM2"
/// city : "Tehri Garhwal district"
/// name : "Tehri Garhwal district"
/// country : "India"
/// countryCode : "IN"
/// region : "Uttarakhand"
/// regionCode : "UT"
/// regionWdId : "Q1499"
/// latitude : 30.38
/// longitude : 78.48
/// population : 618931
/// distance : null
/// placeType : "ADM2"

class Data {
  num? id;
  String? wikiDataId;
  String? type;
  String? city;
  String? name;
  String? country;
  String? countryCode;
  String? region;
  String? regionCode;
  String? regionWdId;
  num? latitude;
  num? longitude;
  num? population;
  dynamic distance;
  String? placeType;

  Data({
    this.id,
    this.wikiDataId,
    this.type,
    this.city,
    this.name,
    this.country,
    this.countryCode,
    this.region,
    this.regionCode,
    this.regionWdId,
    this.latitude,
    this.longitude,
    this.population,
    this.distance,
    this.placeType,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      wikiDataId: json['wikiDataId'],
      type: json['type'],
      city: json['city'],
      name: json['name'],
      country: json['country'],
      countryCode: json['countryCode'],
      region: json['region'],
      regionCode: json['regionCode'],
      regionWdId: json['regionWdId'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      population: json['population'],
      distance: json['distance'],
      placeType: json['placeType'],
    );
  }
}
