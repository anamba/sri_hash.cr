# sri_hash.cr - Generates SRI hash or complete script tag for a resource

[![Version](https://img.shields.io/github/tag/anamba/sri_hash.cr.svg?maxAge=360)](https://github.com/anamba/sri_hash.cr/releases/latest)
[![Build Status](https://travis-ci.org/anamba/sri_hash.cr.svg?branch=master)](https://travis-ci.org/anamba/sri_hash.cr)
[![License](https://img.shields.io/github/license/anamba/sri_hash.cr.svg)](https://github.com/anamba/sri_hash.cr/blob/master/LICENSE)

Subresource integrity helper for Crystal. More info on SRI: <https://developer.mozilla.org/en-US/docs/Web/Security/Subresource_Integrity>

## Installation

1.  Add the dependency to your `shard.yml`:

    ```yaml
    dependencies:
      sri_hash:
        github: anamba/sri_hash.cr
    ```

2.  Run `shards install`

## Usage

```crystal
require "sri_hash"

SRIHash.from_string("Example text")  # -> "sha256-ljgfRyA+rQLdERYr90sJ9dRLkTYUnUIAHmR1dX6cvmQ="

# downloads file using http-client, then computes hash
# NOTE: adds defer by default (pass defer: false to override)
SRIHash.script_tag("https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.0/jquery.slim.min.js")  # -> <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.0/jquery.slim.min.js" integrity="sha256-ZaXnYkHGqIhqTbJ6MB4l9Frs/r7U4jlx7ir8PJYBqbI=" crossorigin="anonymous" defer></script>
```

Algorithm defaults to sha256 (like [cdnjs](https://cdnjs.com/)), but can be changed, either on individual calls or globally:

```crystal
SRIHash.from_string("Example text", "sha384")  # -> "sha384-ccLtG4S0txUiu3s0kEOUSiKfr3poGC+i1midiPHzO/aDkeHwlXnP4ozRKWqOREqn"

SRIHash.settings.algorithm = "sha384"
SRIHash.from_string("Example text")  # -> "sha384-ccLtG4S0txUiu3s0kEOUSiKfr3poGC+i1midiPHzO/aDkeHwlXnP4ozRKWqOREqn"
```

## Contributing

1.  Fork it (<https://github.com/anamba/sri_hash.cr/fork>)
2.  Create your feature branch (`git checkout -b my-new-feature`)
3.  Commit your changes (`git commit -am 'Add some feature'`)
4.  Push to the branch (`git push origin my-new-feature`)
5.  Create a new Pull Request

## Contributors

-   [Aaron Namba](https://github.com/anamba) - creator and maintainer
