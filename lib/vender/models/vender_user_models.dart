class VenderUserModel {
  final bool?   approved;
  final String? venderId;
  final String? businessName;
  final String? cityValue;
  final String? countryValue;
  final String? email;
  final String? phoneNumber;
  final String? stateValue;
  final String? storageImage;
  final String? taxNumber;
  final String? taxRagistered;

  VenderUserModel(  
  { required  this.approved,
    required  this.venderId,
    required  this.businessName,
    required  this.cityValue,
    required  this.countryValue,
    required  this.email,
    required  this.phoneNumber,
    required  this.stateValue,
    required  this.storageImage,
    required  this.taxNumber,
    required  this.taxRagistered });

  VenderUserModel.fromJson(Map<String, Object?> json)
  : this(
      approved: json['approved'] as bool? ?? false,
      venderId: json['venderId'] as String? ?? '',  
      businessName: json['businessName'] as String? ?? '',
      cityValue: json['cityValue'] as String? ?? '',
      countryValue: json['countryValue'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      stateValue: json['stateValue'] as String? ?? '',
      storageImage: json['storageImage'] as String? ?? '',
      taxNumber: json['taxNumber'] as String? ?? '',
      taxRagistered: json['taxRagistered'] as String? ?? '',

      // approved: json['approved'] as bool,
      // venderId: json['venderId'] as String,  
      // businessName: json['businessName'] as String,
      // cityValue: json['cityValue'] as String,
      // countryValue: json['countryValue'] as String,
      // email: json['email'] as String,
      // phoneNumber: json['phoneNumber'] as String,
      // stateValue: json['stateValue'] as String,
      // storageImage: json['storageImage'] as String,
      // taxNumber: json['taxNumber'] as String,
      // taxRagistered: json['taxRagistered'] as String,
  );

  Map<String, Object?> toJson(){
    return{
      'approved' : approved,
      'venderId' : venderId,
      'businessName':businessName,
      'cityValue' : cityValue,
      'countryValue':countryValue,
      'email'  :   email,
      'phoneNumber' :  phoneNumber,
      'stateValue' : stateValue,
      'storageImage' :  storageImage,
      'taxNumber' : taxNumber,
      'taxRagistered': taxRagistered,
    };
  }
}
