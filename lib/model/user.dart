class User {
  int id;
  String firstName;
  String lastName;
  String maidenName;
  int age;
  String gender;
  String email;
  String phone;
  String username;
  String password;
  String birthDate;
  String image;
  String token;
  String bloodGroup;
  double height;
  double weight;
  String eyeColor;
  Hair hair;
  String ip;
  Address address;
  String macAddress;
  String university;
  Bank bank;
  Company company;
  String ein;
  String ssn;
  String userAgent;
  Crypto crypto;
  String role;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.maidenName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.username,
    required this.password,
    required this.birthDate,
    required this.image,
    required this.bloodGroup,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hair,
    required this.ip,
    required this.address,
    required this.macAddress,
    required this.university,
    required this.bank,
    required this.company,
    required this.ein,
    required this.ssn,
    required this.userAgent,
    required this.crypto,
    required this.role,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      maidenName: json['maidenName'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      birthDate: json['birthDate'] ?? '',
      image: json['image'] ?? '',
      bloodGroup: json['bloodGroup'] ?? '',
      height: (json['height'] ?? 0).toDouble(),
      weight: (json['weight'] ?? 0).toDouble(),
      eyeColor: json['eyeColor'] ?? '',
      hair: Hair.fromJson(json['hair'] ?? {}),
      ip: json['ip'] ?? '',
      address: Address.fromJson(json['address'] ?? {}),
      macAddress: json['macAddress'] ?? '',
      university: json['university'] ?? '',
      bank: Bank.fromJson(json['bank'] ?? {}),
      company: Company.fromJson(json['company'] ?? {}),
      ein: json['ein'] ?? '',
      ssn: json['ssn'] ?? '',
      userAgent: json['userAgent'] ?? '',
      crypto: Crypto.fromJson(json['crypto'] ?? {}),
      role: json['role'] ?? '',
      token: json['token'] ?? '',
    );
  }
}

class Address {
  String address;
  String city;
  String state;
  String stateCode;
  String postalCode;
  Coordinates coordinates;
  String country;

  Address({
    required this.address,
    required this.city,
    required this.state,
    required this.stateCode,
    required this.postalCode,
    required this.coordinates,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      stateCode: json['stateCode'] ?? '',
      postalCode: json['postalCode'] ?? '',
      country: json['country'] ?? '',
      coordinates: Coordinates.fromJson(json['coordinates'] ?? {}),
    );
  }
}

class Coordinates {
  double lat;
  double lng;

  Coordinates({
    required this.lat,
    required this.lng,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      lat: (json['lat'] ?? 0).toDouble(),
      lng: (json['lng'] ?? 0).toDouble(),
    );
  }
}

class Bank {
  String cardExpire;
  String cardNumber;
  String cardType;
  String currency;
  String iban;

  Bank({
    required this.cardExpire,
    required this.cardNumber,
    required this.cardType,
    required this.currency,
    required this.iban,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      cardExpire: json['cardExpire'] ?? '',
      cardNumber: json['cardNumber'] ?? '',
      cardType: json['cardType'] ?? '',
      currency: json['currency'] ?? '',
      iban: json['iban'] ?? '',
    );
  }
}

class Company {
  String department;
  String name;
  String title;
  Address address;

  Company({
    required this.department,
    required this.name,
    required this.title,
    required this.address,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      department: json['department'] ?? '',
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      address: Address.fromJson(json['address'] ?? {}),
    );
  }
}

class Crypto {
  String coin;
  String wallet;
  String network;

  Crypto({
    required this.coin,
    required this.wallet,
    required this.network,
  });

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      coin: json['coin'] ?? '',
      wallet: json['wallet'] ?? '',
      network: json['network'] ?? '',
    );
  }
}

class Hair {
  String color;
  String type;

  Hair({
    required this.color,
    required this.type,
  });

  factory Hair.fromJson(Map<String, dynamic> json) {
    return Hair(
      color: json['color'] ?? '',
      type: json['type'] ?? '',
    );
  }
}
