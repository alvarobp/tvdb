# tvdb

Ruby wrapper for accessing TV shows information from the [TheTVDB](http://www.thetvdb.com) API.

## Example

    require 'tvdb'
    client = TVdb::Client.new('my_api_key')
    results = client.search('The Big Bang Theory')
    client.serie_in_language(results.first, 'fr')
    
## Copyright

Copyright (c) 2009 Álvaro Bautista, released under MIT license
