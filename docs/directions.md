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

### Required parameters

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

### Optional parameters
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

* **transit_routing_preference**

  Specifies preferences for transit routes. Using this parameter, you can bias the options returned, rather than accepting the default best route chosen by the API. This parameter may only be specified for transit directions. The parameter supports the following arguments:

  * **less_walking** indicates that the calculated route should prefer limited amounts of walking.

  * **fewer_transfers** indicates that the calculated route should prefer a limited number of transfers.

* **units**

  Specifies the unit system to use when displaying results.

  Directions results contain text within distance fields that may be displayed to the user to indicate the distance of a particular "step" of the route. By default, this text uses the unit system of the origin's country or region.

  For example, a route from "Chicago, IL" to "Toronto, ONT" will display results in miles, while the reverse route will display results in kilometers. You may override this unit system by setting one explicitly within the request's units parameter, passing one of the following values:

  * **metric** specifies usage of the metric system. Textual distances are returned using kilometers and meters.

  * **imperial** specifies usage of the Imperial (English) system. Textual distances are returned using miles and feet.

  > **Note:** this unit system setting only affects the text displayed within distance fields. The distance fields also contain values which are always expressed in meters.

* **waypoints**
 
  > **Note:** Requests using more than 10 waypoints (between 11 and 25), or waypoint optimization.

  Specifies an array of intermediate locations to include along the route between the origin and destination points as pass through or stopover locations. Waypoints alter a route by directing it through the specified location(s). The API supports waypoints for these travel modes: driving, walking and bicycling; not transit. You can supply one or more locations separated by the pipe character (| or %7C), in the form of a place ID, an address, or latitude/longitude coordinates. By default, the Directions service calculates a route using the waypoints in the order they are given. The precedence for parsing the value of the waypoint is place ID, latitude/longitude coordinates, then address.

  * If you pass a place ID, you must prefix it with **place_id**:. You can retrieve place IDs from the Geocoding API and the Places API (including Place Autocomplete).

  > For efficiency and accuracy, use place ID's when possible. These ID's are uniquely explicit like a lat/lng value pair and provide geocoding benefits for routing such as access points and traffic variables. Unlike an address, ID's do not require the service to perform a search or an intermediate request for place details; therefore, performance is better.

  * If you pass latitude/longitude coordinates, the values go directly to the front-end server to calculate directions without geocoding. The points are snapped to roads and might not provide the accuracy your app needs. Use coordinates when you are confident the values truly specify the points your app needs for routing without regard to possible access points or additional geocoding details. Ensure that a comma (%2C) and not a space (%20) separates the latitude and longitude values.

  * If you pass an address, the Directions service will geocode the string and convert it into latitude/longitude coordinates to calculate directions. If the address value is ambiguous, the value might evoke a search to disambiguate from similar addresses. For example, "1st Street" could be a complete value or a partial value for "1st street NE" or "1st St SE". This result may be different from that returned by the Geocoding API. You can avoid possible misinterpretations using place IDs.


**Influence routes with stopover and pass through points**

For each waypoint in the request, the directions response appends an entry to the legs array to provide the details for stopovers on that leg of the journey.

If you'd like to influence the route using waypoints without adding a stopover, add the prefix via: to the waypoint. Waypoints prefixed with via: will not add an entry to the legs array, but will route the journey through the waypoint.

The following URL modifies the previous request such that the journey is routed through Lexington without stopping:

```code
http://127.0.0.1:8080/directions?origin=Boston,MA&destination=Concord,MA&waypoints=Charlestown,MA|via:Lexington,MA 

OR

http://127.0.0.1:8080/maps/api/directions/json?origin=Boston,MA&destination=Concord,MA&waypoints=Charlestown,MA|via:Lexington,MA 
```

The via: prefix is most effective when creating routes in response to the user dragging the waypoints on the map. Doing so allows the user to see how the final route may look in real-time and helps ensure that waypoints are placed in locations that are accessible to the Directions API.

> **Note:** Using the `via:` prefix to avoid stopovers results in directions that are strict in their interpretation of the waypoint. This interpretation may result in severe detours on the route or `ZERO_RESULTS` in the response status code if the Directions API is unable to create directions through that point.

**Optimize your waypoints**

By default, the Directions service calculates a route through the provided waypoints in their given order. Optionally, you may pass **optimize:true** as the first argument within the waypoints parameter to allow the Directions service to optimize the provided route by rearranging the waypoints in a more efficient order. (This optimization is an application of the traveling salesperson problem.) Travel time is the primary factor which is optimized, but other factors such as distance, number of turns and many more may be taken into account when deciding which route is the most efficient. All waypoints must be stopovers for the Directions service to optimize their route.


If you instruct the Directions service to optimize the order of its waypoints, their order will be returned in the **waypoint_order** field within the routes object. The **waypoint_order** field returns values which are zero-based.

The following example calculates a road journey from Adelaide, South Australia to each of South Australia's main wine regions using route optimization.

```code
http://127.0.0.1:8080/directions?origin=Adelaide,SA&destination=Adelaide,SA&waypoints=optimize:true|Barossa+Valley,SA|Clare,SA|Connawarra,SA|McLaren+Vale,SA

OR 

http://127.0.0.1:8080/maps/api/directions/json?origin=Adelaide,SA&destination=Adelaide,SA&waypoints=optimize:true|Barossa+Valley,SA|Clare,SA|Connawarra,SA|McLaren+Vale,SA
```

Inspection of the calculated route will indicate that calculation uses waypoints in the following waypoint order:

```code
"waypoint_order": [ 3, 2, 0, 1 ]
```

> **Note:** Requests using waypoint optimization are billed at a higher rate

## Directions examples
The following request returns driving directions from Toronto, Ontario to Montreal, Quebec.

```code
http://127.0.0.1:8080/directions?origin=Toronto&destination=Montreal

OR

http://127.0.0.1:8080/maps/api/directions/json?origin=Toronto&destination=Montreal
```

By changing the **mode** and **avoid** parameters, the initial request can be modified to return directions for a scenic bicycle journey that avoids major highways.

```code
http://127.0.0.1:8080/directions?origin=Toronto&destination=Montreal&avoid=highways&mode=bicycling

OR

http://127.0.0.1:8080/maps/api/directions/json?origin=Toronto&destination=Montreal&avoid=highways&mode=bicycling
```

The following request searches for transit directions from Brooklyn, New York to Queens, New York. The request does not specify a **departure_time**, so the departure time defaults to the current time:

```code
http://127.0.0.1:8080/directions?origin=Brooklyn&destination=Queens&mode=transit

OR

http://127.0.0.1:8080/maps/api/directions/json?origin=Brooklyn&destination=Queens&mode=transit
```

The following transit request includes a specific departure time.

```code
http://127.0.0.1:8080/directions?origin=Brooklyn&destination=Queens&mode=transit&departure_time=1343641500

OR

http://127.0.0.1:8080/maps/api/directions/json?origin=Brooklyn&destination=Queens&mode=transit&departure_time=1343641500
```

The following request uses plus codes to return driving directions from H8MW+WP to GCG2+3M in Kolkata, India.

```code
http://127.0.0.1:8080/directions?origin=H8MW%2BWP%20Kolkata%20India&destination=GCG2%2B3M%20Kolkata%20India

OR

http://127.0.0.1:8080/maps/api/directions/json?origin=H8MW%2BWP%20Kolkata%20India&destination=GCG2%2B3M%20Kolkata%20India
```

The following request returns driving directions from Glasgow, UK to Perth, UK using place IDs.

```code
http://127.0.0.1:8080/directions?origin=place_id%3AChIJ685WIFYViEgRHlHvBbiD5nE&destination=place_id%3AChIJA01I-8YVhkgRGJb0fW4UX7Y

OR

http://127.0.0.1:8080/maps/api/directions/json?origin=place_id%3AChIJ685WIFYViEgRHlHvBbiD5nE&destination=place_id%3AChIJA01I-8YVhkgRGJb0fW4UX7Y
```

### Travel modes
When you calculate directions, you may specify the transportation **mode** to use. By default, directions are calculated as **driving** directions. The following travel modes are supported:

* **driving** (default) indicates standard driving directions using the road network.

* **walking** requests walking directions via pedestrian paths & sidewalks (where available).

* **bicycling** requests bicycling directions via bicycle paths & preferred streets (where available).

* **transit** requests directions via public transit routes (where available). If you set the mode to **transit**, you can optionally specify either a **departure_time** or an **arrival_time**. If neither time is specified, the **departure_time** defaults to now (that is, the departure time defaults to the current time). You can also optionally include a **transit_mode** and/or a **transit_routing_preference**.

> **Note:** Both walking and bicycling directions may sometimes not include clear pedestrian or bicycling paths, so these directions will return warnings in the returned result which you must display to the user.


### Traffic information
Traffic information is used when all of the following apply (these are the conditions required to receive the **duration_in_traffic** field in the Directions response):

* The travel mode parameter is driving, or is not specified (driving is the default travel mode).

* The request includes a valid **departure_time** parameter. The **departure_time** can be set to the current time or some time in the future. It cannot be in the past.

* The request does not include stopover waypoints. If the request includes waypoints, prefix each waypoint with via: to influence the route but avoid stopovers. For example:

```code
&waypoints=via:San Francisco|via:Mountain View|...
```

Optionally, you can include the **traffic_model** parameter in your request to specify the assumptions to use when calculating time in traffic.

The following URL initiates a Directions request for a journey from Boston, MA to Concord, MA, via Charlestown and Lexington. The request includes a departure time, meeting all the requirements to return the duration_in_traffic field in the Directions response.

```code
http://127.0.0.1:8080/directions?origin=Boston%2C%20MA&destination=Concord%2C%20MA&waypoints=via%3ACharlestown%2CMA%7Cvia%3ALexington%2CMA&departure_time=now

OR

http://127.0.0.1:8080/maps/api/directions/json?origin=Boston%2C%20MA&destination=Concord%2C%20MA&waypoints=via%3ACharlestown%2CMA%7Cvia%3ALexington%2CMA&departure_time=now
```

### Waypoints

> **Note:** Requests using more than 10 waypoints (between 11 and 25), or waypoint optimization.

When calculating routes using the Directions API, you may specify waypoints to return a route that includes pass throughs or stopovers at intermediate locations. You can add waypoints to driving, walking or bicycling directions but not transit directions.

**Specify locations in the waypoints parameter.**

You can supply one or more locations separated by the pipe character (| or %7C), in the form of a place ID, an address, or latitude/longitude coordinates. By default, the Directions service calculates a route using the waypoints in the order they are given. The precedence for parsing the value of the waypoint is place ID, latitude/longitude coordinates, then address.

  * If you pass a place ID, you must prefix it with **place_id**:. You can retrieve place IDs from the Geocoding API and the Places API (including Place Autocomplete)

  * If you pass latitude/longitude coordinates, the values go directly to the front-end server to calculate directions without geocoding. The points are snapped to roads and might not provide the accuracy your app needs. Use coordinates when you are confident the values truly specify the points your app needs for routing without regard to possible access points or additional geocoding details. Ensure that a comma (%2C) and not a space (%20) separates the latitude and longitude values.

  * If you pass an address, the Directions service will geocode the string and convert it into latitude/longitude coordinates to calculate directions. If the address value is ambiguous, the value might evoke a search to disambiguate from similar addresses. For example, "1st Street" could be a complete value or a partial value for "1st street NE" or "1st St SE". This result may be different from that returned by the Geocoding API. You can avoid possible misinterpretations using place IDs.

**Influence routes with stopover and pass through points**

For each waypoint in the request, the directions response appends an entry to the legs array to provide the details for stopovers on that leg of the journey.

If you'd like to influence the route using waypoints without adding a stopover, add the prefix via: to the waypoint. Waypoints prefixed with via: will not add an entry to the legs array, but will route the journey through the waypoint.


**Optimize your waypoints**
By default, the Directions service calculates a route through the provided waypoints in their given order. Optionally, you may pass optimize:true as the first argument within the waypoints parameter to allow the Directions service to optimize the provided route by rearranging the waypoints in a more efficient order. (This optimization is an application of the traveling salesperson problem.) Travel time is the primary factor which is optimized, but other factors such as distance, number of turns and many more may be taken into account when deciding which route is the most efficient. All waypoints must be stopovers for the Directions service to optimize their route.

If you instruct the Directions service to optimize the order of its waypoints, their order will be returned in the waypoint_order field within the routes object. The **waypoint_order** field returns values which are zero-based.

### Restrictions
Directions may be calculated that adhere to certain restrictions. Restrictions are indicated by use of the avoid parameter, and an argument to that parameter indicating the restriction to avoid. The following restrictions are supported:

  * avoid=tolls

  * avoid=highways

  * avoid=ferries

It's possible to request a route that avoids any combination of tolls, highways and ferries by passing both restrictions to the avoid parameter. For example: **avoid=tolls|highways|ferries**.

> **Note:** the addition of restrictions does not preclude routes that include the restricted feature; it biases the result to more favorable routes.

### Unit systems
Directions results contain text within distance fields that may be displayed to the user to indicate the distance of a particular "step" of the route. By default, this text uses the unit system of the origin's country or region.

For example, a route from "Chicago, IL" to "Toronto, ONT" will display results in miles, while the reverse route will display results in kilometers. You may override this unit system by setting one explicitly within the request's units parameter, passing one of the following values:

  * **metric** specifies usage of the metric system. Textual distances are returned using kilometers and meters.

  * **imperial** specifies usage of the Imperial (English) system. Textual distances are returned using miles and feet.

> **Note:** this unit system setting only affects the text displayed within distance fields. The distance fields also contain values which are always expressed in meters.

### Region biasing
You can set the Directions service to return results from a specific region by using the region parameter. This parameter takes a two-character [ccTLD](https://en.wikipedia.org/wiki/Country_code_top-level_domain) (country code top-level domain) argument specifying the region bias. Most ccTLD codes are identical to ISO 3166-1 alpha-2 codes, with some notable exceptions. For example, the United Kingdom's ccTLD is "uk" (.co.uk) while its ISO 3166-1 code is "gb" (technically for the entity of "The United Kingdom of Great Britain and Northern Ireland")

You may utilize any domain in which the main Google Maps application has launched driving directions.

### Location Modifiers
You can use location modifiers to indicate how drivers should approach a particular location, by using the **side_of_road** parameter to specify which side of the road to use, or by specifying a heading to indicate the correct direction of travel. These modifiers may be freely mixed with the via: modifier for intermediate waypoints.

**Specify that routes must pass through a particular side of the road**

When specifying a waypoint, you can request that the route go through whichever side of the road the waypoint is biased towards by using the **side_of_road**: prefix.

The **side_of_road**: modifier may only be used with the following restrictions:

  * The travel mode parameter is driving, or is not specified (driving is the default travel mode).

**Specify that routes should have a particular heading**

When specifying a waypoint, you can request that the route go through the waypoint in a particular heading. This heading is specified with the prefix heading=X:, where X is an integer degree value between 0 (inclusive) and 360 (exclusive). A heading of 0 indicates North, 90 indicates East, and so on, continuing clockwise

The heading=X: modifier may only be used with the following restrictions:

  * The travel mode parameter is driving, bicycling, or is not specified (driving is the default travel mode).

  * The *side_of_road* modifier is not specified for the same location.

  * The location is specified with a latitude/longitude value. You may not use heading with addresses, Place IDs, or encoded polylines.

## Directions responses
A sample HTTP request is shown below, calculating the route from Chicago, IL to Los Angeles, CA via two waypoints in Joplin, MO and Oklahoma City, OK.

```code
http://127.0.0.1:8080/directions?origin=Chicago%2C%20IL&destination=Los%20Angeles%2C%20CA&waypoints=Joplin%2C%20MO%7COklahoma%20City%2C%20OK

OR

http://127.0.0.1:8080/maps/api/directions/json?origin=Chicago%2C%20IL&destination=Los%20Angeles%2C%20CA&waypoints=Joplin%2C%20MO%7COklahoma%20City%2C%20OK
```

Response:

```code
{
  "geocoded_waypoints":
    [
      {
        "geocoder_status": "OK",
        "place_id": "ChIJ7cv00DwsDogRAMDACa2m4K8",
        "types": ["locality", "political"],
      },
      {
        "geocoder_status": "OK",
        "place_id": "ChIJ69Pk6jdlyIcRDqM1KDY3Fpg",
        "types": ["locality", "political"],
      },
      {
        "geocoder_status": "OK",
        "place_id": "ChIJgdL4flSKrYcRnTpP0XQSojM",
        "types": ["locality", "political"],
      },
      {
        "geocoder_status": "OK",
        "place_id": "ChIJE9on3F3HwoAR9AhGJW_fL-I",
        "types": ["locality", "political"],
      },
    ],
  "routes":
    [
      {
        "bounds":
          {
            "northeast": { "lat": 41.8781139, "lng": -87.6297872 },
            "southwest": { "lat": 34.0523525, "lng": -118.2435717 },
          },
        "copyrights": "Map data ©2022 Google, INEGI",
        "legs":
          [
            {
              "distance": { "text": "579 mi", "value": 932311 },
              "duration": { "text": "8 hours 48 mins", "value": 31653 },
              "end_address": "Joplin, MO, USA",
              "end_location": { "lat": 37.0842449, "lng": -94.513284 },
              "start_address": "Chicago, IL, USA",
              "start_location": { "lat": 41.8781139, "lng": -87.6297872 },
              "steps":
                [
                  {
                    "distance": { "text": "443 ft", "value": 135 },
                    "duration": { "text": "1 min", "value": 24 },
                    "end_location": { "lat": 41.8769003, "lng": -87.6297353 },
                    "html_instructions": "Head <b>south</b> on <b>S Federal St</b> toward <b>W Van Buren St</b>",
                    "polyline": { "points": "eir~FdezuOdCEjBC" },
                    "start_location": { "lat": 41.8781139, "lng": -87.6297872 },
                    "travel_mode": "DRIVING",
                  },
                  ...
                  {
                    "distance": { "text": "2.8 mi", "value": 4508 },
                    "duration": { "text": "7 mins", "value": 412 },
                    "end_location": { "lat": 37.0840469, "lng": -94.5134959 },
                    "html_instructions": "Continue straight onto <b>I-44BL W</b>/<wbr/><b>E 7th St</b>",
                    "maneuver": "straight",
                    "polyline":
                      {
                        "points": "m}iaFjwp_QE`ICdCCfDCdDAfCCbCAr@AxAA~AAxAAxACdDA~@CzC?|@Ax@At@A~@AfAGh@ALAR?@?P?bAAdBAfBCbCAtAA|BAb@?n@?tC?~@@n@DxALXH`BLpBBZBl@Fp@HxAHpAHrABv@@DDxA@lA?`F?f@?~AAzA?|@?bA?rB?T?pEC`F?~EA`F?xAAl@?|A?jA?rC?~@AxB?h@?jBA~AAb@?\\?~A?pA?r@AbA?TApA?xEAr@?fAAv@@`@AP?JIV?x@?vACxDAvE?|BH^A|@?tBAfB?hC?pAAtA?tACnG?j@?N?lA?RAx@?zB?T?hAAhAAj@A`BAnAA\\ClB",
                      },
                    "start_location": { "lat": 37.0839082, "lng": -94.4627819 },
                    "travel_mode": "DRIVING",
                  },
                  ...
                ],
              "traffic_speed_entry": [],
              "via_waypoint": [],
            },
            ...
          ],
        "overview_polyline":
          {
            "points": "eir~FdezuOxyFzfFl`G|qZvtSzqo@d}EhlLtqIdjFhrTfvEdca@{_@p{\\~`\\f}MprT~qRbyPnvObbXd_TxaEdxYxjRxvUnz\\bDfeLbpLxv@pmLroD`fTxrYfkTti\\xp@baMj_MoG|xNrlNpiL~cKn`OloFroRbk@lmDn_FnxHnQnz^~Thlo@uVlcc@|rQrnM~lAvlP|sH~qUlkPbzRxvE`cF~rPn_K~b`@tbDpx\\toK|_g@ldD|s_@piIzwc@nzNtlNdrKxoTtkXpeXrsO`l_@brWbkjAptBxoa@npNfiRv_QtcbAxpBlwb@rt_@ry`@pcKjtPpuPj`H`mNpsFjzHfpN~hIdfbAp}JfxY`Fxo^vdUnhq@}k@~`bAkMvli@cClxIjmGfHblG~bRhtF|eI~jFffQzsLldRr`WdrKxtKxb_@zlNrxU|qUpfYdwNpzP|rRxsc@zgWfdYtdBrqR|~Iz~Qv`ApvRntK`jI`cZz}n@nsW`mcA`}WndvB~iCdiVpjJnlErfNplA`i@bcGojCpsl@yeEn|l@{hDtsu@tl@lxs@~~DditAjcJzrf@~qIr`l@bbJrme@~rI|zC~dBfrO|yEdne@qAj{y@Qrsj@diAdns@l}EpnYwmDjn|@ywAbso@~kB|au@`{Alj|@csLzxcBl^|cr@fyJvwd@rxNxnlAyuJhqWjtCbmy@lwNjwpA`cSdimApgBxeNwbCx~_@{dB|y~@cyC|tfBxU~di@inFpxi@_bLpad@~wEbcNkJdxTwkDdeX`aHxh\\pgKlhs@r]`c_@imGdjUeCvnYajFfnN`Gd}c@u_Unm\\itMldMinIpgBadIzhLskDdy\\}iFz|UuvPnfo@v_A`}n@nvR~da@pdS`qUfnDljY|qLrbRdwO|ig@jtKt}k@frM~qo@~~JpwS~bA~pSgeGbvQc{Bzib@yiWzkuAecD`dh@mjKnhf@qwBl_ZzpDn}Wg_CrfUonH~pVpA|bRapAthi@n|FbgPnd@|p[yi@vjVqzHrhd@cgG|zl@jyE~g^|oLjyYvvBprWlpDrtd@ahHbyhApiBteSxpNzkHjtw@|yDjaPrmTzu@tqZjv@f_TuyGjxL{yMlcFafGh{IxDthNpxC|nZvxBzyUnhEpieAdsN|zw@qmAblk@t}Bhb^gvA|ml@{vPjweAkkDhpj@mmFnyZ`eAnsLjxKbfDnhUnrTdaSjtH``m@f`b@xyBbyGrjJ_|DxyGcyD`~Gfe@drNluRd`GlaC}cBfgObcAhh]vM`q`@|oBvgv@",
          },
        "summary": "I-55 S and I-44",
        "warnings": [],
        "waypoint_order": [0, 1],
      },
    ],
  "status": "OK",
}
```

### DirectionsResponse
| Field | Required | Type | Description |
| --- | --- | --- | --- |
| **routes** | **required** | Array<[DirectionsRoute](#DirectionsRoute)> | Contains an array of routes from the origin to the destination. Routes consist of nested Legs and Steps. |
| **status** | **required** | [DirectionsStatus](#DirectionsStatus) | Contains the status of the request, and may contain debugging information to help you track down why the request failed. |
| **available_travel_modes** |optional | Array<[TravelMode](#TravelMode)> | Contains an array of available travel modes. This field is returned when a request specifies a travel mode and gets no results. The array contains the available travel modes in the countries of the given set of waypoints. This field is not returned if one or more of the waypoints are 'via waypoints'. |
| error_message | optional | string | When the service returns a status code other than OK, there may be an additional **error_message** field within the response object. This field contains more detailed information about the reasons behind the given status code. This field is not always returned, and its content is subject to change. |
| **geocoded_waypoints** | optional | Array<[DirectionsGeocodedWaypoint](#DirectionsGeocodedWaypoint)> | Contains an array with details about the geocoding of origin, destination and waypoints. Elements in the geocoded_waypoints array correspond, by their zero-based position, to the origin, the waypoints in the order they are specified, and the destination. <br><br>These details will not be present for waypoints specified as textual latitude/longitude values if the service returns no results. This is because such waypoints are only reverse geocoded to obtain their representative address after a route has been found. An empty JSON object will occupy the corresponding places in the geocoded_waypoints array. |

### DirectionsRoute
Routes consist of nested legs and steps.

| Field | Required | Type | Description |
| --- | --- | --- | --- |
| **bounds** | **required** | [Bounds](#Bounds) | Contains the viewport bounding box of the **overview_polyline**. |
| **copyrights** | **required** | string | Contains an array of warnings to be displayed when showing these directions. You must handle and display these warnings yourself. |
| **legs** | **required** | Array<[DirectionsLeg](#DirectionsLeg)> | An array which contains information about a leg of the route, between two locations within the given route. A separate leg will be present for each waypoint or destination specified. (A route with no waypoints will contain exactly one leg within the legs array.) Each leg consists of a series of steps. |
| **overview_polyline** | **required** | [DirectionsPolyline](#DirectionsPolyline) | Contains an object that holds an encoded polyline representation of the route. This polyline is an approximate (smoothed) path of the resulting directions. |
| **summary** | **required** | string | Contains a short textual description for the route, suitable for naming and disambiguating the route from alternatives. |
| **warnings** | **required** | Array<string> | Contains an array of warnings to be displayed when showing these directions. You must handle and display these warnings yourself. |
| **waypoint_order** | **required** | Array<integer> | An array indicating the order of any waypoints in the calculated route. This waypoints may be reordered if the request was passed optimize:true within its waypoints parameter. |
| **fare** | optional |[Fare](#Fare) | If present, contains the total fare (that is, the total ticket costs) on this route. This property is only returned for transit requests and only for routes where fare information is available for all transit legs. |

### Bounds
A rectangle in geographical coordinates from points at the southwest and northeast corners.

| Field | Required | Type | Description |
| --- | --- | --- | --- |
| **northeast** | **required** | [LatLngLiteral](#LatLngLiteral) | See [LatLngLiteral](#LatLngLiteral) for more information. |
| **southwest** | **required** | [LatLngLiteral](#LatLngLiteral) | See [LatLngLiteral](#LatLngLiteral) for more information. |

### LatLngLiteral
An object describing a specific location with Latitude and Longitude in decimal degrees.

| Field | Required | Type | Description |
| --- | --- | --- | --- |
| **lat** | **required** | number | Latitude in decimal degrees. |
| **lng** | **required** | number | Longitude in decimal degrees. |

### DirectionsLeg
| Field | Required | Type | Description |
| --- | --- | --- | --- |

| **end_address** | **required** | string | Contains the human-readable address (typically a street address) from reverse geocoding the **end_location** of this leg. This content is meant to be read as-is. Do not programmatically parse the formatted address. |

| **end_location** | **required** | [LatLngLiteral](#LatLngLiteral) | The latitude/longitude coordinates of the given destination of this leg. Because the Directions API calculates directions between locations by using the nearest transportation option (usually a road) at the start and end points, **end_location** may be different than the provided destination of this leg if, for example, a road is not near the destination. |

| **start_address** | **required** | string | Contains the human-readable address (typically a street address) resulting from reverse geocoding the **start_location** of this leg. This content is meant to be read as-is. Do not programmatically parse the formatted address. |

| **start_location** | **required** | [LatLngLiteral](#LatLngLiteral) | The latitude/longitude coordinates of the origin of this leg. Because the Directions API calculates directions between locations by using the nearest transportation option (usually a road) at the start and end points, **start_location** may be different than the provided origin of this leg if, for example, a road is not near the origin. |

| **steps** | **required** | Array<[DirectionsStep](#DirectionsStep)> | An array of steps denoting information about each separate step of the leg of the journey. |

| **traffic_speed_entry** | **required** | Array<[DirectionsTrafficSpeedEntry](#DirectionsTrafficSpeedEntry)> | Information about traffic speed along the leg. |

| **via_waypoint** | **required** | Array<[DirectionsViaWaypoint](#DirectionsViaWaypoint)> | The locations of via waypoints along this leg. |

| **arrival_time** | optional | [TimeZoneTextValueObject](#TimeZoneTextValueObject) | Contains the estimated time of arrival for this leg. This property is only returned for transit directions. |

| **departure_time** | optional | [TimeZoneTextValueObject](#TimeZoneTextValueObject) | Contains the estimated time of departure for this leg, specified as a Time object. The **departure_time** is only available for transit directions. |

| **distance** | optional | [TextValueObject](#TextValueObject) | The total distance covered by this leg. |

| **duration** | optional | [TextValueObject](#TextValueObject) | The total duration of this leg. |

| **duration_in_traffic** | optional | [TextValueObject](#TextValueObject) | Indicates the total duration of this leg. This value is an estimate of the time in traffic based on current and historical traffic conditions. See the **traffic_model** request parameter for the options you can use to request that the returned value is optimistic, pessimistic, or a best-guess estimate. The duration in traffic is returned only if all of the following are true: <br> <li> The request does not include stopover waypoints. If the request includes waypoints, they must be prefixed with **via**: to avoid stopovers. <li> The request is specifically for driving directions—the mode parameter is set to **driving**. <li> The request includes a **departure_time** parameter. <li> Traffic conditions are available for the requested route. |

### DirectionsStep
Each element in the steps array defines a single step of the calculated directions. A step is the most atomic unit of a direction's route, containing a single step describing a specific, single instruction on the journey. E.g. "Turn left at W. 4th St." The step not only describes the instruction but also contains distance and duration information relating to how this step relates to the following step. For example, a step denoted as "Merge onto I-80 West" may contain a duration of "37 miles" and "40 minutes," indicating that the next step is 37 miles/40 minutes from this step.

When using the Directions API to search for transit directions, the steps array will include additional transit details in the form of a transit_details array. If the directions include multiple modes of transportation, detailed directions will be provided for walking or driving steps in an inner steps array. For example, a walking step will include directions from the start and end locations: "Walk to Innes Ave & Fitch St". That step will include detailed walking directions for that route in the inner steps array, such as: "Head north-west", "Turn left onto Arelious Walker", and "Turn left onto Innes Ave".

| Field | Required | Type | Description |
| --- | --- | --- | --- |
| **duration** | **required** | [TextValueObject](#TextValueObject) | Contains the typical time required to perform the step, until the next step. This field may be undefined if the duration is unknown. |

| **end_location** | **required** | [LatLngLiteral](#LatLngLiteral) | Contains the location of the last point of this step. |

| **html_instructions** | **required** | string | Contains formatted instructions for this step, presented as an HTML text string. This content is meant to be read as-is. Do not programmatically parse this display-only content. |

| **polyline** | **required** | [DirectionsPolyline](#DirectionsPolyline) | Contains a single points object that holds an encoded polyline representation of the step. This polyline is an approximate (smoothed) path of the step. |

| **start_location** | **required** | [LatLngLiteral](#LatLngLiteral) | Contains the location of the starting point of this step. |

| **travel_mode** | **required** | [TravelMode](#TravelMode) | Contains the type of travel mode used. |

| **distance** | optional | [TextValueObject](#TextValueObject) | Contains the distance covered by this step until the next step. This field may be undefined if the distance is unknown. |

| **maneuver** | optional | string | Contains the action to take for the current step (turn left, merge, straight, etc.). Values are subject to change, and new values may be introduced without prior notice.<br>The allowed values include: turn-slight-left, turn-sharp-left, turn-left, turn-slight-right, turn-sharp-right, keep-right, keep-left, uturn-left, uturn-right, turn-right, straight, ramp-left, ramp-right, merge, fork-left, fork-right, ferry, ferry-train, roundabout-left, and roundabout-right |

| **steps** | optional |  | Contains detailed directions for walking or driving steps in transit directions. Substeps are only available when travel_mode is set to "transit". The inner steps array is of the same type as steps. |

| **transit_details** | optional | [DirectionsTransitDetails](#DirectionsTransitDetails) | Details pertaining to this step if the travel mode is TRANSIT. |

### TextValueObject
An object containing a numeric value and its formatted text representation.

| Field | Required | Type | Description |
| --- | --- | --- | --- |
| **text** | **required** | string | String value. |
| **value** | **required** | number | Numeric value. |

### DirectionsPolyline
[Polyline encoding](./polylineencoding.md) is a lossy compression algorithm that allows you to store a series of coordinates as a single string. Point coordinates are encoded using signed values. If you only have a few static points, you may also wish to use the interactive polyline encoding utility.

The encoding process converts a binary value into a series of character codes for ASCII characters using the familiar base64 encoding scheme: to ensure proper display of these characters, encoded values are summed with 63 (the ASCII character '?') before converting them into ASCII. The algorithm also checks for additional character codes for a given point by checking the least significant bit of each byte group; if this bit is set to 1, the point is not yet fully formed and additional data must follow.

Additionally, to conserve space, points only include the offset from the previous point (except of course for the first point). All points are encoded in Base64 as signed integers, as latitudes and longitudes are signed values. The encoding format within a polyline needs to represent two coordinates representing latitude and longitude to a reasonable precision. Given a maximum longitude of +/- 180 degrees to a precision of 5 decimal places (180.00000 to -180.00000), this results in the need for a 32 bit signed binary integer value.

| Field | Required | Type | Description |
| --- | --- | --- | --- |
| **points** | **required** | string | A single string representation of the polyline. |

### TravelMode

* **DRIVING** (default) indicates calculation using the road network.

* **BICYCLING** requests calculation for bicycling via bicycle paths & preferred streets (where available).

* **TRANSIT** requests calculation via public transit routes (where available).

* **WALKING** requests calculation for walking via pedestrian paths & sidewalks (where available).

### DirectionsTransitDetails
Additional information that is not relevant for other modes of transportation.

| Field | Required | Type | Description |
| --- | --- | --- | --- |

| **arrival_stop** | optional | [DirectionsTransitStop](#DirectionsTransitStop) | The arrival transit stop. |

| **arrival_time** | optional | [TimeZoneTextValueObject](#TimeZoneTextValueObject) |  |

| **departure_stop** | optional | [DirectionsTransitStop](#DirectionsTransitStop) | The departure transit stop. |

| **departure_time** | optional | [TimeZoneTextValueObject](#TimeZoneTextValueObject) |  |

| **headsign** | optional | string | Specifies the direction in which to travel on this line, as it is marked on the vehicle or at the departure stop. This will often be the terminus station. |

| **headway** | optional | integer | Specifies the expected number of seconds between departures from the same stop at this time. For example, with a headway value of 600, you would expect a ten minute wait if you should miss your bus. |

| **line** | optional | [DirectionsTransitLine](#DirectionsTransitLine) | Contains information about the transit line used in this step. |

| **num_stops** | optional | integer | The number of stops from the departure to the arrival stop. This includes the arrival stop, but not the departure stop. For example, if your directions involve leaving from Stop A, passing through stops B and C, and arriving at stop D, **num_stops** will return 3. |

| **trip_short_name** | optional | string | The text that appears in schedules and sign boards to identify a transit trip to passengers. The text should uniquely identify a trip within a service day. For example, "538" is the trip_short_name of the Amtrak train that leaves San Jose, CA at 15:10 on weekdays to Sacramento, CA. |


### DirectionsViaWaypoint
### DirectionsStatus
### DirectionsTrafficSpeedEntry

### TimeZoneTextValueObject



### Fare

