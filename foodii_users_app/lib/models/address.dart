class Address{
  String? name;
  String? phoneNumber;
  String? flatNmuber;
  String? city;
  String? state;
  String? fullAddress;
  double? lat;
  double? lng;

  Address({
    this.name,
    this.phoneNumber,
    this.flatNmuber,
    this.city,
    this.state,
    this.fullAddress,
    this.lat,
    this.lng
  });

  Address.fromJson(Map<String, dynamic> json){
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    flatNmuber = json['flatNmuber'];
    city = json['city'];
    state = json['state'];
    fullAddress = json['fullAddress'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['flatNmuber'] = flatNmuber;
    data['city'] = city;
    data['state'] = state;
    data['fullAddress'] = fullAddress;
    data['lat'] = lat;
    data['lng'] = lng;

    return data;
  }
}