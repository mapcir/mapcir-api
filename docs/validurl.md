# Building a valid URL

## Overview
You may think that a "valid" URL is self-evident, but that's not quite the case. A URL entered within an address bar in a browser, for example, may contain special characters (e.g. "上海+中國"); the browser needs to internally translate those characters into a different encoding before transmission. By the same token, any code that generates or accepts UTF-8 input might treat URLs with UTF-8 characters as "valid", but would also need to translate those characters before sending them out to a web server. This process is called [URL-encoding](https://en.wikipedia.org/wiki/Query_string#URL_encoding) or [percent-encoding](https://en.wikipedia.org/wiki/Percent-encoding).

> Note: Browsers and/or services may automatically URL-encode a request URI before sending. On APIs that use cryptographic request signing, this can potentially invalidate the signature, if URL-encoding alters the request after signing. To avoid this issue, always URL-encode your query string before signing the request.

## Special characters

We need to translate special characters because all URLs need to conform to the syntax specified by the [Uniform Resource Identifier (URI)](https://www.rfc-editor.org/rfc/rfc3986) specification. In effect, this means that URLs must contain only a special subset of ASCII characters: the familiar alphanumeric symbols, and some reserved characters for use as control characters within URLs. This table summarizes these characters:

| Set | characters | URL usage |
| --- | --- | --- |
| Alphanumeric  | a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9 | Text strings, scheme usage (http), port (8080), etc. |
| Unreserved    | - _ . ~ | Text strings |
| Reserved      |  ! * ' ( ) ; : @ & = + $ , / ? % # [ ] | Control characters and/or Text Strings |

When building a valid URL, you must ensure that it contains only those characters shown in the Summary of Valid URL Characters table. Conforming a URL to use this set of characters generally leads to two issues, one of omission and one of substitution:

* Characters that you wish to handle exist outside of the above set. For example, characters in foreign languages such as 上海+中國 need to be encoded using the above characters. By popular convention, spaces (which are not allowed within URLs) are often represented using the plus '+' character as well.

* Characters exist within the above set as reserved characters, but need to be used literally. For example, ? is used within URLs to indicate the beginning of the query string; if you wish to use the string "? and the Mysterions," you'd need to encode the '?' character.

All characters to be URL-encoded are encoded using a '%' character and a two-character hex value corresponding to their UTF-8 character. For example, 上海+中國 in UTF-8 would be URL-encoded as %E4%B8%8A%E6%B5%B7%2B%E4%B8%AD%E5%9C%8B. The string ? and the Mysterians would be URL-encoded as %3F+and+the+Mysterians or %3F%20and%20the%20Mysterians.

## Common characters that need encoding

| Unsafe character | Encoded value |
| --- | --- |
| Space | %20 |
| " | %22 |
| < | %3C |
| > | %3E |
| # | %23 |
| % | %25 |
| | | %7C |

Converting a URL that you receive from user input is sometimes tricky. For example, a user may enter an address as "5th&Main St." Generally, you should construct your URL from its parts, treating any user input as literal characters.



