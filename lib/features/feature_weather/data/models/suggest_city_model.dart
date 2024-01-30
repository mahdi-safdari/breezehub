/// data : [{"id":3100738,"wikiDataId":"Q1357107","type":"ADM2","city":"Tehri Garhwal district","name":"Tehri Garhwal district","country":"India","countryCode":"IN","region":"Uttarakhand","regionCode":"UT","regionWdId":"Q1499","latitude":30.38,"longitude":78.48,"population":618931,"distance":null,"placeType":"ADM2"},{"id":57751,"wikiDataId":"Q3616","type":"CITY","city":"Tehran","name":"Tehran","country":"Iran","countryCode":"IR","region":"Tehran Province","regionCode":"23","regionWdId":"Q590866","latitude":35.7,"longitude":51.416666666,"population":8693706,"distance":null,"placeType":"CITY"},{"id":3497399,"wikiDataId":"Q643031","type":"ADM2","city":"Tehran County","name":"Tehran County","country":"Iran","countryCode":"IR","region":"Tehran Province","regionCode":"23","regionWdId":"Q590866","latitude":35.683333333,"longitude":51.4,"population":8737510,"distance":null,"placeType":"ADM2"}]
/// metadata : {"currentOffset":0,"totalCount":3}

class SuggestCityModel {
  SuggestCityModel({
      this.data, 
      this.metadata,});

  SuggestCityModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    metadata = json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
  }
  List<Data>? data;
  Metadata? metadata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    if (metadata != null) {
      map['metadata'] = metadata?.toJson();
    }
    return map;
  }

}

/// currentOffset : 0
/// totalCount : 3

class Metadata {
  Metadata({
      this.currentOffset, 
      this.totalCount,});

  Metadata.fromJson(dynamic json) {
    currentOffset = json['currentOffset'];
    totalCount = json['totalCount'];
  }
  num? currentOffset;
  num? totalCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentOffset'] = currentOffset;
    map['totalCount'] = totalCount;
    return map;
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
      this.placeType,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    wikiDataId = json['wikiDataId'];
    type = json['type'];
    city = json['city'];
    name = json['name'];
    country = json['country'];
    countryCode = json['countryCode'];
    region = json['region'];
    regionCode = json['regionCode'];
    regionWdId = json['regionWdId'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    population = json['population'];
    distance = json['distance'];
    placeType = json['placeType'];
  }
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['wikiDataId'] = wikiDataId;
    map['type'] = type;
    map['city'] = city;
    map['name'] = name;
    map['country'] = country;
    map['countryCode'] = countryCode;
    map['region'] = region;
    map['regionCode'] = regionCode;
    map['regionWdId'] = regionWdId;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['population'] = population;
    map['distance'] = distance;
    map['placeType'] = placeType;
    return map;
  }

}