# Distance Matrix API
> Get the travel distance and time for a matrix of origins and destinations.

## Request
A Geocoding API request takes the following form:
```code
http://{HOST}:{PORT}/distancematrix?parameters

OR

http://{HOST}:{PORT}/maps/api/distancematrix?parameters
```

> **Note:** URLs must be properly encoded to be valid and are limited to 8192 characters for all web services. Be aware of this limit when constructing your URLs. Note that different browsers, proxies, and servers may have different URL character limits as well.

Certain parameters are required while others are optional. As is standard in URLs, all parameters are separated using the ampersand (&) character. All reserved characters (for example the plus sign "+") must be [URL-encoded](./validurl.md). The list of parameters and their possible values are enumerated below.


### Required parameters
* destinations

  One or more locations to use as the finishing point for calculating travel distance and time. The options for the destinations parameter are the same as for the origins parameter.

* origins

  The starting point for calculating travel distance and time. You can supply one or more locations separated by the pipe character (|), in the form of a place ID, an address, or latitude/longitude coordinates:

  * **Place ID**: If you supply a place ID, you must prefix it with place_id:

  * **Address**: If you pass an address, the service geocodes the string and converts it to a latitude/longitude coordinate to calculate distance. This coordinate may be different from that returned by the Geocoding API, for example a building entrance rather than its center.

    > **Note:** using place IDs is preferred over using addresses or latitude/longitude coordinates. Using coordinates will always result in the point being snapped to the road nearest to those coordinates - which may not be an access point to the property, or even a road that will quickly or safely lead to the destination. Using the address will provide the distance to the center of the building, as opposed to an entrance to the building.

  * **Coordinates**: If you pass latitude/longitude coordinates, they they will snap to the nearest road. Passing a place ID is preferred. If you do pass coordinates, ensure that no space exists between the latitude and longitude values.

  * **Plus codes** must be formatted as a global code or a compound code. Format plus codes as shown here (plus signs are url-escaped to %2B and spaces are url-escaped to %20):

    * **global code** is a 4 character area code and 6 character or longer local code (849VCWC8+R9 is encoded to 849VCWC8%2BR9).

    * **compound code** is a 6 character or longer local code with an explicit location (CWC8+R9 Mountain View, CA, USA is encoded to CWC8%2BR9%20Mountain%20View%20CA%20USA).

  * **Encoded Polyline** Alternatively, you can supply an encoded set of coordinates using the [Encoded Polyline Algorithm](./polylineencoding.md). This is particularly useful if you have a large number of origin points, because the URL is significantly shorter when using an encoded polyline.

    * Encoded polylines must be prefixed with enc: and followed by a colon :. For example: origins=enc:gfo}EtohhU:

    * You can also include multiple encoded polylines, separated by the pipe character |. For example:

      ```code
      origins=enc:wc~oAwquwMdlTxiKtqLyiK:|enc:c~vnAamswMvlTor@tjGi}L:|enc:udymA{~bxM:
      ```

### Optional parameters
* arrival_time
  
  Specifies the desired time of arrival for transit directions, in seconds since midnight, January 1, 1970 UTC. You can specify either departure_time or arrival_time, but not both. Note that arrival_time must be specified as an integer.

* avoid

  Distances may be calculated that adhere to certain restrictions. Restrictions are indicated by use of the avoid parameter, and an argument to that parameter indicating the restriction to avoid. The following restrictions are supported:

  * **tolls** indicates that the calculated route should avoid toll roads/bridges.

  * **highways** indicates that the calculated route should avoid highways.

  * **ferries** indicates that the calculated route should avoid ferries.

  * **indoor** indicates that the calculated route should avoid indoor steps for walking and transit directions.

  > **Note:** The addition of restrictions does not preclude routes that include the restricted feature; it biases the result to more favorable routes.

* departure_time

  Specifies the desired time of departure. You can specify the time as an integer in seconds since midnight, January 1, 1970 UTC. If a **departure_time** later than 9999-12-31T23:59:59.999999999Z is specified, the API will fall back the **departure_time** to 9999-12-31T23:59:59.999999999Z. Alternatively, you can specify a value of now, which sets the departure time to the current time (correct to the nearest second). The departure time may be specified in two cases:

  * For requests where the travel mode is transit: You can optionally specify one of **departure_time** or **arrival_time**. If neither time is specified, the **departure_time** defaults to now (that is, the departure time defaults to the current time).

  * For requests where the travel mode is driving: You can specify the **departure_time** to receive a route and trip duration (response field: duration_in_traffic) that take traffic conditions into account. The **departure_time** must be set to the current time or some time in the future. It cannot be in the past.

  > **Note:** If departure time is not specified, choice of route and duration are based on road network and average time-independent traffic conditions. Results for a given request may vary over time due to changes in the road network, updated average traffic conditions, and the distributed nature of the service. Results may also vary between nearly-equivalent routes at any time or frequency.

  > **Note:** Distance Matrix requests specifying `departure_time` when `mode=driving` are limited to a maximum of 100 elements per request. The number of origins times the number of destinations defines the number of elements.

* language

  The language in which to return results.

  * See the [list of supported languages](./language.md). Mapcir often updates the supported languages, so this list may not be exhaustive.

  * If **language** is not supplied, the API attempts to use the preferred language as specified in the **Accept-Language** header.

  * The API does its best to provide a street address that is readable for both the user and locals. To achieve that goal, it returns street addresses in the local language, transliterated to a script readable by the user if necessary, observing the preferred language. All other addresses are returned in the preferred language. Address components are all returned in the same language, which is chosen from the first component.

  * If a name is not available in the preferred language, the API uses the closest match.

  * The preferred language has a small influence on the set of results that the API chooses to return, and the order in which they are returned. The geocoder interprets abbreviations differently depending on language, such as the abbreviations for street types, or synonyms that may be valid in one language but not in another. For example, utca and tér are synonyms for street in Hungarian.

* mode

  For the calculation of distances and directions, you may specify the transportation mode to use. By default, **DRIVING** mode is used. By default, directions are calculated as driving directions. The following travel modes are supported:

  * **driving** (default) indicates standard driving directions or distance using the road network.

  * **walking** requests walking directions or distance via pedestrian paths & sidewalks (where available).

  * **bicycling** requests bicycling directions or distance via bicycle paths & preferred streets (where available).

  * **transit** requests directions or distance via public transit routes (where available). If you set the mode to transit, you can optionally specify either a **departure_time** or an **arrival_time**. If neither time is specified, the **departure_time** defaults to now (that is, the departure time defaults to the current time). You can also optionally include a **transit_mode** and/or a **transit_routing_preference**.

    > **Note:** Both walking and bicycling directions may sometimes not include clear pedestrian or bicycling paths, so these directions will return warnings in the returned result which you must display to the user.

* region

  The region code, specified as a [ccTLD ("top-level domain")](https://en.wikipedia.org/wiki/List_of_Internet_top-level_domains#Country_code_top-level_domains) two-character value. Most ccTLD codes are identical to ISO 3166-1 codes, with some notable exceptions. For example, the United Kingdom's ccTLD is "uk" (.co.uk) while its ISO 3166-1 code is "gb" (technically for the entity of "The United Kingdom of Great Britain and Northern Ireland").

* traffic_model

  Specifies the assumptions to use when calculating time in traffic. This setting affects the value returned in the duration_in_traffic field in the response, which contains the predicted time in traffic based on historical averages. The **traffic_model** parameter may only be specified for driving directions where the request includes a **departure_time**. The available values for this parameter are:

    * **best_guess** (default) indicates that the returned duration_in_traffic should be the best estimate of travel time given what is known about both historical traffic conditions and live traffic. Live traffic becomes more important the closer the **departure_time** is to now.

    * **pessimistic** indicates that the returned duration_in_traffic should be longer than the actual travel time on most days, though occasional days with particularly bad traffic conditions may exceed this value.

    * **optimistic** indicates that the returned duration_in_traffic should be shorter than the actual travel time on most days, though occasional days with particularly good traffic conditions may be faster than this value.

  The default value of **best_guess** will give the most useful predictions for the vast majority of use cases. It is possible the **best_guess** travel time prediction may be shorter than **optimistic**, or alternatively, longer than **pessimistic**, due to the way the **best_guess** prediction model integrates live traffic information.

* transit_mode

  Specifies one or more preferred modes of transit. This parameter may only be specified for transit directions. The parameter supports the following arguments:

  * **bus** indicates that the calculated route should prefer travel by bus.

  * **subway** indicates that the calculated route should prefer travel by subway.

  * **train** indicates that the calculated route should prefer travel by train.

  * **tram** indicates that the calculated route should prefer travel by tram and light rail.

  * **rail** indicates that the calculated route should prefer travel by train, tram, light rail, and subway. This is equivalent to **transit_mode=train|tram|subway**.

* transit_routing_preference

  Specifies preferences for transit routes. Using this parameter, you can bias the options returned, rather than accepting the default best route chosen by the API. This parameter may only be specified for transit directions. The parameter supports the following arguments:

    * **less_walking** indicates that the calculated route should prefer limited amounts of walking.

    * **fewer_transfers** indicates that the calculated route should prefer a limited number of transfers.

* units

  Specifies the unit system to use when displaying results.

  > **Note:** this unit system setting only affects the text displayed within distance fields. The distance fields also contain values which are always expressed in meters.


## Request examples

This example uses latitude/longitude coordinates to specify the destination coordinates:

```code
http://127.0.0.1:8080/distancematrix?origins=40.6655101%2C-73.89188969999998&destinations=40.659569%2C-73.933783%7C40.729029%2C-73.851524%7C40.6860072%2C-73.6334271%7C40.598566%2C-73.7527626

OR

http://127.0.0.1:8080/maps/api/distancematrix/json?origins=40.6655101%2C-73.89188969999998&destinations=40.659569%2C-73.933783%7C40.729029%2C-73.851524%7C40.6860072%2C-73.6334271%7C40.598566%2C-73.7527626
```

This example uses plus codes to specify the destination coordinates:

```code
http://127.0.0.1:8080/distancematrix?origins=849VCWC8%2BR9&destinations=San%20Francisco

OR

http://127.0.0.1:8080/maps/api/distancematrix/json?origins=849VCWC8%2BR9&destinations=San%20Francisco
```

This example shows the same request using an encoded polyline:

```code
http://127.0.0.1:8080/distancematrix?origins=40.6655101%2C-73.89188969999998&destinations=enc%3A_kjwFjtsbMt%60EgnKcqLcaOzkGari%40naPxhVg%7CJjjb%40cqLcaOzkGari%40naPxhV%3A

OR

http://127.0.0.1:8080/maps/api/distancematrix/json?origins=40.6655101%2C-73.89188969999998&destinations=enc%3A_kjwFjtsbMt%60EgnKcqLcaOzkGari%40naPxhVg%7CJjjb%40cqLcaOzkGari%40naPxhV%3A
```

## Traffic information
Traffic information is used when **all** the following apply (these are the conditions required to receive the **duration_in_traffic** field in the Distance Matrix response):

  * The travel **mode** parameter is driving, or is not specified (**driving** is the default travel mode).

  * The request includes a valid **departure_time** parameter. The **departure_time** can be set to the current time or some time in the future. It cannot be in the past.

Optionally, you can include the **traffic_model** parameter in your request to specify the assumptions to use when calculating time in traffic.

The following URL initiates a Distance Matrix request for driving distances between Boston, MA or Charlestown, MA, and Lexington, MA and Concord, MA. The request includes a departure time, meeting all the requirements to return the **duration_in_traffic** field in the Distance Matrix response.

```code
http://127.0.0.1:8080/distancematrix?origins=Boston%2CMA%7CCharlestown%2CMA&destinations=Lexington%2CMA%7CConcord%2CMA&departure_time=now

OR

http://127.0.0.1:8080/maps/api/distancematrix/json?origins=Boston%2CMA%7CCharlestown%2CMA&destinations=Lexington%2CMA%7CConcord%2CMA&departure_time=now
```

*Response*

```code
{
    "destination_addresses": [
        "Lexington, MA, USA",
        "Concord, MA, USA"
    ],
    "origin_addresses": [
        "Boston, MA, USA",
        "Charlestown, Boston, MA, USA"
    ],
    "rows": [
        {
            "elements": [
                {
                    "distance": {
                        "text": "23.6 km",
                        "value": 23627
                    },
                    "duration": {
                        "text": "28 mins",
                        "value": 1696
                    },
                    "duration_in_traffic": {
                        "text": "23 mins",
                        "value": 1366
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "31.6 km",
                        "value": 31606
                    },
                    "duration": {
                        "text": "33 mins",
                        "value": 1962
                    },
                    "duration_in_traffic": {
                        "text": "28 mins",
                        "value": 1658
                    },
                    "status": "OK"
                }
            ]
        },
        {
            "elements": [
                {
                    "distance": {
                        "text": "21.5 km",
                        "value": 21489
                    },
                    "duration": {
                        "text": "27 mins",
                        "value": 1635
                    },
                    "duration_in_traffic": {
                        "text": "22 mins",
                        "value": 1328
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "29.5 km",
                        "value": 29468
                    },
                    "duration": {
                        "text": "32 mins",
                        "value": 1901
                    },
                    "duration_in_traffic": {
                        "text": "27 mins",
                        "value": 1614
                    },
                    "status": "OK"
                }
            ]
        }
    ],
    "status": "OK"
}
```

## Location Modifiers
You can use location modifiers to indicate how drivers should approach a particular location, by using the **side_of_road** modifier to specify which side of the road to use, or by specifying a heading to indicate the correct direction of travel.

*Specify that calculated routes must pass through a particular side of the road*

When specifying a location, you can request that the calculated route go through whichever side of the road the waypoint is biased towards by using the **side_of_road**: prefix. For example, this request will return the distance for a long route so that the vehicle ends on the side of the road to which the waypoint was biased:

```code
http://127.0.0.1:8080/distancematrix?origins=37.7680296%2C-122.4375126&destinations=side_of_road%3A37.7663444%2C-122.4412006

OR

http://127.0.0.1:8080/maps/api/distancematrix/json?origins=37.7680296%2C-122.4375126&destinations=side_of_road%3A37.7663444%2C-122.4412006
```

When using **side_of_road**: with encoded polylines, the modifier is applied to every location along the polyline. For example, the two destinations in this request both use the parameter:

```code
http://127.0.0.1:8080/distancematrix?origins=San%20Francisco%20City%20hall&destinations=side_of_road%3Aenc%3A%7BoqeF%60fejV%5BnC%3A

OR

http://127.0.0.1:8080/maps/api/distancematrix/json?origins=San%20Francisco%20City%20hall&destinations=side_of_road%3Aenc%3A%7BoqeF%60fejV%5BnC%3A
```

The **side_of_road**: modifier may only be used with this restriction:

  * The travel mode parameter is driving, or is not specified (**driving** is the default travel mode).

*Specify that calculated routes should have a particular heading*

When specifying a location, you can request that the calculated route go through the location in a particular heading. This heading is specified with the prefix heading=X:, where X is an integer degree value between 0 (inclusive) and 360 (exclusive). A heading of 0 indicates North, 90 indicates East, and so on, continuing clockwise. For example, in this request the calculated route goes east from the origin, then takes a U-turn:

```code
http://127.0.0.1:8080/distancematrix?origins=heading%3D90%3A37.773279%2C-122.468780&destinations=37.773245%2C-122.469502

OR

http://127.0.0.1:8080/maps/api/distancematrix/json?origins=heading%3D90%3A37.773279%2C-122.468780&destinations=37.773245%2C-122.469502
```

The **heading=X**: modifier may only be used with these restrictions:

  * The travel mode parameter is **driving**, **bicycling**, or is not specified (**driving** is the default travel mode).
  
  * The **side_of_road** modifier is not specified for the same location.
  
  * The location is specified with a latitude/longitude value. You may not use **heading** with addresses, Place IDs, or encoded polylines.

## Distance Matrix request and responses
A sample HTTP request is shown below, requesting distance and duration from Vancouver, BC, Canada and from Seattle, WA, USA, to San Francisco, CA, USA and to Victoria, BC, Canada.

```code
http://127.0.0.1:8080/distancematrix?origins=Vancouver%20BC%7CSeattle&destinations=San%20Francisco%7CVictoria%20BC&mode=bicycling&language=fr-FR

OR

http://127.0.0.1:8080/maps/api/distancematrix/json?origins=Vancouver%20BC%7CSeattle&destinations=San%20Francisco%7CVictoria%20BC&mode=bicycling&language=fr-FR
```

Results are returned in rows, each row containing one origin paired with each destination.

```code
{
    "destination_addresses": [
        "San Francisco, Californie, États-Unis",
        "Victoria, BC, Canada"
    ],
    "origin_addresses": [
        "Vancouver, BC, Canada",
        "Seattle, Washington, États-Unis"
    ],
    "rows": [
        {
            "elements": [
                {
                    "distance": {
                        "text": "1 711 km",
                        "value": 1710841
                    },
                    "duration": {
                        "text": "3 jours 16 heures",
                        "value": 317896
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "139 km",
                        "value": 138986
                    },
                    "duration": {
                        "text": "6 heures 48 minutes",
                        "value": 24502
                    },
                    "status": "OK"
                }
            ]
        },
        {
            "elements": [
                {
                    "distance": {
                        "text": "1 452 km",
                        "value": 1451707
                    },
                    "duration": {
                        "text": "3 jours 2 heures",
                        "value": 266745
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "146 km",
                        "value": 146491
                    },
                    "duration": {
                        "text": "2 heures 53 minutes",
                        "value": 10390
                    },
                    "status": "OK"
                }
            ]
        }
    ],
    "status": "OK"
}
```


## DistanceMatrixResponse

| Field | Required | Type | Description |
| --- | --- | --- | --- |
| destination_addresses | **required** | Array<string> | An array of addresses as returned by the API from your original request. As with **origin_addresses**, these are localized if appropriate. This content is meant to be read as-is. Do not programatically parse the formatted addresses. |
| origin_addresses | **required** | Array<string> | An array of addresses as returned by the API from your original request. These are formatted by the geocoder and localized according to the language parameter passed with the request. This content is meant to be read as-is. Do not programatically parse the formatted addresses. |
| rows | **required** | Array<[DistanceMatrixRow](#DistanceMatrixRow)> | An array of elements, which in turn each contain a **status**, **duration**, and **distance** element. |
| status | **required** | [DistanceMatrixStatus](#DistanceMatrixStatus) | Contains the status of the request, and may contain debugging information to help you track down why the request failed. |
| error_message | optional | string | A string containing the human-readable text of any errors encountered while the request was being processed. |


## DistanceMatrixStatus
Status codes returned by service.

* **OK** indicates the response contains a valid result.

* **INVALID_REQUEST** indicates that the provided request was invalid.

* **MAX_ELEMENTS_EXCEEDED** indicates that the product of origins and destinations exceeds the per-query limit.

* **MAX_DIMENSIONS_EXCEEDED** indicates that the number of origins or destinations exceeds the per-query limit.

* **OVER_DAILY_LIMIT** indicates any of the following:
  
  * The API account is missing or invalid.
    
  * Billing has not been enabled on your account.
    
  * A self-imposed usage cap has been exceeded.
    
  * The provided method of payment is no longer valid (for example, a credit card has expired).

* **OVER_QUERY_LIMIT** indicates the service has received too many requests from your application within the allowed time period.

* **REQUEST_DENIED** indicates that the service denied use of the directions service by your application.

* **UNKNOWN_ERROR** indicates a directions request could not be processed due to a server error. The request may succeed if you try again.

## DistanceMatrixRow

| Field | Required | Type | Description |
| --- | --- | --- | --- |
| **elements** | **required** | Array<[DistanceMatrixElement](#DistanceMatrixElement)> | When the Distance Matrix API returns results, it places them within a JSON rows array. Even if no results are returned (such as when the origins and/or destinations don't exist), it still returns an empty array.<br><br>Rows are ordered according to the values in the origin parameter of the request. Each row corresponds to an origin, and each element within that row corresponds to a pairing of the origin with a destination value.<br><br>Each row array contains one or more element entries, which in turn contain the information about a single origin-destination pairing. |


## DistanceMatrixElement

| Field | Required | Type | Description |
| --- | --- | --- | --- |
| **status** | **required** | [DistanceMatrixElementStatus](#DistanceMatrixElementStatus) | A status for the element. |
| **distance**| optional | [TextValueObject](#TextValueObject) | The total distance of this route, expressed in meters (value) and as text. The textual value uses the unit system specified with the unit parameter of the original request, or the origin's region. |
| **duration** | optional | [TextValueObject](#TextValueObject) | The length of time it takes to travel this route, expressed in seconds (the value field) and as text. The textual representation is localized according to the query's language parameter. |
| **duration_in_traffic** | optional | [TextValueObject](#TextValueObject) | The length of time it takes to travel this route, based on current and historical traffic conditions. See the **traffic_model** request parameter for the options you can use to request that the returned value is optimistic, pessimistic, or a best-guess estimate. The duration is expressed in seconds (the value field) and as text. The textual representation is localized according to the query's language parameter. The duration in traffic is returned only if all of the following are true:<br><br><li>The request includes a **departure_time** parameter.<li>Traffic conditions are available for the requested route.<li>The mode parameter is set to driving. |
| **fare** | optional | [Fare](#Fare) | If present, contains the total fare (that is, the total ticket costs) on this route. This property is only returned for transit requests and only for transit providers where fare information is available. |

## Fare
The total fare for the route.

```code
{
  "currency" : "USD",
  "value" : 6,
  "text" : "$6.00"
}
```

| Field | Required | Type | Description |
| --- | --- | --- | --- |
| **currency** | **required** | string | An [ISO 4217 currency code](https://en.wikipedia.org/wiki/ISO_4217) indicating the currency that the amount is expressed in. |
| **text** | **required** | string | The total fare amount, formatted in the requested language. |
| **value** | **required** | number | The total fare amount, in the currency specified. |

## DistanceMatrixElementStatus
* **OK** indicates the response contains a valid result.

* **NOT_FOUND** indicates that the origin and/or destination of this pairing could not be geocoded.

* **ZERO_RESULTS** indicates no route could be found between the origin and destination.

* **MAX_ROUTE_LENGTH_EXCEEDED** indicates the requested route is too long and cannot be processed.

## TextValueObject
An object containing a numeric value and its formatted text representation.

| Field | Required | Type | Description |
| --- | --- | --- | --- |
| **text** | **required** | string | String value. |
| **value** | **required** | number | Numeric value. |






