// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlacesSearchResponse _$PlacesSearchResponseFromJson(
        Map<String, dynamic> json) =>
    PlacesSearchResponse(
      status: json['status'] as String,
      errorMessage: json['errorMessage'] as String?,
      results: (json['results'] as List<dynamic>?)
              ?.map(
                  (e) => PlacesSearchResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      htmlAttributions: (json['htmlAttributions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      nextPageToken: json['nextPageToken'] as String?,
    );

Map<String, dynamic> _$PlacesSearchResponseToJson(
        PlacesSearchResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'results': instance.results,
      'htmlAttributions': instance.htmlAttributions,
      'nextPageToken': instance.nextPageToken,
    };

PlacesSearchResult _$PlacesSearchResultFromJson(Map<String, dynamic> json) =>
    PlacesSearchResult(
      id: json['id'] as String?,
      reference: json['reference'] as String,
      name: json['name'] as String,
      placeId: json['placeId'] as String,
      formattedAddress: json['formattedAddress'] as String?,
      photos: (json['photos'] as List<dynamic>?)
              ?.map((e) => Photo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      altIds: (json['altIds'] as List<dynamic>?)
              ?.map((e) => AlternativeId.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      permanentlyClosed: json['permanentlyClosed'] as bool? ?? false,
      icon: json['icon'] as String?,
      geometry: json['geometry'] == null
          ? null
          : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
      openingHours: json['openingHours'] == null
          ? null
          : OpeningHoursDetail.fromJson(
              json['openingHours'] as Map<String, dynamic>),
      scope: json['scope'] as String?,
      priceLevel: $enumDecodeNullable(_$PriceLevelEnumMap, json['priceLevel']),
      rating: json['rating'] as num?,
      vicinity: json['vicinity'] as String?,
    );

Map<String, dynamic> _$PlacesSearchResultToJson(PlacesSearchResult instance) =>
    <String, dynamic>{
      'icon': instance.icon,
      'geometry': instance.geometry,
      'name': instance.name,
      'openingHours': instance.openingHours,
      'photos': instance.photos,
      'placeId': instance.placeId,
      'scope': instance.scope,
      'altIds': instance.altIds,
      'priceLevel': _$PriceLevelEnumMap[instance.priceLevel],
      'rating': instance.rating,
      'types': instance.types,
      'vicinity': instance.vicinity,
      'formattedAddress': instance.formattedAddress,
      'permanentlyClosed': instance.permanentlyClosed,
      'id': instance.id,
      'reference': instance.reference,
    };

const _$PriceLevelEnumMap = {
  PriceLevel.free: 0,
  PriceLevel.inexpensive: 1,
  PriceLevel.moderate: 2,
  PriceLevel.expensive: 3,
  PriceLevel.veryExpensive: 4,
};

PlaceDetails _$PlaceDetailsFromJson(Map<String, dynamic> json) => PlaceDetails(
      adrAddress: json['adrAddress'] as String?,
      name: json['name'] as String,
      placeId: json['placeId'] as String,
      utcOffset: json['utcOffset'] as num?,
      id: json['id'] as String?,
      internationalPhoneNumber: json['internationalPhoneNumber'] as String?,
      addressComponents: (json['addressComponents'] as List<dynamic>?)
              ?.map((e) => AddressComponent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      photos: (json['photos'] as List<dynamic>?)
              ?.map((e) => Photo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      reviews: (json['reviews'] as List<dynamic>?)
              ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      formattedAddress: json['formattedAddress'] as String?,
      formattedPhoneNumber: json['formattedPhoneNumber'] as String?,
      reference: json['reference'] as String?,
      icon: json['icon'] as String?,
      rating: json['rating'] as num?,
      openingHours: json['openingHours'] == null
          ? null
          : OpeningHoursDetail.fromJson(
              json['openingHours'] as Map<String, dynamic>),
      priceLevel: $enumDecodeNullable(_$PriceLevelEnumMap, json['priceLevel']),
      scope: json['scope'] as String?,
      url: json['url'] as String?,
      vicinity: json['vicinity'] as String?,
      website: json['website'] as String?,
      geometry: json['geometry'] == null
          ? null
          : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaceDetailsToJson(PlaceDetails instance) =>
    <String, dynamic>{
      'addressComponents': instance.addressComponents,
      'adrAddress': instance.adrAddress,
      'formattedAddress': instance.formattedAddress,
      'formattedPhoneNumber': instance.formattedPhoneNumber,
      'id': instance.id,
      'reference': instance.reference,
      'icon': instance.icon,
      'name': instance.name,
      'openingHours': instance.openingHours,
      'photos': instance.photos,
      'placeId': instance.placeId,
      'internationalPhoneNumber': instance.internationalPhoneNumber,
      'priceLevel': _$PriceLevelEnumMap[instance.priceLevel],
      'rating': instance.rating,
      'scope': instance.scope,
      'types': instance.types,
      'url': instance.url,
      'vicinity': instance.vicinity,
      'utcOffset': instance.utcOffset,
      'website': instance.website,
      'reviews': instance.reviews,
      'geometry': instance.geometry,
    };

OpeningHoursDetail _$OpeningHoursDetailFromJson(Map<String, dynamic> json) =>
    OpeningHoursDetail(
      openNow: json['openNow'] as bool? ?? false,
      periods: (json['periods'] as List<dynamic>?)
              ?.map(
                  (e) => OpeningHoursPeriod.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      weekdayText: (json['weekdayText'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$OpeningHoursDetailToJson(OpeningHoursDetail instance) =>
    <String, dynamic>{
      'openNow': instance.openNow,
      'periods': instance.periods,
      'weekdayText': instance.weekdayText,
    };

OpeningHoursPeriodDate _$OpeningHoursPeriodDateFromJson(
        Map<String, dynamic> json) =>
    OpeningHoursPeriodDate(
      day: json['day'] as int,
      time: json['time'] as String,
    );

Map<String, dynamic> _$OpeningHoursPeriodDateToJson(
        OpeningHoursPeriodDate instance) =>
    <String, dynamic>{
      'day': instance.day,
      'time': instance.time,
    };

OpeningHoursPeriod _$OpeningHoursPeriodFromJson(Map<String, dynamic> json) =>
    OpeningHoursPeriod(
      open: json['open'] == null
          ? null
          : OpeningHoursPeriodDate.fromJson(
              json['open'] as Map<String, dynamic>),
      close: json['close'] == null
          ? null
          : OpeningHoursPeriodDate.fromJson(
              json['close'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OpeningHoursPeriodToJson(OpeningHoursPeriod instance) =>
    <String, dynamic>{
      'open': instance.open,
      'close': instance.close,
    };

Photo _$PhotoFromJson(Map<String, dynamic> json) => Photo(
      photoReference: json['photoReference'] as String,
      height: json['height'] as num,
      width: json['width'] as num,
      htmlAttributions: (json['htmlAttributions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'photoReference': instance.photoReference,
      'height': instance.height,
      'width': instance.width,
      'htmlAttributions': instance.htmlAttributions,
    };

AlternativeId _$AlternativeIdFromJson(Map<String, dynamic> json) =>
    AlternativeId(
      placeId: json['placeId'] as String,
      scope: json['scope'] as String,
    );

Map<String, dynamic> _$AlternativeIdToJson(AlternativeId instance) =>
    <String, dynamic>{
      'placeId': instance.placeId,
      'scope': instance.scope,
    };

PlacesDetailsResponse _$PlacesDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    PlacesDetailsResponse(
      status: json['status'] as String,
      errorMessage: json['errorMessage'] as String?,
      result: PlaceDetails.fromJson(json['result'] as Map<String, dynamic>),
      htmlAttributions: (json['htmlAttributions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$PlacesDetailsResponseToJson(
        PlacesDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'result': instance.result,
      'htmlAttributions': instance.htmlAttributions,
    };

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      authorName: json['authorName'] as String,
      authorUrl: json['authorUrl'] as String,
      language: json['language'] as String?,
      profilePhotoUrl: json['profilePhotoUrl'] as String,
      rating: json['rating'] as num,
      relativeTimeDescription: json['relativeTimeDescription'] as String,
      text: json['text'] as String,
      time: json['time'] as num,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'authorName': instance.authorName,
      'authorUrl': instance.authorUrl,
      'language': instance.language,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'rating': instance.rating,
      'relativeTimeDescription': instance.relativeTimeDescription,
      'text': instance.text,
      'time': instance.time,
    };

PlacesAutocompleteResponse _$PlacesAutocompleteResponseFromJson(
        Map<String, dynamic> json) =>
    PlacesAutocompleteResponse(
      status: json['status'] as String,
      errorMessage: json['errorMessage'] as String?,
      predictions: (json['predictions'] as List<dynamic>?)
              ?.map((e) => Prediction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PlacesAutocompleteResponseToJson(
        PlacesAutocompleteResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'predictions': instance.predictions,
    };

Prediction _$PredictionFromJson(Map<String, dynamic> json) => Prediction(
      description: json['description'] as String?,
      id: json['id'] as String?,
      terms: (json['terms'] as List<dynamic>?)
              ?.map((e) => Term.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      distanceMeters: json['distanceMeters'] as int?,
      placeId: json['placeId'] as String?,
      reference: json['reference'] as String?,
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      matchedSubstrings: (json['matchedSubstrings'] as List<dynamic>?)
              ?.map((e) => MatchedSubstring.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      structuredFormatting: json['structuredFormatting'] == null
          ? null
          : StructuredFormatting.fromJson(
              json['structuredFormatting'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PredictionToJson(Prediction instance) =>
    <String, dynamic>{
      'description': instance.description,
      'id': instance.id,
      'terms': instance.terms,
      'distanceMeters': instance.distanceMeters,
      'placeId': instance.placeId,
      'reference': instance.reference,
      'types': instance.types,
      'matchedSubstrings': instance.matchedSubstrings,
      'structuredFormatting': instance.structuredFormatting,
    };

Term _$TermFromJson(Map<String, dynamic> json) => Term(
      offset: json['offset'] as num,
      value: json['value'] as String,
    );

Map<String, dynamic> _$TermToJson(Term instance) => <String, dynamic>{
      'offset': instance.offset,
      'value': instance.value,
    };

MatchedSubstring _$MatchedSubstringFromJson(Map<String, dynamic> json) =>
    MatchedSubstring(
      offset: json['offset'] as num,
      length: json['length'] as num,
    );

Map<String, dynamic> _$MatchedSubstringToJson(MatchedSubstring instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'length': instance.length,
    };

StructuredFormatting _$StructuredFormattingFromJson(
        Map<String, dynamic> json) =>
    StructuredFormatting(
      mainText: json['mainText'] as String,
      mainTextMatchedSubstrings: (json['mainTextMatchedSubstrings']
                  as List<dynamic>?)
              ?.map((e) => MatchedSubstring.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      secondaryText: json['secondaryText'] as String?,
    );

Map<String, dynamic> _$StructuredFormattingToJson(
        StructuredFormatting instance) =>
    <String, dynamic>{
      'mainText': instance.mainText,
      'mainTextMatchedSubstrings': instance.mainTextMatchedSubstrings,
      'secondaryText': instance.secondaryText,
    };
