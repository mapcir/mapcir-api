# Place Details API
> Once you have a **place_id** from a Place Search, you can request more details about a particular establishment or point of interest by initiating a Place Details request. A Place Details request returns more comprehensive information about the indicated place such as its complete address, phone number, user rating and reviews.

## Place Details requests
A Place Details request is an HTTP URL of the following form:

```code
http://{HOST}:{PORT}/placedetails?parameters

OR

http://{HOST}:{PORT}/maps/api/place/details/json?parameters
```

## Required parameters

* place_id

  A textual identifier that uniquely identifies a place, returned from a [Place Search](./findplace.md).

## Optional parameters

* fields

  Use the fields parameter to specify a comma-separated list of place data types to return. For example: **fields=formatted_address,name,geometry**. Use a forward slash when specifying compound values. For example: **opening_hours/open_now**.

  Fields are divided into three billing categories: Basic, Contact, and Atmosphere. Basic fields are billed at base rate, and incur no additional charges. Contact and Atmosphere fields are billed at a higher rate. See the pricing sheet for more information. Attributions, **html_attributions**, are always returned with every call, regardless of whether the field has been requested.

  *Basic*

  The Basic category includes the following fields: **address_component**, **adr_address**, **business_status**, **formatted_address**, **geometry**, **icon**, **icon_mask_base_uri**, **icon_background_color**, **name**, **permanently_closed**, **photo**, **place_id**, **plus_code**, **typev, **url**, **utc_offset**, **vicinity**.

  *Contact*

  The Contact category includes the following fields: **current_opening_hours**, **formatted_phone_number**, **international_phone_number**, **opening_hours**, **secondary_opening_hours**, **website**.

  *Atmosphere*

  The Atmosphere category includes the following fields: **curbside_pickup**, **delivery**, **dine_in**, **editorial_summary**, **price_level**, **rating**, **reviews**, **takeout**, **user_ratings_total**.

* language

The language in which to return results.

  * See the [list of supported languages](./language.md). Mapcir often updates the supported languages, so this list may not be exhaustive.

  * The API does its best to provide a street address that is readable for both the user and locals. To achieve that goal, it returns street addresses in the local language, transliterated to a script readable by the user if necessary, observing the preferred language. All other addresses are returned in the preferred language. Address components are all returned in the same language, which is chosen from the first component.

  * If a name is not available in the preferred language, the API uses the closest match.

  * The preferred language has a small influence on the set of results that the API chooses to return, and the order in which they are returned. The geocoder interprets abbreviations differently depending on language, such as the abbreviations for street types, or synonyms that may be valid in one language but not in another. For example, utca and tér are synonyms for street in Hungarian.

* region

The region code, specified as a [ccTLD ("top-level domain")](https://en.wikipedia.org/wiki/List_of_Internet_top-level_domains#Country_code_top-level_domains) two-character value. Most ccTLD codes are identical to ISO 3166-1 codes, with some notable exceptions. For example, the United Kingdom's ccTLD is "uk" (.co.uk) while its ISO 3166-1 code is "gb" (technically for the entity of "The United Kingdom of Great Britain and Northern Ireland").

## Place Details example
The following example requests the details of a place by place_id, and includes the name, rating, and formatted_phone_number fields:

```code
http://{HOST}:{PORT}/placedetails?place_id=ChIJN1t_tDeuEmsRUsoyG83frY4&fields=name%2Crating%2Cformatted_phone_number

OR

http://{HOST}:{PORT}/maps/api/place/details/json?place_id=ChIJN1t_tDeuEmsRUsoyG83frY4&fields=name%2Crating%2Cformatted_phone_number
```

## Place Details response

```code
{
  "html_attributions": [],
  "result":
    {
      "address_components":
        [
          { "long_name": "48", "short_name": "48", "types": ["street_number"] },
          {
            "long_name": "Pirrama Road",
            "short_name": "Pirrama Rd",
            "types": ["route"],
          },
          {
            "long_name": "Pyrmont",
            "short_name": "Pyrmont",
            "types": ["locality", "political"],
          },
          {
            "long_name": "City of Sydney",
            "short_name": "City of Sydney",
            "types": ["administrative_area_level_2", "political"],
          },
          {
            "long_name": "New South Wales",
            "short_name": "NSW",
            "types": ["administrative_area_level_1", "political"],
          },
          {
            "long_name": "Australia",
            "short_name": "AU",
            "types": ["country", "political"],
          },
          {
            "long_name": "2009",
            "short_name": "2009",
            "types": ["postal_code"],
          },
        ],
      "adr_address": '<span class="street-address">48 Pirrama Rd</span>, <span class="locality">Pyrmont</span> <span class="region">NSW</span> <span class="postal-code">2009</span>, <span class="country-name">Australia</span>',
      "business_status": "OPERATIONAL",
      "formatted_address": "48 Pirrama Rd, Pyrmont NSW 2009, Australia",
      "formatted_phone_number": "(02) 9374 4000",
      "geometry":
        {
          "location": { "lat": -33.866489, "lng": 151.1958561 },
          "viewport":
            {
              "northeast":
                { "lat": -33.8655112697085, "lng": 151.1971156302915 },
              "southwest":
                { "lat": -33.86820923029149, "lng": 151.1944176697085 },
            },
        },
      "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/generic_business-71.png",
      "icon_background_color": "#7B9EB0",
      "icon_mask_base_uri": "https://maps.gstatic.com/mapfiles/place_api/icons/v2/generic_pinlet",
      "international_phone_number": "+61 2 9374 4000",
      "name": "Google Workplace 6",
      "opening_hours":
        {
          "open_now": false,
          "periods":
            [
              {
                "close": { "day": 1, "time": "1700" },
                "open": { "day": 1, "time": "0900" },
              },
              {
                "close": { "day": 2, "time": "1700" },
                "open": { "day": 2, "time": "0900" },
              },
              {
                "close": { "day": 3, "time": "1700" },
                "open": { "day": 3, "time": "0900" },
              },
              {
                "close": { "day": 4, "time": "1700" },
                "open": { "day": 4, "time": "0900" },
              },
              {
                "close": { "day": 5, "time": "1700" },
                "open": { "day": 5, "time": "0900" },
              },
            ],
          "weekday_text":
            [
              "Monday: 9:00 AM – 5:00 PM",
              "Tuesday: 9:00 AM – 5:00 PM",
              "Wednesday: 9:00 AM – 5:00 PM",
              "Thursday: 9:00 AM – 5:00 PM",
              "Friday: 9:00 AM – 5:00 PM",
              "Saturday: Closed",
              "Sunday: Closed",
            ],
        },
      "photos":
        [
          {
            "height": 3024,
            "html_attributions":
              [
                '<a href="https://maps.google.com/maps/contrib/117600448889234589608">Cynthia Wei</a>',
              ],
            "photo_reference": "Aap_uEC6jqtpflLS8GxQqPHBjlcwBf2sri0ZErk9q1ciHGZ6Zx5HBiiiEsPEO3emtB1PGyWbBQhgPL2r9CshoVlJEG4xzB71QMhGBTqqeaCNk1quO3vTTiP50aM1kmOaBQ-DF1ER7zpu6BQOEtnusKMul0m4KA45wfE3h6Xh2IxjLNzx-IiX",
            "width": 4032,
          },
          {
            "height": 3264,
            "html_attributions":
              [
                '<a href="https://maps.google.com/maps/contrib/102493344958625549078">Heyang Li</a>',
              ],
            "photo_reference": "Aap_uECyRjHhOQgGaKTW6Z3ZfTEaDhNc44m0F6GrNSFIMffixwI5xqD35QhecdzVY-FUuDtVE1huu8-2HkxgI9Gwvy6W18fU-_E3UUkdSFBQqGK8_slKlT8BZZc66sTX53IEcTDrZfT-E5_YUBYBOm13yxOTOfWfEDABhaxCGC5Hu_XYh0fI",
            "width": 4912,
          },
          {
            "height": 3036,
            "html_attributions":
              [
                '<a href="https://maps.google.com/maps/contrib/104829437842034782235">Anna Linetsky</a>',
              ],
            "photo_reference": "Aap_uEAumTzSdhRHDutPAj6wVPSZZmBV-brI6TPFwI0tcQlbSR74z44mUPr4aXMQKck_AzHaKmbfR3P2c1qsu45i1RQPHrcpIXxrA78FmDjCdWYYZWUnFozdcmEj9OQ_V0G08adpKivMKZyeaQ1NuwRy9GhSopeKpzkzkFZG5vXMYPPSgpa1",
            "width": 4048,
          },
          {
            "height": 4016,
            "html_attributions":
              [
                '<a href="https://maps.google.com/maps/contrib/107755640736541028674">Jonah Dell</a>',
              ],
            "photo_reference": "Aap_uECC7cSbDkh-TdmXr6m5d5pgVXJmvXg8dF2jzhL0b0Ko4CtnVll6-tIvdz7vhbCsd3hl2u9EgZ4Y30FBxKmFcimfeYUgW2XJyv8JY5IYGuXsKkCLqpV3QH9dIGwoUv2uX0eosDsUsTN2DOlyOasUgVxcYqzIzEmrL5ofIssThQWZeozD",
            "width": 6016,
          },
          {
            "height": 3024,
            "html_attributions":
              [
                '<a href="https://maps.google.com/maps/contrib/115886271727815775491">Anthony Huynh</a>',
              ],
            "photo_reference": "Aap_uEDTdw58CglFmZZAR9iZ05x3y2oK9r5_dRqKWnbZKSS9gs6gp9AeBa1QDvBL6dzZyQAZfN8H2Eppu6y4NBaPOp-GkulZYiKRM7Yww8sUEv-8dmcq35Tx38pe4LEX2wIicFkQHedRgMc0FfV9aFtgosQ5ps5-HCjJSApg8eLGyuxxqPm9",
            "width": 4032,
          },
          {
            "height": 3024,
            "html_attributions":
              [
                '<a href="https://maps.google.com/maps/contrib/102939237947063969663">Jasen Baker</a>',
              ],
            "photo_reference": "Aap_uEAGqslqZPhZUk0T2Y6l7mkCYnY7JN9li4g5NkZsE0N4Cdy7_cZ-fZWyV02VhpQR4Ph4fLUL6_WTXrlGMXXzUJXUcSmSTs2d_Dzf3Q_A1y07Dm-vtv7pS3JXsWyrWETGIoT1pIj81PPdUc1vlR2i3GFMWAbx9rCC472ZJclY8JlvMg-x",
            "width": 4032,
          },
          {
            "height": 3024,
            "html_attributions":
              [
                '<a href="https://maps.google.com/maps/contrib/100678816592586275978">Jeremy Hsiao</a>',
              ],
            "photo_reference": "Aap_uEBaGxeN90YFjD-AUjxZqM44kpMcICKKBBhb0RQQS7DHHFaay8RRAwjWsAt8GEmmB5QnxrbQWHU3TwhVXXHP0m-YNp9Ds3ihpiFan0moNv4QB7kern5cfjWhhrWe8B0dz_vYvmPssJE24P-24YfWWHubOo0L2MjQyueZfDv57N_RvDZk",
            "width": 4032,
          },
          {
            "height": 1515,
            "html_attributions":
              [
                '<a href="https://maps.google.com/maps/contrib/112343109286948028063">Andrew W</a>',
              ],
            "photo_reference": "Aap_uEBDzJlmTeNUreMop6_hkC1HKTCRLyPs5fikJi58qCejtkWp5PIM6vzNN3HErkSWUwnamTr_WLyT7jXMAIdByR-hx8dG-OHjj5JxzmcPvuT_VeVLmdSbNPeIlpmp6EUcPOhaVrhEKojSd44QXkl0za29eZ0oj1KDOnAsGxmhanDFW7lI",
            "width": 2048,
          },
          {
            "height": 3024,
            "html_attributions":
              [
                '<a href="https://maps.google.com/maps/contrib/100678816592586275978">Jeremy Hsiao</a>',
              ],
            "photo_reference": "Aap_uEBvYFpzCDQzvQ0kdBxxB70lTkLbTM0yH3xF-BCHsb7DQ63cuWnutvwv8oVLDSbA14_kns3WVlEInTyy2elvmH5lzQteb6zzRu3exkwE65_55TgJqdLO7RYYiPFliWk4ocszn9nn5ELv5uP2BQmqr9QET5vwgxR-0eshyVmcdM42jb39",
            "width": 4032,
          },
          {
            "height": 4032,
            "html_attributions":
              [
                '<a href="https://maps.google.com/maps/contrib/100678816592586275978">Jeremy Hsiao</a>',
              ],
            "photo_reference": "Aap_uECQynuD_EnSnbz8sJQ6-B6uR-j2tuu4Z1tuGUjq8xnxFDk-W8OdeLzWBX8suNKTCsPlkzTqC22BXf_hX33XclGPL4SS9xnPmHcMrLoUl0H_xHYevFvT17Hgw5DZpSyVmLvDvxzzJ1rsZTh55QwopmAty083a1r1ZIfL32iXh_q8FUas",
            "width": 3024,
          },
        ],
      "place_id": "ChIJN1t_tDeuEmsRUsoyG83frY4",
      "plus_code":
        {
          "compound_code": "45MW+C8 Pyrmont NSW, Australia",
          "global_code": "4RRH45MW+C8",
        },
      "rating": 4,
      "reference": "ChIJN1t_tDeuEmsRUsoyG83frY4",
      "reviews":
        [
          {
            "author_name": "Luke Archibald",
            "author_url": "https://www.google.com/maps/contrib/113389359827989670652/reviews",
            "language": "en",
            "profile_photo_url": "https://lh3.googleusercontent.com/a-/AOh14GhGGmTmvtD34HiRgwHdXVJUTzVbxpsk5_JnNKM5MA=s128-c0x00000000-cc-rp-mo",
            "rating": 1,
            "relative_time_description": "a week ago",
            "text": "Called regarding paid advertising google pages to the top of its site of a scam furniture website misleading and taking peoples money without ever sending a product - explained the situation,  explained I'd spoken to an ombudsman regarding it.  Listed ticket numbers etc.\n\nThey left the advertisement running.",
            "time": 1652286798,
          },
          {
            "author_name": "Tevita Taufoou",
            "author_url": "https://www.google.com/maps/contrib/105937236918123663309/reviews",
            "language": "en",
            "profile_photo_url": "https://lh3.googleusercontent.com/a/AATXAJwZANdRSSg96QeZG--6BazG5uv_BJMIvpZGqwSz=s128-c0x00000000-cc-rp-mo",
            "rating": 1,
            "relative_time_description": "6 months ago",
            "text": "I need help.  Google Australia is taking my money. Money I don't have any I am having trouble sorting this issue out",
            "time": 1637215605,
          },
          {
            "author_name": "Jordy Baker",
            "author_url": "https://www.google.com/maps/contrib/102582237417399865640/reviews",
            "language": "en",
            "profile_photo_url": "https://lh3.googleusercontent.com/a/AATXAJwgg1tM4aVA4nJCMjlfJtHtFZuxF475Vb6tT74S=s128-c0x00000000-cc-rp-mo",
            "rating": 1,
            "relative_time_description": "4 months ago",
            "text": "I have literally never been here in my life, I am 17 and they are taking money I don't have for no reason.\n\nThis is not ok. I have rent to pay and my own expenses to deal with and now this.",
            "time": 1641389490,
          },
          {
            "author_name": "Prem Rathod",
            "author_url": "https://www.google.com/maps/contrib/115981614018592114142/reviews",
            "language": "en",
            "profile_photo_url": "https://lh3.googleusercontent.com/a/AATXAJyEQpqs4YvPPzMPG2dnnRTFPC4jxJfn8YXnm2gz=s128-c0x00000000-cc-rp-mo",
            "rating": 1,
            "relative_time_description": "4 months ago",
            "text": "Terrible service. all reviews are fake and irrelevant. This is about reviewing google as business not the building/staff etc.",
            "time": 1640159655,
          },
          {
            "author_name": "Husuni Hamza",
            "author_url": "https://www.google.com/maps/contrib/102167316656574288776/reviews",
            "language": "en",
            "profile_photo_url": "https://lh3.googleusercontent.com/a/AATXAJwRkyvoSlgd06ahkF9XI9D39o6Zc_Oycm5EKuRg=s128-c0x00000000-cc-rp-mo",
            "rating": 5,
            "relative_time_description": "7 months ago",
            "text": "Nice site. Please I want to work with you. Am Alhassan Haruna, from Ghana. Contact me +233553851616",
            "time": 1633197305,
          },
        ],
      "types": ["point_of_interest", "establishment"],
      "url": "https://maps.google.com/?cid=10281119596374313554",
      "user_ratings_total": 939,
      "utc_offset": 600,
      "vicinity": "48 Pirrama Road, Pyrmont",
      "website": "http://google.com/",
    },
  "status": "OK",
}
```

## PlacesDetailsResponse

| Field | Required | Type | Description |
| --- | --- | --- | --- |
| **html_attributions** | **required** | Array<string> | May contain a set of attributions about this listing which must be displayed to the user (some listings may not have attribution). |
| **result** | **required** | [Place](#Place) | Contains the detailed information about the place requested. |
| **status** | **required** | [PlacesDetailsStatus](#PlacesDetailsStatus) | Contains the status of the request, and may contain debugging information to help you track down why the request failed. |
| **info_messages** | **optional** | Array<string> | When the service returns additional information about the request specification, there may be an additional **info_messages** field within the response object. This field is only returned for successful requests. It may not always be returned, and its content is subject to change. |

## PlacesDetailsStatus
Status codes returned by service.

* **OK** indicating the API request was successful.

* **ZERO_RESULTS** indicating that the referenced location, **place_id**, was valid but no longer refers to a valid result. This may occur if the establishment is no longer in business.

* **INVALID_REQUEST** indicating the API request was malformed.

* **UNKNOWN_ERROR** indicating an unknown error.


## Place
Attributes describing a place. Not all attributes will be available for all place types.

| Field | Required | Type | Description |
| --- | --- | --- | --- |
| **address_components** | optional | Array<[AddressComponent](#AddressComponent)> |An array containing the separate components applicable to this address. |
| **adr_address** | optional | string | A representation of the place's address in the [adr microformat](http://microformats.org/wiki/adr). |
| **business_status** | optional | string | Indicates the operational status of the place, if it is a business. If no data exists, **business_status** is not returned.<br>The allowed values include: **OPERATIONAL**, **CLOSED_TEMPORARILY**, and **CLOSED_PERMANENTLY** |
| **curbside_pickup** | optional | boolean | Specifies if the business supports curbside pickup. |
| **current_opening_hours** | optional | [PlaceOpeningHours](#PlaceOpeningHours) | Contains the hours of operation for the next seven days (including today). The time period starts at midnight on the date of the request and ends at 11:59 pm six days later. This field includes the **special_days** subfield of all hours, set for dates that have exceptional hours. |
| **delivery** | optional | boolean | Specifies if the business supports delivery. |
| **dine_in** | optional | boolean | Specifies if the business supports indoor or outdoor seating options. |
| **editorial_summary** | optional | [PlaceEditorialSummary](#PlaceEditorialSummary) | Contains a summary of the place. A summary is comprised of a textual overview, and also includes the language code for these if applicable. Summary text must be presented as-is and can not be modified or altered. |
| **formatted_address** | optional | string | A string containing the human-readable address of this place.<br><br>Often this address is equivalent to the postal address. Note that some countries, such as the United Kingdom, do not allow distribution of true postal addresses due to licensing restrictions.<br><br>The formatted address is logically composed of one or more address components. For example, the address "111 8th Avenue, New York, NY" consists of the following components: "111" (the street number), "8th Avenue" (the route), "New York" (the city) and "NY" (the US state).<br><br>Do not parse the formatted address programmatically. Instead you should use the individual address components, which the API response includes in addition to the formatted address field. |
| **formatted_phone_number** | optional | string | Contains the place's phone number in its [local format](https://en.wikipedia.org/wiki/National_conventions_for_writing_telephone_numbers). |
| **geometry** | optional | [Geometry](#Geometry) | Contains the location and viewport for the location. |
| **icon** | optional | string | Contains the URL of a suggested icon which may be displayed to the user when indicating this result on a map. |
| **icon_background_color** | optional | string | Contains the default HEX color code for the place's category. |
| **icon_mask_base_uri** | optional | string | Contains the URL of a recommended icon, minus the **.svg** or **.png** file type extension. |
| **international_phone_number** | optional | string | Contains the place's phone number in international format. International format includes the country code, and is prefixed with the plus, +, sign.<br>For example, the international_phone_number for Google's Sydney, Australia office is **+61 2 9374 4000**. |
| **name** | optional | string | Contains the human-readable name for the returned result. For **establishment** results, this is usually the canonicalized business name. |
| **opening_hours** | optional | [PlaceOpeningHours](#PlaceOpeningHours) | Contains the regular hours of operation. |
| **photos** | optional | Array<[PlacePhoto](#PlacePhoto)> | An array of photo objects, each containing a reference to an image. A request may return up to ten photos. |
| **place_id** | optional | string | A textual identifier that uniquely identifies a place. To retrieve information about the place, pass this identifier in the place_id field of a Places API request. |
| **plus_code** | optional | [PlusCode](#PlusCode) | An encoded location reference, derived from latitude and longitude coordinates, that represents an area: 1/8000th of a degree by 1/8000th of a degree (about 14m x 14m at the equator) or smaller. Plus codes can be used as a replacement for street addresses in places where they do not exist (where buildings are not numbered or streets are not named). See [Open Location Code](https://en.wikipedia.org/wiki/Open_Location_Code). |
| **price_level** | optional | number | The price level of the place, on a scale of 0 to 4. The exact amount indicated by a specific value will vary from region to region. Price levels are interpreted as follows:<br><br><li>0 Free<li>1 Inexpensive<li>2 Moderate<li>3 Expensive<li>4 Very Expensive |
| **rating** | optional | number | Contains the place's rating, from 1.0 to 5.0, based on aggregated user reviews. |
| **reviews** | optional | Array<[PlaceReview](#PlaceReview)> | A JSON array of up to five reviews. By default, the reviews are sorted in order of relevance. |
| **secondary_opening_hours** | optional | [PlaceOpeningHours](#PlaceOpeningHours) | Contains an array of entries for the next seven days including information about secondary hours of a business. Secondary hours are different from a business's main hours. For example, a restaurant can specify drive through hours or delivery hours as its secondary hours. This field populates the **type** subfield, which draws from a predefined list of opening hours types (such as **DRIVE_THROUGH**, **PICKUP**, or **TAKEOUT**) based on the types of the place. This field includes the **special_days** subfield of all hours, set for dates that have exceptional hours. |
| **takeout** | optional | boolean | Specifies if the business supports takeout. |
| **types** | optional | Array<string> | Contains an array of feature types describing the given result. See the list of [supported types](./placetypes.md). |
| **url** | optional | string | Contains the URL of the official Google page for this place. This will be the Google-owned page that contains the best available information about the place. Applications must link to or embed this page on any screen that shows detailed results about the place to the user. |
| **abc** | optional | --- | --- |
| **abc** | optional | --- | --- |
| **abc** | optional | --- | --- |
| **abc** | optional | --- | --- |
| **abc** | optional | --- | --- |
| **abc** | optional | --- | --- |
| **abc** | optional | --- | --- |
| **abc** | optional | --- | --- |
| **abc** | optional | --- | --- |
| **abc** | optional | --- | --- |












