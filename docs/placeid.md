# Place IDs

## Overview
A place ID is a textual identifier that uniquely identifies a place. The length of the identifier may vary (there is no maximum length for Place IDs). Examples:

* ChIJgUbEo8cfqokR5lP9_Wh_DaM

* GhIJQWDl0CIeQUARxks3icF8U8A

* EicxMyBNYXJrZXQgU3QsIFdpbG1pbmd0b24sIE5DIDI4NDAxLCBVU0EiGhIYChQKEgnRTo6ixx-qiRHo_bbmkCm7ZRAN

* EicxMyBNYXJrZXQgU3QsIFdpbG1pbmd0b24sIE5DIDI4NDAxLCBVU0E

* IhoSGAoUChIJ0U6OoscfqokR6P225pApu2UQDQ

Place IDs are available for most locations, including businesses, landmarks, parks, and intersections. It is possible for the same place or location to have multiple different place IDs. Place IDs may change over time.

You can use the same place ID across the Places API, Directions API, Matrix API, Geocoding API,...

## Retrieve place details using the place ID

Once you've identified the place ID for a place, you may reuse that value the next time you look up that place. For more information.

A common way of using place IDs is to search for a place (using the Places API, Directions API,...) then use the returned place ID to retrieve place details. You can store the place ID and use it to retrieve the same place details later.

## Example using the Places API

Using the Places API, you can find a place ID by doing a [Nearby Search](./nearbysearch.md) request.

The following example is a search request for places of type 'restaurant' within a 1500m radius of a point in Sydney, Australia, containing the word 'cruise':

```code
http://127.0.0.1:8080/nearbysearch?location=-33.8670522,151.1957362&radius=1500&type=restaurant&keyword=cruise

OR 

http://127.0.0.1:8080/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=1500&type=restaurant&keyword=cruise
```

The response includes a place ID in the place_id field, as shown in this snippet:

```code
{
  "html_attributions" : [],
  "results" : [
    {
      "geometry" : {
        "location" : {
          "lat" : -33.870775,
          "lng" : 151.199025
        }
      },
      ...
      "place_id" : "ChIJrTLr-GyuEmsRBfy61i59si0",
      ...
    }
  ],
  "status" : "OK"
}
```

Now you can send a [Place Details request](./placedetails.md), putting the place ID in the **place_id** parameter:

```code
http://127.0.0.1:8080/placedetails?place_id=ChIJrTLr-GyuEmsRBfy61i59si0

OR

http://127.0.0.1:8080/maps/api/place/details/json?place_id=ChIJrTLr-GyuEmsRBfy61i59si0
```


