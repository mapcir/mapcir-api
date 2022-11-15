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

> Note: URLs must be [properly encoded](./validurl.md) to be valid and are limited to 8192 characters for all web services. Be aware of this limit when constructing your URLs.

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

  > Note: For efficiency and accuracy, use place ID's when possible. These ID's are uniquely explicit like a lat/lng value pair and provide geocoding benefits for routing such as access points and traffic variables. Unlike an address, ID's do not require the service to perform a search or an intermediate request for place details; therefore, performance is better.

## Optional parameters
* **alternatives**
  
  If set to true, specifies that the Directions service may provide more than one route alternative in the response. Note that providing route alternatives may increase the response time from the server. This is only available for requests without intermediate waypoints.

* **arrival_time**
  
  Specifies the desired time of arrival for transit directions, in seconds since midnight, January 1, 1970 UTC. You can specify either **departure_time** or **arrival_time**, but not both. Note that **arrival_time** must be specified as an integer.


