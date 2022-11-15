# Reverse geocoding

## Overview
The term *geocoding* generally refers to translating a human-readable address into a location on a map. The process of doing the opposite, translating a location on the map into a human-readable address, is known as *reverse geocoding*.

## Reverse geocoding requests

### Request
A Reverse Geocoding API request takes the following form:

http://{HOST}:{PORT}/geocode/?latlng=LATLNG&parameters

OR

http://{HOST}:{PORT}/maps/api/geocode/json/?latlng=LATLNG&parameters

### Required parameters
* **latlng** — The latitude and longitude values specifying the location for which you wish to obtain the closest, human-readable address.

### Optional parameters
These are the optional parameters that you can include in a reverse geocoding request:

* **language** — The language in which to return results.

  * See the [list of supported languages](https://github.com/mapcirio/mapcir-api/blob/main/docs/language.md). Mapcir often updates the supported languages, so this list may not be exhaustive.

  * If **language** is not supplied, the geocoder attempts to use the preferred language as specified in the Accept-Language header, or the native language of the domain from which the request is sent.

  * The geocoder does its best to provide a street address that is readable for both the user and locals. To achieve that goal, it returns street addresses in the local language, transliterated to a script readable by the user if necessary, observing the preferred language. All other addresses are returned in the preferred language. Address components are all returned in the same language, which is chosen from the first component.

  * If a name is not available in the preferred language, the geocoder uses the closest match.

* **result_type** — A filter of one or more address types, separated by a pipe (**|**). If the parameter contains multiple address types, the API returns all addresses that match any of the types. A note about processing: The **result_type** parameter does not restrict the search to the specified address type(s). Rather, the **result_type** acts as a post-search filter: the API fetches all results for the specified **latlng**, then discards those results that do not match the specified address type(s).The following values are supported:

  * **street_address** indicates a precise street address.

  * **route indicates** a named route (such as "US 101").

  * **intersection** indicates a major intersection, usually of two major roads.

  * **political** indicates a political entity. Usually, this type indicates a polygon of some civil administration.

  * **country** indicates the national political entity, and is typically the highest order type returned by the Geocoder.

  * **administrative_area_level_1** indicates a first-order civil entity below the country level. Within the United States, these administrative levels are states. Not all nations exhibit these administrative levels. In most cases, administrative_area_level_1 short names will closely match ISO 3166-2 subdivisions and other widely circulated lists; however this is not guaranteed as our geocoding results are based on a variety of signals and location data.

  * **administrative_area_level_2** indicates a second-order civil entity below the country level. Within the United States, these administrative levels are counties. Not all nations exhibit these administrative levels.

  * **administrative_area_level_3** indicates a third-order civil entity below the country level. This type indicates a minor civil division. Not all nations exhibit these administrative levels.

  * **administrative_area_level_4** indicates a fourth-order civil entity below the country level. This type indicates a minor civil division. Not all nations exhibit these administrative levels.

  * **administrative_area_level_5** indicates a fifth-order civil entity below the country level. This type indicates a minor civil division. Not all nations exhibit these administrative levels.

  * **administrative_area_level_6** indicates a sixth-order civil entity below the country level. This type indicates a minor civil division. Not all nations exhibit these administrative levels.

  * **administrative_area_level_7** indicates a seventh-order civil entity below the country level. This type indicates a minor civil division. Not all nations exhibit these administrative levels.

  * **colloquial_area** indicates a commonly-used alternative name for the entity.

  * **locality** indicates an incorporated city or town political entity.

  * **sublocality** indicates a first-order civil entity below a locality. For some locations may receive one of the additional types: **sublocality_level_1** to **sublocality_level_5**. Each sublocality level is a civil entity. Larger numbers indicate a smaller geographic area.

  * **neighborhood** indicates a named neighborhood.

  * **premise** indicates a named location, usually a building or collection of buildings with a common name.

  * **subpremise** indicates a first-order entity below a named location, usually a singular building within a collection of buildings with a common name.

  * **plus_code** indicates an encoded location reference, derived from latitude and longitude. Plus codes can be used as a replacement for street addresses in places where they do not exist.

  * **postal_code** indicates a postal code as used to address postal mail within the country.

  * **natural_feature** indicates a prominent natural feature.

  * **airport** indicates an airport.

  * **park** indicates a named park.

  * **point_of_interest** indicates a named point of interest. Typically, these "POI"s are prominent local entities that don't easily fit in another category, such as "Empire State Building" or "Eiffel Tower".

* **location_type** — A filter of one or more location types, separated by a pipe (**|**). If the parameter contains multiple location types, the API returns all addresses that match any of the types. A note about processing: The **location_type** parameter does not restrict the search to the specified location type(s). Rather, the **location_type** acts as a post-search filter: the API fetches all results for the specified **latlng**, then discards those results that do not match the specified location type(s). The following values are supported:

  * **"ROOFTOP"** returns only the addresses for which Mapcir has location information accurate down to street address precision.

  * **"RANGE_INTERPOLATED"** returns only the addresses that reflect an approximation (usually on a road) interpolated between two precise points (such as intersections). An interpolated range generally indicates that rooftop geocodes are unavailable for a street address.

  * **"GEOMETRIC_CENTER"** returns only geometric centers of a location such as a polyline (for example, a street) or polygon (region).

  * **"APPROXIMATE"** returns only the addresses that are characterized as approximate.

If both **result_type** and **location_type** filters are present then the API returns only those results that match both the **result_type** and the **location_type** values. If none of the filter values are acceptable, the API returns **ZERO_RESULTS**.

### Example of reverse geocoding
The following query contains the latitude/longitude value for a location in Brooklyn:

```url
http://127.0.0.1:8080/geocode?latlng=40.714224,-73.961452

OR 

http://127.0.0.1:8080/maps/api/geocode/json?latlng=40.714224,-73.961452
```

> **Note:** Ensure that no space exists between the latitude and longitude values when passed in the latlng parameter.

The above query returns the following result:

```code
{
   "results" : [
      {
         "address_components" : [
            {
               "long_name" : "277",
               "short_name" : "277",
               "types" : [ "street_number" ]
            },
            {
               "long_name" : "Bedford Avenue",
               "short_name" : "Bedford Ave",
               "types" : [ "route" ]
            },
            {
               "long_name" : "Williamsburg",
               "short_name" : "Williamsburg",
               "types" : [ "neighborhood", "political" ]
            },
            {
               "long_name" : "Brooklyn",
               "short_name" : "Brooklyn",
               "types" : [ "sublocality", "political" ]
            },
            {
               "long_name" : "Kings",
               "short_name" : "Kings",
               "types" : [ "administrative_area_level_2", "political" ]
            },
            {
               "long_name" : "New York",
               "short_name" : "NY",
               "types" : [ "administrative_area_level_1", "political" ]
            },
            {
               "long_name" : "United States",
               "short_name" : "US",
               "types" : [ "country", "political" ]
            },
            {
               "long_name" : "11211",
               "short_name" : "11211",
               "types" : [ "postal_code" ]
            }
         ],
         "formatted_address" : "277 Bedford Avenue, Brooklyn, NY 11211, USA",
         "geometry" : {
            "location" : {
               "lat" : 40.714232,
               "lng" : -73.9612889
            },
            "location_type" : "ROOFTOP",
            "viewport" : {
               "northeast" : {
                  "lat" : 40.7155809802915,
                  "lng" : -73.9599399197085
               },
               "southwest" : {
                  "lat" : 40.7128830197085,
                  "lng" : -73.96263788029151
               }
            }
         },
         "place_id" : "ChIJd8BlQ2BZwokRAFUEcm_qrcA",
         "types" : [ "street_address" ]
      },

... Additional <code>results[]</code> ...    
```

Note that the reverse geocoder returned more than one result. The **"formatted_address"** results are not just postal addresses, but any way to geographically name a location. For example, when geocoding a point in the city of Chicago, the geocoded point may be denoted as a street address, as the city (Chicago), as its state (Illinois) or as a country (The United States). All are "addresses" to the geocoder. The reverse geocoder returns any of these types as valid results.

The reverse geocoder matches political entities (countries, provinces, cities and neighborhoods), street addresses, and postal codes.

The full list of formatted_address values returned by the previous query is shown below.

```coce
"formatted_address" : "277 Bedford Avenue, Brooklyn, NY 11211, USA",
"formatted_address" : "Grand St/Bedford Av, Brooklyn, NY 11211, USA",
"formatted_address" : "Grand St/Bedford Av, Brooklyn, NY 11249, USA",
"formatted_address" : "Bedford Av/Grand St, Brooklyn, NY 11211, USA",
"formatted_address" : "Brooklyn, NY 11211, USA",
"formatted_address" : "Williamsburg, Brooklyn, NY, USA",
"formatted_address" : "Brooklyn, NY, USA",
"formatted_address" : "New York, NY, USA",
"formatted_address" : "New York, USA",
"formatted_address" : "United States",
```

enerally, addresses are returned from most specific to least specific; the more exact address is the most prominent result, as it is in this case. Note that we return different types of addresses, from the most specific street address to less specific political entities such as neighborhoods, cities, counties, states, etc. If you wish to match a specific type of address, see the section below on [restricting results by type](#reverse-geocoding-filtered-by-type).

> **Note:** Reverse geocoding is an estimate. The geocoder will attempt to find the closest addressable location within a certain tolerance. If no match is found, the geocoder will return zero results.

### Reverse geocoding filtered by type
The following example filters the addresses returned to include only those with a location type of **ROOFTOP** and an address type of **street_address**.

```code
http://127.0.0.1:8080/geocode?latlng=40.714224,-73.961452
&location_type=ROOFTOP&result_type=street_address

OR

http://127.0.0.1:8080/maps/api/geocode/json?latlng=40.714224,-73.961452
&location_type=ROOFTOP&result_type=street_address
```

> **Note:** These filters are only valid for reverse geocoding.

### Reverse geocoding responses
The format of the reverse geocoding response is the same as the Geocoding response. See [Geocoding responses](https://github.com/mapcirio/mapcir-api/blob/main/docs/geocoding.md). Below are the status codes possible in a reverse geocoding response.

### Reverse geocoding status codes
The **"status"** field within the Geocoding response object contains the status of the request, and may contain debugging information to help you track down why reverse geocoding is not working. The **"status"** field may contain the following values:

* **"OK"** indicates that no errors occurred and at least one address was returned.

* **"ZERO_RESULTS"** indicates that the reverse geocoding was successful but returned no results. This may occur if the geocoder was passed a latlng in a remote location.

* **"OVER_QUERY_LIMIT"** indicates that you are over your quota.

* **"REQUEST_DENIED"** indicates that the request was denied.

* **"INVALID_REQUEST"** generally indicates one of the following:
  * The query (**address**, **components** or **latlng**) is missing.
  * An invalid **result_type** or **location_type** was given.

* **"UNKNOWN_ERROR"** indicates that the request could not be processed due to a server error. The request may succeed if you try again.

