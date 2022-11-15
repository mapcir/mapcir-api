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

As is standard in URLs, all parameters are separated using the ampersand (&) character. All reserved characters (for example the plus sign "+") must be URL-encoded. The list of parameters and their possible values are enumerated below.

## Required parameters


