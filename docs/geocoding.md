# Geocoding API
> Convert addresses or Place IDs to latitude/longitude coordinates.

## Overview
[Geocoding](./geocoding.md) is the process of converting addresses (like "1600 Amphitheatre Parkway, Mountain View, CA") into geographic coordinates (like latitude 37.423021 and longitude -122.083739), which you can use to place markers or position the map.

[Reverse geocoding](./reversegeocoding.md) is the process of converting geographic coordinates into a human-readable address.

You can also use the geocoder to find the address for a given place ID.

## Request
A Geocoding API request takes the following form:
```code
http://{HOST}:{PORT}/geocode?parameters

OR

http://{HOST}:{PORT}/maps/api/geocode/json?parameters
```

> **Note:** URLs must be properly encoded to be valid and are limited to 8192 characters for all web services. Be aware of this limit when constructing your URLs. Note that different browsers, proxies, and servers may have different URL character limits as well.

Some parameters are required while some are optional. As is standard in URLs, parameters are separated using the ampersand (**&**) character.

The rest of this page describes geocoding and [reverse geocoding](./reversegeocoding.md) separately, because different parameters are available for each type of request.

### Geocoding (latitude/longitude lookup) parameters
> All reserved characters (for example the plus sign "**+**") must be URL-encoded

### Required parameters in a geocoding request:

* **address** — The street address that you want to geocode. Specify addresses in accordance with the format used by the national postal service of the country concerned. Additional address elements such as business names and unit, suite or floor numbers should be avoided. Street address elements should be delimited by spaces (shown here as url-escaped to **%20** ):

  ```query_string
  address=24%20Sussex%20Drive%20Ottawa%20ON
  ```
  
  Format plus codes as shown here (plus signs are url-escaped to **%2B** and spaces are url-escaped to **%20** ):
  
    * **global code** is a 4 character area code and 6 character or longer local code (849VCWC8+R9 is **849VCWC8%2BR9**).
  
    * **compound code** is a 6 character or longer local code with an explicit location (CWC8+R9 Mountain View, CA, USA is **CWC8%2BR9%20Mountain%20View%20CA%20USA**).
  
  **--OR--**
  
  **components** — A components filter with elements separated by a pipe (**|**). The components filter is also accepted as an optional parameter if an **address** is provided. Each element in the components filter consists of a **component:value** pair, and fully restricts the results from the geocoder. See more information about [component filtering](#component-filtering) below.

### Optional parameters in a Geocoding request:
* **bounds** — The bounding box of the viewport within which to bias geocode results more prominently. This parameter will only influence, not fully restrict, results from the geocoder. (For more information see [Viewport Biasing](#viewport-biasing) below.)

* **language** — The language in which to return results.
  * See the [list of supported languages](./language.md). Mapcir often updates the supported languages, so this list may not be exhaustive.
  
  * The geocoder does its best to provide a street address that is readable for both the user and locals. To achieve that goal, it returns street addresses in the local language, transliterated to a script readable by the user if necessary, observing the preferred language. All other addresses are returned in the preferred language. Address components are all returned in the same language, which is chosen from the first component.
  
  * If a name is not available in the preferred language, the geocoder uses the closest match.
  
  * The preferred language has a small influence on the set of results that the API chooses to return, and the order in which they are returned. The geocoder interprets abbreviations differently depending on language, such as the abbreviations for street types, or synonyms that may be valid in one language but not in another. For example, *utca* and *tér* are synonyms for street and square respectively in Hungarian.
 
* **region** — The region code, specified as a ccTLD ("top-level domain") two-character value. This parameter will only influence, not fully restrict, results from the geocoder. (For more information see [Region Biasing](#region-biasing) below.)

* **components** — A components filter with elements separated by a pipe (**|**). The components filter is required if the request doesn't include an **address**. Each element in the components filter consists of a **component:value** pair, and fully restricts the results from the geocoder. See more information about [component filtering](#component-filtering) below.

## Responses

Geocoding responses are returned in the format indicated by the output flag within the URL request's path.

In this example, the Geocoding API requests a json response for a query on the place ID "ChIJeRpOeF67j4AR9ydy_PIzPuM", which is the place_ID for the building at 1600 Amphitheatre Parkway, Mountain View, CA.

> Plus codes are rectangular encoded location references derived from latitude and longitude coordinates. Requests with fully specified street addresses, such as "1600 Amphitheatre Parkway, Mountain View, CA", may not return a plus code when the result is a building, because buildings generally contain multiple plus code regions.

```code
{
    "results": [
        {
            "address_components": [
                {
                    "long_name": "1600",
                    "short_name": "1600",
                    "types": [
                        "street_number"
                    ]
                },
                {
                    "long_name": "Amphitheatre Parkway",
                    "short_name": "Amphitheatre Pkwy",
                    "types": [
                        "route"
                    ]
                },
                {
                    "long_name": "Mountain View",
                    "short_name": "Mountain View",
                    "types": [
                        "locality",
                        "political"
                    ]
                },
                {
                    "long_name": "Santa Clara County",
                    "short_name": "Santa Clara County",
                    "types": [
                        "administrative_area_level_2",
                        "political"
                    ]
                },
                {
                    "long_name": "California",
                    "short_name": "CA",
                    "types": [
                        "administrative_area_level_1",
                        "political"
                    ]
                },
                {
                    "long_name": "United States",
                    "short_name": "US",
                    "types": [
                        "country",
                        "political"
                    ]
                },
                {
                    "long_name": "94043",
                    "short_name": "94043",
                    "types": [
                        "postal_code"
                    ]
                }
            ],
            "formatted_address": "1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA",
            "geometry": {
                "location": {
                    "lat": 37.4224428,
                    "lng": -122.0842467
                },
                "location_type": "ROOFTOP",
                "viewport": {
                    "northeast": {
                        "lat": 37.4239627802915,
                        "lng": -122.0829089197085
                    },
                    "southwest": {
                        "lat": 37.4212648197085,
                        "lng": -122.0856068802915
                    }
                }
            },
            "place_id": "ChIJeRpOeF67j4AR9ydy_PIzPuM",
            "plus_code": {
                "compound_code": "CWC8+X8 Mountain View, CA",
                "global_code": "849VCWC8+X8"
            },
            "types": [
                "street_address"
            ]
        }
    ],
    "status": "OK"
}
```

Note that the JSON response contains two root elements:

**"status"** contains metadata on the request. (See [Status codes](#status-codes) below).

**"results"** contains an array of geocoded address information and geometry information.

Generally, only one entry in the **"results"** array is returned for address lookups,though the geocoder may return several results when address queries are ambiguous.

## Status codes
The **"status"** field within the Geocoding response object contains the status of the request, and may contain debugging information to help you track down why geocoding is not working. The **"status"** field may contain the following values:

  * **"OK"** indicates that no errors occurred; the address was successfully parsed and at least one geocode was returned.
  
  * **"ZERO_RESULTS"** indicates that the geocode was successful but returned no results. This may occur if the geocoder was passed a non-existent **address**.
  
  * **"OVER_DAILY_LIMIT"** indicates any of the following:
  
    * The API account is missing or invalid.
    
    * Billing has not been enabled on your account.
    
    * A self-imposed usage cap has been exceeded.
    
    * The provided method of payment is no longer valid (for example, a credit card has expired).

* **"OVER_QUERY_LIMIT"** indicates that you are over your quota.
  
* **"REQUEST_DENIED"** indicates that your request was denied.
  
* **"INVALID_REQUEST"** generally indicates that the query (**address**, **components** or **latlng**) is missing.
  
* **"UNKNOWN_ERROR"** indicates that the request could not be processed due to a server error. The request may succeed if you try again.

## Error messages
When the geocoder returns a status code other than **OK**, there may be an additional **error_message** field within the Geocoding response object. This field contains more detailed information about the reasons behind the given status code.

> **Note:** This field is not guaranteed to be always present, and its content is subject to change.

## Results
When the geocoder returns results, it places them within a (JSON) **results** array. Even if the geocoder returns no results (such as if the address doesn't exist) it still returns an empty **results** array.

A typical result contains the following fields:

  * The **types[]** array indicates the *type* of the returned result. This array contains a set of zero or more tags identifying the type of feature returned in the result. For example, a geocode of "Chicago" returns "locality" which indicates that "Chicago" is a city, and also returns "political" which indicates it is a political entity.

  * **formatted_address** is a string containing the human-readable address of this location.

    Often this address is equivalent to the postal address. Note that some countries, such as the United Kingdom, do not allow distribution of true postal addresses due to licensing restrictions.
  
    The formatted address is logically composed of one or more address components. For example, the address "111 8th Avenue, New York, NY" consists of the following components: "111" (the street number), "8th Avenue" (the route), "New York" (the city) and "NY" (the US state).
  
    Do not parse the formatted address programmatically. Instead you should use the individual address components, which the API response includes in addition to the formatted address field.
  
  * **address_components[]** is an array containing the separate components applicable to this address.

    Each address component typically contains the following fields:
    
      * **types[]** is an array indicating the type of the address component. See the list of supported types.

      * **long_name** is the full text description or name of the address component as returned by the Geocoder.

      * **short_name** is an abbreviated textual name for the address component, if available. For example, an address component for the state of Alaska may have a **long_name** of "Alaska" and a **short_name** of "AK" using the 2-letter postal abbreviation.

    Note the following facts about the address_components[] array:

    * The array of address components may contain more components than the **formatted_address**.

    * The array does not necessarily include all the political entities that contain an address, apart from those included in the **formatted_address**. To retrieve all the political entities that contain a specific address, you should use reverse geocoding, passing the latitude/longitude of the address as a parameter to the request.

    * The format of the response is not guaranteed to remain the same between requests. In particular, the number of **address_components** varies based on the address requested and can change over time for the same address. A component can change position in the array. The type of the component can change. A particular component may be missing in a later response.

* **postcode_localities[]** is an array denoting all the localities contained in a postal code. This is only present when the result is a postal code that contains multiple localities.

* **geometry** contains the following information:

  * **location** contains the geocoded latitude, longitude value. For normal address lookups, this field is typically the most important.

  * **location_type** stores additional data about the specified location. The following values are currently supported:

    * **"ROOFTOP"** indicates that the returned result is a precise geocode for which we have location information accurate down to street address precision.

    * **"RANGE_INTERPOLATED"** indicates that the returned result reflects an approximation (usually on a road) interpolated between two precise points (such as intersections). Interpolated results are generally returned when rooftop geocodes are unavailable for a street address.

    * **"GEOMETRIC_CENTER"** indicates that the returned result is the geometric center of a result such as a polyline (for example, a street) or polygon (region).

    * **"APPROXIMATE"** indicates that the returned result is approximate.

  * viewport contains the recommended viewport for displaying the returned result, specified as two latitude,longitude values defining the southwest and northeast corner of the viewport bounding box. Generally the viewport is used to frame a result when displaying it to a user.

  * bounds (optionally returned) stores the bounding box which can fully contain the returned result. Note that these bounds may not match the recommended viewport. (For example, San Francisco includes the Farallon islands, which are technically part of the city, but probably should not be returned in the viewport.)

* **plus_code** (see [Open Location Code](https://en.wikipedia.org/wiki/Open_Location_Code)) is an encoded location reference, derived from latitude and longitude coordinates, that represents an area: 1/8000th of a degree by 1/8000th of a degree (about 14m x 14m at the equator) or smaller. Plus codes can be used as a replacement for street addresses in places where they do not exist (where buildings are not numbered or streets are not named).

  The plus code is formatted as a global code and a compound code:
  
  * global_code is a 4 character area code and 6 character or longer local code (849VCWC8+R9).
  
  * compound_code is a 6 character or longer local code with an explicit location (CWC8+R9, Mountain View, CA, USA). Do not programmatically parse this content.

Typically, both the global code and compound code are returned. However, if the result is in a remote location (for example, an ocean or desert) only the global code may be returned.

* **partial_match** indicates that the geocoder did not return an exact match for the original request, though it was able to match part of the requested address. You may wish to examine the original request for misspellings and/or an incomplete address.

Partial matches most often occur for street addresses that do not exist within the locality you pass in the request.\
Partial matches may also be returned when a request matches two or more locations in the same locality. For example, "Hillpar St, Bristol, UK" will return a partial match for both Henry Street and Henrietta Street. Note that if a request includes a misspelled address component, the geocoding service may suggest an alternative address. Suggestions triggered in this way will also be marked as a partial match.

* **place_id** is a unique identifier that can be used with other Mapcir APIs. For example, you can use the **place_id** in a [Places API](./placedetails.md) request to get details of a local business, such as phone number, opening hours, user reviews, and more. See the [place ID overview](./placeid.md).

### Address types and address component types

The **types[]** array in the result indicates the address type. Examples of address types include a street address, a country, or a political entity. There is also a **types[]** array in the **address_components[]**, indicating the type of each part of the address. Examples include street number or country. (Below is a full list of types.) Addresses may have multiple types. The types may be considered 'tags'. For example, many cities are tagged with the **political** and the **locality** type.

The following types are supported and returned by the geocoder in both the address type and address component type arrays:

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

* **neighborhood** indicates a named neighborhood

* **premise** indicates a named location, usually a building or collection of buildings with a common name

* **subpremise** indicates a first-order entity below a named location, usually a singular building within a collection of buildings with a common name

* **plus_code** indicates an encoded location reference, derived from latitude and longitude. Plus codes can be used as a replacement for street addresses in places where they do not exist (where buildings are not numbered or streets are not named).

* **postal_code** indicates a postal code as used to address postal mail within the country.

* **natural_feature** indicates a prominent natural feature.

* **airport** indicates an airport.

* **park** indicates a named park.

* **point_of_interest** indicates a named point of interest. Typically, these "POI"s are prominent local entities that don't easily fit in another category, such as "Empire State Building" or "Eiffel Tower".

An empty list of types indicates there are no known types for the particular address component, for example, Lieu-dit in France.

In addition to the above, address components may include the types listed here. This list is not exhaustive, and is subject to change.

* **floor** indicates the floor of a building address.

* **establishment** typically indicates a place that has not yet been categorized.

* **landmark** indicates a nearby place that is used as a reference, to aid navigation.

* **point_of_interest** indicates a named point of interest.

* **parking indicates** a parking lot or parking structure.

* **post_box** indicates a specific postal box.

* **postal_town** indicates a grouping of geographic areas, such as locality and sublocality, used for mailing addresses in some countries.

* **room** indicates the room of a building address.

* **street_number** indicates the precise street number.

* **bus_station**, **train_station** and **transit_station** indicate the location of a bus, train or public transit stop.

> **Note:** The Geocoding API isn't guaranteed to return any particular component for an address within our data set. What may be thought of as the city, such as Brooklyn, may not show up as locality, but rather as another component - in this case, sublocality_level_1. What specific components are returned is subject to change without notice. Design your code to be flexible if you are attempting to extract address components from the response.

### Viewport biasing
In a Geocoding request, you can instruct the Geocoding service to prefer results within a given viewport (expressed as a bounding box). You do so within the request URL by setting the bounds parameter.

The bounds parameter defines the latitude/longitude coordinates of the southwest and northeast corners of this bounding box using a pipe (**|**) character to separate the coordinates.

> **Note:** this only adds a bias towards results within the viewport, and doesn't guarantee that all or any result(s) will be contained by it. [The Places API's Autocomplete endpoint](./placeautocomplete.md) is generally better suited for ambiguous queries, and can restrict results to a specific area.

For example, a geocode for "Washington" generally returns the U.S. state of Washington:

Request:


```code
http://127.0.0.1:8080/geocode?address=Washington

OR

http://127.0.0.1:8080/maps/api/geocode/json?address=Washington
```

Response:

```code
{
   "results" : [
      {
         "address_components" : [
            {
               "long_name" : "Washington",
               "short_name" : "WA",
               "types" : [ "administrative_area_level_1", "political" ]
            },
            {
               "long_name" : "United States",
               "short_name" : "US",
               "types" : [ "country", "political" ]
            }
         ],
         "formatted_address" : "Washington, USA",
         "geometry" : {
            "bounds" : {
               "northeast" : {
                  "lat" : 49.0024442,
                  "lng" : -116.91558
               },
               "southwest" : {
                  "lat" : 45.543541,
                  "lng" : -124.8489739
               }
            },
            "location" : {
               "lat" : 47.7510741,
               "lng" : -120.7401385
            },
            "location_type" : "APPROXIMATE",
            "viewport" : {
               "northeast" : {
                  "lat" : 49.0024442,
                  "lng" : -116.91558
               },
               "southwest" : {
                  "lat" : 45.543541,
                  "lng" : -124.8489739
               }
            }
         },
         "place_id" : "ChIJ-bDD5__lhVQRuvNfbGh4QpQ",
         "types" : [ "administrative_area_level_1", "political" ]
      }
   ],
   "status" : "OK"
}
```

However, adding a bounds argument defining a bounding box around the north-east part of the U.S. results in this geocode returning the city of Washington, D.C.:

Request:

```code
http://127.0.0.1:8080/geocode?address=Washington&bounds=36.47,-84.72%7C43.39,-65.90

OR 

http://127.0.0.1:8080/maps/api/geocode/json?address=Washington&bounds=36.47,-84.72%7C43.39,-65.90
```

Response:

```code
{
   "results" : [
      {
         "address_components" : [
            {
               "long_name" : "Washington",
               "short_name" : "Washington",
               "types" : [ "locality", "political" ]
            },
            {
               "long_name" : "District of Columbia",
               "short_name" : "District of Columbia",
               "types" : [ "administrative_area_level_2", "political" ]
            },
            {
               "long_name" : "District of Columbia",
               "short_name" : "DC",
               "types" : [ "administrative_area_level_1", "political" ]
            },
            {
               "long_name" : "United States",
               "short_name" : "US",
               "types" : [ "country", "political" ]
            }
         ],
         "formatted_address" : "Washington, DC, USA",
         "geometry" : {
            "bounds" : {
               "northeast" : {
                  "lat" : 38.9958641,
                  "lng" : -76.90939299999999
               },
               "southwest" : {
                  "lat" : 38.7916449,
                  "lng" : -77.119759
               }
            },
            "location" : {
               "lat" : 38.9071923,
               "lng" : -77.03687069999999
            },
            "location_type" : "APPROXIMATE",
            "viewport" : {
               "northeast" : {
                  "lat" : 38.9958641,
                  "lng" : -76.90939299999999
               },
               "southwest" : {
                  "lat" : 38.7916449,
                  "lng" : -77.119759
               }
            }
         },
         "place_id" : "ChIJW-T2Wt7Gt4kRKl2I1CJFUsI",
         "types" : [ "locality", "political" ]
      }
   ],
   "status" : "OK"
}
```

### Region biasing
In a Geocoding request, you can instruct the Geocoding service to return results biased to a particular region by using the region parameter. This parameter takes a [ccTLD](https://en.wikipedia.org/wiki/Country_code_top-level_domain) (country code top-level domain) argument specifying the region bias. Most ccTLD codes are identical to ISO 3166-1 codes, with some notable exceptions. For example, the United Kingdom's ccTLD is "uk" (.co.uk) while its ISO 3166-1 code is "gb" (technically for the entity of "The United Kingdom of Great Britain and Northern Ireland").

For example, a geocode for "Toledo" returns this result, as the default domain for the Geocoding API is set to the United States. 

Request:

```code
http://127.0.0.1:8080/geocode?address=Toledo

OR

http://127.0.0.1:8080/maps/api/geocode/json?address=Toledo
```

Response:

```code
{
   "results" : [
      {
         "address_components" : [
            {
               "long_name" : "Toledo",
               "short_name" : "Toledo",
               "types" : [ "locality", "political" ]
            },
            {
               "long_name" : "Lucas County",
               "short_name" : "Lucas County",
               "types" : [ "administrative_area_level_2", "political" ]
            },
            {
               "long_name" : "Ohio",
               "short_name" : "OH",
               "types" : [ "administrative_area_level_1", "political" ]
            },
            {
               "long_name" : "United States",
               "short_name" : "US",
               "types" : [ "country", "political" ]
            }
         ],
         "formatted_address" : "Toledo, OH, USA",
         "geometry" : {
            "bounds" : {
               "northeast" : {
                  "lat" : 41.732844,
                  "lng" : -83.454229
               },
               "southwest" : {
                  "lat" : 41.580266,
                  "lng" : -83.69423700000002
               }
            },
            "location" : {
               "lat" : 41.6639383,
               "lng" : -83.55521200000001
            },
            "location_type" : "APPROXIMATE",
            "viewport" : {
               "northeast" : {
                  "lat" : 41.732844,
                  "lng" : -83.454229
               },
               "southwest" : {
                  "lat" : 41.580266,
                  "lng" : -83.69423700000002
               }
            }
         },
         "place_id" : "ChIJeU4e_C2HO4gRRcM6RZ_IPHw",
         "types" : [ "locality", "political" ]
      }
   ],
   "status" : "OK"
}
```

A Geocoding request for "Toledo" with **region=es** (Spain) will return the Spanish city.

Request:

```code
http://127.0.0.1:8080/geocode?address=Toledo&region=es

OR

http://127.0.0.1:8080/maps/api/geocode/json?address=Toledo&region=es
```

Response:

```code
{
   "results" : [
      {
         "address_components" : [
            {
               "long_name" : "Toledo",
               "short_name" : "Toledo",
               "types" : [ "locality", "political" ]
            },
            {
               "long_name" : "Toledo",
               "short_name" : "TO",
               "types" : [ "administrative_area_level_2", "political" ]
            },
            {
               "long_name" : "Castile-La Mancha",
               "short_name" : "CM",
               "types" : [ "administrative_area_level_1", "political" ]
            },
            {
               "long_name" : "Spain",
               "short_name" : "ES",
               "types" : [ "country", "political" ]
            }
         ],
         "formatted_address" : "Toledo, Spain",
         "geometry" : {
            "bounds" : {
               "northeast" : {
                  "lat" : 39.88605099999999,
                  "lng" : -3.9192423
               },
               "southwest" : {
                  "lat" : 39.8383676,
                  "lng" : -4.0796176
               }
            },
            "location" : {
               "lat" : 39.8628316,
               "lng" : -4.027323099999999
            },
            "location_type" : "APPROXIMATE",
            "viewport" : {
               "northeast" : {
                  "lat" : 39.88605099999999,
                  "lng" : -3.9192423
               },
               "southwest" : {
                  "lat" : 39.8383676,
                  "lng" : -4.0796176
               }
            }
         },
         "place_id" : "ChIJ8f21C60Lag0R_q11auhbf8Y",
         "types" : [ "locality", "political" ]
      }
   ],
   "status" : "OK"
}
```

### Component filtering
In a Geocoding response, the Geocoding API can return address results restricted to a specific area. You can specify the restriction using the **components** filter. A filter consists of a list of **component:value** pairs separated by a pipe (**|**). Filter values support the same methods of spelling correction and partial matching as other Geocoding requests. If the geocoder finds a partial match for a component filter, the response will contain a **partial_match** field.

The **components** that can be filtered include:

* **postal_code** matches **postal_code** and **postal_code_prefix**.

* **country** matches a country name or a two letter [ISO 3166-1](https://en.wikipedia.org/wiki/ISO_3166-1) country code. The API follows the ISO standard for defining countries, and the filtering works best when using the corresponding ISO code of the country.

  > **Note:** If you receive unexpected results with a country code, verify that you are using a code which includes the countries, dependent territories, and special areas of geographical interest you intend. You can find code information at [Wikipedia: List of ISO 3166 country codes](https://en.wikipedia.org/wiki/List_of_ISO_3166_country_codes) or the [ISO Online Browsing Platform](https://www.iso.org/obp/ui/#search).

The following **components** may be used to influence results, but will not be enforced:

* **route** matches the long or short name of a route.
* **locality** matches against **locality** and **sublocality** types.
* **administrative_area** matches all the **administrative_area** levels.

Notes about component filtering:

* Do not repeat these component filters in requests, or the API will return **Invalid_request**: **country**, **postal_code**, **route**

* If the request contains repeated component filters, the API evaluates those filters as an AND, not an OR.

* For each address component, either specify it in the **address** parameter or in a **components** filter, but not both. Specifying the same values in both may result in **ZERO_RESULTS**.

A geocode for "High St, Hastings" with **components=country:GB** returns a result in Hastings, England rather than in Hastings-On-Hudson, USA.

Request:

```code
http://127.0.0.1:8080/geocode?address=high+st+hasting&components=country:GB

OR

http://127.0.0.1:8080/maps/api/geocode/json?address=high+st+hasting&components=country:GB
```

Response:

```code
{
   "results" : [
      {
         "address_components" : [
            {
               "long_name" : "High Street",
               "short_name" : "High St",
               "types" : [ "route" ]
            },
            {
               "long_name" : "Hastings",
               "short_name" : "Hastings",
               "types" : [ "postal_town" ]
            },
            {
               "long_name" : "East Sussex",
               "short_name" : "East Sussex",
               "types" : [ "administrative_area_level_2", "political" ]
            },
            {
               "long_name" : "England",
               "short_name" : "England",
               "types" : [ "administrative_area_level_1", "political" ]
            },
            {
               "long_name" : "United Kingdom",
               "short_name" : "GB",
               "types" : [ "country", "political" ]
            },
            {
               "long_name" : "TN34 3EY",
               "short_name" : "TN34 3EY",
               "types" : [ "postal_code" ]
            }
         ],
         "formatted_address" : "High St, Hastings TN34 3EY, UK",
         "geometry" : {
            "bounds" : {
               "northeast" : {
                  "lat" : 50.8601041,
                  "lng" : 0.5957329
               },
               "southwest" : {
                  "lat" : 50.8559061,
                  "lng" : 0.5906163
               }
            },
            "location" : {
               "lat" : 50.85830319999999,
               "lng" : 0.5924594
            },
            "location_type" : "GEOMETRIC_CENTER",
            "viewport" : {
               "northeast" : {
                  "lat" : 50.8601041,
                  "lng" : 0.5957329
               },
               "southwest" : {
                  "lat" : 50.8559061,
                  "lng" : 0.5906163
               }
            }
         },
         "partial_match" : true,
         "place_id" : "ChIJ-Ws929sa30cRKgsMNVkPyws",
         "types" : [ "route" ]
      }
   ],
   "status" : "OK"
}
```

A geocode request for the locality of "Santa Cruz" with **components=country:ES** returns Santa Cruz de Tenerife in Canary Islands, Spain.

Request:

```code
http://127.0.0.1:8080/geocode?components=locality:santa+cruz|country:ES

OR

http://127.0.0.1:8080/maps/api/geocode/json?components=locality:santa+cruz|country:ES
```

Response:

```code
{
   "results" : [
      {
         "address_components" : [
            {
               "long_name" : "Santa Cruz de Tenerife",
               "short_name" : "Santa Cruz de Tenerife",
               "types" : [ "locality", "political" ]
            },
            {
               "long_name" : "Santa Cruz de Tenerife",
               "short_name" : "TF",
               "types" : [ "administrative_area_level_2", "political" ]
            },
            {
               "long_name" : "Canary Islands",
               "short_name" : "CN",
               "types" : [ "administrative_area_level_1", "political" ]
            },
            {
               "long_name" : "Spain",
               "short_name" : "ES",
               "types" : [ "country", "political" ]
            }
         ],
         "formatted_address" : "Santa Cruz de Tenerife, Spain",
         "geometry" : {
            "bounds" : {
               "northeast" : {
                  "lat" : 28.487616,
                  "lng" : -16.2356646
               },
               "southwest" : {
                  "lat" : 28.4280248,
                  "lng" : -16.3370045
               }
            },
            "location" : {
               "lat" : 28.4636296,
               "lng" : -16.2518467
            },
            "location_type" : "APPROXIMATE",
            "viewport" : {
               "northeast" : {
                  "lat" : 28.487616,
                  "lng" : -16.2356646
               },
               "southwest" : {
                  "lat" : 28.4280248,
                  "lng" : -16.3370045
               }
            }
         },
         "place_id" : "ChIJcUElzOzMQQwRLuV30nMUEUM",
         "types" : [ "locality", "political" ]
      }
   ],
   "status" : "OK"
}
```

Component filtering returns a **ZERO_RESULTS** response only if you provide filters that exclude each other.

Request:

```code
http://127.0.0.1:8080/geocode?components=administrative_area:TX|country:FR

OR

http://127.0.0.1:8080/maps/api/geocode/json?components=administrative_area:TX|country:FR
```

You can make valid queries without the address parameter, using the components filter. (When geocoding a full address, the address parameter is required if the request contains the names and numbers of buildings.)

Request:

```code
http://127.0.0.1:8080/geocode?components=route:Annankatu|administrative_area:Helsinki|country:Finland

OR

http://127.0.0.1:8080/maps/api/geocode/json?components=route:Annankatu|administrative_area:Helsinki|country:Finland
```

Response:

```code
{
   "results" : [
      {
         "address_components" : [
            {
               "long_name" : "Annankatu",
               "short_name" : "Annankatu",
               "types" : [ "route" ]
            },
            {
               "long_name" : "Helsinki",
               "short_name" : "HKI",
               "types" : [ "locality", "political" ]
            },
            {
               "long_name" : "Finland",
               "short_name" : "FI",
               "types" : [ "country", "political" ]
            },
            {
               "long_name" : "00101",
               "short_name" : "00101",
               "types" : [ "postal_code" ]
            }
         ],
         "formatted_address" : "Annankatu, 00101 Helsinki, Finland",
         "geometry" : {
            "bounds" : {
               "northeast" : {
                  "lat" : 60.168997,
                  "lng" : 24.9433353
               },
               "southwest" : {
                  "lat" : 60.16226160000001,
                  "lng" : 24.9332897
               }
            },
            "location" : {
               "lat" : 60.1657808,
               "lng" : 24.938451
            },
            "location_type" : "GEOMETRIC_CENTER",
            "viewport" : {
               "northeast" : {
                  "lat" : 60.168997,
                  "lng" : 24.9433353
               },
               "southwest" : {
                  "lat" : 60.16226160000001,
                  "lng" : 24.9332897
               }
            }
         },
         "place_id" : "ChIJARW7C8sLkkYRgl4je4-RPUM",
         "types" : [ "route" ]
      }
   ],
   "status" : "OK"
}
```