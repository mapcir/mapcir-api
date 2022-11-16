# Place Types

This page lists the supported values for the **types** property.

* [Table 1](#Table-1-Place-types) lists the types that are supported for place searches, and can be returned with Place details results, and as part of autocomplete place predictions.

* [Table 2](#Table-2-Additional-types-returned-by-the-Places-service) lists additional types that can be returned with Place details results, and as part of autocomplete place predictions.

* [Table 3](#Table-3-Type-collections-supported-in-Place-Autocomplete-requests) lists types you can use in place autocomplete requests.


## Table 1: Place types

The Place type values in Table 1 are used in the following ways:

* As part of a Place details response. The request must specify the appropriate "types" data field.

* As part of an Autocomplete place prediction. For more information on the rules for using these values, see Places Autocomplete.

* In the type parameter for place searches (Places API only), to restrict the results to places matching the specified type.


## Table 2: Additional types returned by the Places service
The Place type values in Table 2 are used in the following ways:

  * As part of the result of a Place details request (for example, a call to fetchPlace()), or anywhere a Place result is returned. The request must specify the appropriate "types" data field.

  * As part of an Autocomplete place prediction. For more information on the rules for using these values, see Places Autocomplete.

  * To denote address components.

For more details on these types, refer to [Address Types](./geocoding.md#Address-types-and-address-component-types).

> **Note:** The types below are not supported in the type filter of a place search.

| <!-- --> | <!-- --> |
| --- | --- |
| administrative_area_level_1 | plus_code |
| administrative_area_level_2 | point_of_interest |
  

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
