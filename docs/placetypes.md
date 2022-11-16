# Place Types

This page lists the supported values for the **types** property.

* [Table 1](#Table-1-Place-types) lists the types that are supported for place searches, and can be returned with Place details results, and as part of autocomplete place predictions.

* [Table 2](#Table-2-Additional-types-returned-by-the-Places-service) lists additional types that can be returned with Place details results, and as part of autocomplete place predictions.

* [Table 3](#Table-3-Type-collections-supported-in-Place-Autocomplete-requests) lists types you can use in place autocomplete requests.


## Table 1: Place types

The Place type values in Table 1 are used in the following ways:

* As part of a Place details response. The request must specify the appropriate "types" data field.

* As part of an Autocomplete place prediction. For more information on the rules for using these values, see [Places Autocomplete](./placeautocomplete.md).

* In the **type** parameter for [place searches](./textsearch.md) (Places API only), to restrict the results to places matching the specified type.

```code
  accounting              lawyer 

  airport                 library 

  amusement_park          light_rail_station 

  aquarium                liquor_store 

  art_gallery             local_government_office 

  atm                     locksmith 

  bakery                  lodging 

  bank                     meal_delivery 

  bar                      meal_takeaway 

  beauty_salon             mosque 

  bicycle_store            movie_rental 

  book_store               movie_theater 

  bowling_alley            moving_company 

  bus_station              museum 

  cafe                     night_club 

  campground               painter 

  car_dealer               park 

  car_rental               parking 

  car_repair               pet_store 

  car_wash                 pharmacy 

  casino                   physiotherapist 

  cemetery                 plumber 

  church                   police 

  city_hall                post_office 

  clothing_store           primary_school 

  convenience_store        real_estate_agency 

  courthouse               restaurant 

  dentist                  roofing_contractor 

  department_store         rv_park 

  doctor                   school 

  drugstore                secondary_school 

  electrician              shoe_store 

  electronics_store        shopping_mall 

  embassy                  spa 

  fire_station             stadium 

  florist                  storage 

  funeral_home             store 

  furniture_store          subway_station 

  gas_station              supermarket 

  gym                      synagogue 

  hair_care                taxi_stand 

  hardware_store           tourist_attraction 

  hindu_temple             train_station 

  home_goods_store         transit_station 

  hospital                 university 

  insurance_agency         university 

  jewelry_store            veterinary_care 

  laundry                  zoo 
```


## Table 2: Additional types returned by the Places service
The Place type values in Table 2 are used in the following ways:

  * As part of the result of a Place details request (for example, a call to fetchPlace()), or anywhere a Place result is returned. The request must specify the appropriate "types" data field.

  * As part of an Autocomplete place prediction. For more information on the rules for using these values, see [Places Autocomplete](./placeautocomplete.md).

  * To denote address components.

For more details on these types, refer to [Address Types](./geocoding.md#Address-types-and-address-component-types).

> **Note:** The types below are not supported in the type filter of a place search.

```code
    administrative_area_level_1        plus_code 

    administrative_area_level_2        point_of_interest 

    administrative_area_level_3        political 

    administrative_area_level_4        post_box

    administrative_area_level_5        postal_code 

    administrative_area_level_6        postal_code_prefix 

    administrative_area_level_7        postal_code_suffix 

    archipelago                        postal_town

    colloquial_area                    premise

    continent                          room

    country                            route

    establishment                      street_address

    finance                            street_number

    floor                              sublocality

    food                               sublocality_level_1

    general_contractor                 sublocality_level_2

    geocode                            sublocality_level_3

    health                             sublocality_level_4

    intersection                       sublocality_level_5

    landmark                           subpremise

    locality                           town_square

    natural_feature

    neighborhood

    place_of_worship
```


## Table 3: Type collections supported in Place Autocomplete requests
Use the Place type values in Table 3, or the values in Table 1 and Table 2, as part of a Place Autocomplete request to restrict the results to a specific type.

Only a single type from Table 3 is allowed in the request. If you do specify a value from Table 3, you cannot specify a value from Table 1 or Table 2.

For more information on the rules for using these values, see [Places Autocomplete](./placeautocomplete.md).

The supported types are:

  * **geocode** instructs the Place Autocomplete service to return only geocoding results, rather than business results. Generally, you use this request to disambiguate results where the location specified may be indeterminate.

  * **address** instructs the Place Autocomplete service to return only geocoding results with a precise address. Generally, you use this request when you know the user will be looking for a fully specified address.

  * **establishment** instructs the Place Autocomplete service to return only business results.

  * The (**regions**) type collection instructs the Places service to return any result matching the following types:

    * **locality**

    * **sublocality**

    * **postal_code**

    * **country**

    * **administrative_area_level_1**

    * **administrative_area_level_2**

  * The (**cities**) type collection instructs the Places service to return results that match **locality** or **administrative_area_level_3**.
