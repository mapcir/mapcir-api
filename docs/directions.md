# Directions API
> Get directions between locations, for driving, cycling, transit, and walking.

## Overview
For direction calculations that respond in real time to user input (for example, within a user interface element), you can use the Directions API.

With the Directions API, you can:

* Search for directions for several modes of transportation, including transit, driving, walking or cycling.

* Return multi-part directions using a series of waypoints.

* Specify origins, destinations, and waypoints as text strings (e.g. "Chicago, IL" or "Darwin, NT, Australia"), as place IDs, or as latitude/longitude coordinates

The API returns the most efficient routes when calculating directions. Travel time is the primary factor optimized, but the API may also take into account other factors such as distance, number of turns and many more when deciding which route is the most efficient.

## Directions API requests

A Directions API request takes the following form:

```code
http://{HOST}:{PORT}/directions?parameters

OR

http://{HOST}:{PORT}/maps/api/directions?parameters
```

> **Note:** URLs must be [properly encoded](./validurl.md) to be valid and are limited to 8192 characters for all web services. Be aware of this limit when constructing your URLs.

As is standard in URLs, all parameters are separated using the ampersand (&) character. All reserved characters (for example the plus sign "+") must be [URL-encoded](./validurl.md). The list of parameters and their possible values are enumerated below.

## Required parameters

* **destination**

  The place ID, address, or textual latitude/longitude value to which you wish to calculate directions. The options for the destination parameter are the same as for the origin parameter.

* **origin**
  
  The place ID, address, or textual latitude/longitude value from which you wish to calculate directions.

  * Place IDs must be prefixed with **place_id**:. You can retrieve place IDs from the Geocoding API and the Places API (including Place Autocomplete).

    ```code
    origin=place_id:ChIJ3S-JXmauEmsRUcIaWtf4MzE
    ```

  * If you pass an address, the Directions service geocodes the string and converts it to a latitude/longitude coordinate to calculate directions. This coordinate may be different from that returned by the Geocoding API, for example a building entrance rather than its center.

    ```code
    origin=24+Sussex+Drive+Ottawa+ON
    ```

    Using place IDs is preferred over using addresses or latitude/longitude coordinates. Using coordinates will always result in the point being snapped to the road nearest to those coordinates - which may not be an access point to the property, or even a road that will quickly or safely lead to the destination.

  * If you pass coordinates, the point will snap to the nearest road. Passing a place ID is preferred. If you do pass coordinates, ensure that no space exists between the latitude and longitude values.

    ```code
    origin=41.43206,-81.38992
    ```

 > **Note:** For efficiency and accuracy, use place ID's when possible. These ID's are uniquely explicit like a lat/lng value pair and provide geocoding benefits for routing such as access points and traffic variables. Unlike an address, ID's do not require the service to perform a search or an intermediate request for place details; therefore, performance is better.

## Optional parameters
* **alternatives**
  
  If set to true, specifies that the Directions service may provide more than one route alternative in the response. Note that providing route alternatives may increase the response time from the server. This is only available for requests without intermediate waypoints.

* **arrival_time**
  
  Specifies the desired time of arrival for transit directions, in seconds since midnight, January 1, 1970 UTC. You can specify either **departure_time** or **arrival_time**, but not both. Note that **arrival_time** must be specified as an integer.

* **avoid**

  Indicates that the calculated route(s) should avoid the indicated features. This parameter supports the following arguments:

  * **tolls** indicates that the calculated route should avoid toll roads/bridges.

  * **highways** indicates that the calculated route should avoid highways.

  * **ferries** indicates that the calculated route should avoid ferries.

  * **indoor** indicates that the calculated route should avoid indoor steps for walking and transit directions.

  It's possible to request a route that avoids any combination of tolls, highways and ferries by passing multiple restrictions to the avoid parameter. For example:

  ```code
  avoid=tolls|highways|ferries
  ```

* **departure_time**

  Specifies the desired time of departure. You can specify the time as an integer in seconds since midnight, January 1, 1970 UTC. If a **departure_time** later than 9999-12-31T23:59:59.999999999Z is specified, the API will fall back the departure_time to 9999-12-31T23:59:59.999999999Z. Alternatively, you can specify a value of now, which sets the departure time to the current time (correct to the nearest second). The departure time may be specified in two cases:

  * For requests where the travel mode is transit: You can optionally specify one of **departure_time** or **arrival_time**. If neither time is specified, the **departure_time** defaults to now (that is, the departure time defaults to the current time).

  * For requests where the travel mode is driving: You can specify the **departure_time** to receive a route and trip duration (response field: duration_in_traffic) that take traffic conditions into account. The **departure_time** must be set to the current time or some time in the future. It cannot be in the past.

  > **Note:** If departure time is not specified, choice of route and duration are based on road network and average time-independent traffic conditions. Results for a given request may vary over time due to changes in the road network, updated average traffic conditions, and the distributed nature of the service. Results may also vary between nearly-equivalent routes at any time or frequency.

  > **Note:** Distance Matrix requests specifying `departure_time` when `mode=driving` are limited to a maximum of 100 elements per request. The number of origins times the number of destinations defines the number of elements.

* **language**

  The language in which to return results.

  * See the [list of supported languages](./language.md). Mapcir often updates the supported languages, so this list may not be exhaustive.

  * If **language** is not supplied, the API attempts to use the preferred language as specified in the Accept-Language header.

  * The API does its best to provide a street address that is readable for both the user and locals. To achieve that goal, it returns street addresses in the local language, transliterated to a script readable by the user if necessary, observing the preferred language. All other addresses are returned in the preferred language. Address components are all returned in the same language, which is chosen from the first component.

  * If a name is not available in the preferred language, the API uses the closest match.

  * The preferred language has a small influence on the set of results that the API chooses to return, and the order in which they are returned. The geocoder interprets abbreviations differently depending on language, such as the abbreviations for street types, or synonyms that may be valid in one language but not in another. For example, *utca* and *tér* are synonyms for street in Hungarian.

* **mode**
  
  For the calculation of distances and directions, you may specify the transportation mode to use. By default, **DRIVING** mode is used. By default, directions are calculated as driving directions. The following travel modes are supported:

  * **driving** (default) indicates standard driving directions or distance using the road network.

  * **walking** requests walking directions or distance via pedestrian paths & sidewalks (where available).

  * **bicycling** requests bicycling directions or distance via bicycle paths & preferred streets (where available).

  * **transit** requests directions or distance via public transit routes (where available). If you set the mode to transit, you can optionally specify either a **departure_time** or an **arrival_time**. If neither time is specified, the **departure_time** defaults to now (that is, the departure time defaults to the current time). You can also optionally include a **transit_mode** and/or a **transit_routing_preference**.

  > **Note:** Both walking and bicycling directions may sometimes not include clear pedestrian or bicycling paths, so these directions will return warnings in the returned result which you must display to the user.

* **region**

  The region code, specified as a [ccTLD ("top-level domain")](https://en.wikipedia.org/wiki/List_of_Internet_top-level_domains#Country_code_top-level_domains) two-character value. Most ccTLD codes are identical to ISO 3166-1 codes, with some notable exceptions. For example, the United Kingdom's ccTLD is "uk" (.co.uk) while its ISO 3166-1 code is "gb" (technically for the entity of "The United Kingdom of Great Britain and Northern Ireland").

* **traffic_model**

  Specifies the assumptions to use when calculating time in traffic. This setting affects the value returned in the duration_in_traffic field in the response, which contains the predicted time in traffic based on historical averages. The **traffic_model** parameter may only be specified for driving directions where the request includes a **departure_time**. The available values for this parameter are:

  * **best_guess** (default) indicates that the returned duration_in_traffic should be the best estimate of travel time given what is known about both historical traffic conditions and live traffic. Live traffic becomes more important the closer the **departure_time** is to now.

  * **pessimistic** indicates that the returned duration_in_traffic should be longer than the actual travel time on most days, though occasional days with particularly bad traffic conditions may exceed this value.

  * **optimistic** indicates that the returned duration_in_traffic should be shorter than the actual travel time on most days, though occasional days with particularly good traffic conditions may be faster than this value.

  The default value of best_guess will give the most useful predictions for the vast majority of use cases. It is possible the **best_guess** travel time prediction may be shorter than **optimistic**, or alternatively, longer than **pessimistic**, due to the way the **best_guess** prediction model integrates live traffic information.

* **transit_mode**

  Specifies one or more preferred modes of transit. This parameter may only be specified for transit directions. The parameter supports the following arguments:

  * **bus** indicates that the calculated route should prefer travel by bus.

  * **subway** indicates that the calculated route should prefer travel by subway.

  * **train** indicates that the calculated route should prefer travel by train.

  * **tram** indicates that the calculated route should prefer travel by tram and light rail.

  * **rail** indicates that the calculated route should prefer travel by train, tram, light rail, and subway. This is equivalent to **transit_mode=train|tram|subway**.

  


