# National Rail API
## Installation

Use in a Bundler app. Add to bundler:
    gem "national_rail"

## Example Usage
The gem is extremely simple to use. There are two class methods that return the next departures or arrivals from a station.

```ruby
NationalRail::Timetable.departures(token, "BHM")
# => [{"origin":"Longbridge","origin_crs":"LOB","destination":"Four Oaks","destination_crs":"FOK","time":"14:45"},{"origin":"Wolverhampton","origin_crs":"WVH","destination":"Walsall","destination_crs":"WSL","time":"14:47"},...]

NationalRail::Timetable.arrivals(token, "BHM")
# => [{"origin":"Longbridge","origin_crs":"LOB","destination":"Four Oaks","destination_crs":"FOK","time":"14:42"},{"origin":"Wolverhampton","origin_crs":"WVH","destination":"Walsall","destination_crs":"WSL","time":"14:44"},...]            
```     

## Wrap it in Sinatra
I've used this in a simple Sinatra app. It's easy:

```ruby
require 'sinatra'
require 'national_rail'
require 'json'

get '/departures/:crs' do
  NationalRail::Timetable.departures('...', params[:crs]).to_json
end
get '/arrivals/:crs' do
  NationalRail::Timetable.arrivals('...', params[:crs]).to_json
end
```
            
## Contributing
Please feel free to fork and modify this code. 

## Licence

Copyright (c) 2012 Jeremy Walker

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.