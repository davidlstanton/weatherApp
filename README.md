
# Code Test Weather App
### Description:  
An iOS code test - building an MVP for a weather app to enable people to pack appropriately when they going on holiday.  The company name, user story, acceptance ctiteria and checklist as supplied have intentionally been omitted.

### In short: 

* The App should summarise the forecast for the next week to enable people to pack appropriately
* The test is bound to 8 hours work (starting 12:50 8/5/2017)
* Should use openweathermap.org api's
* Can use 3rd party libraries
* Should be implemented following TDD
* Should not be over engineered
* Should run in a simulator


## The following will probably read a bit like a blog (in reverse order) explaining my train of thought

### High level approach

* Look at OpenWeatherApi, understand what is needed to get info (login e.t.c.), work out which endpoints we will need.
* Sketch out the user journey on a white board, mvp so this should be the simplest version of that journey.
* Sketch out the design (UI) 
* Design the networking stack
* Will we need a caching layer, where should this sit, what rules should it follow.
* Mix eggs and bake follow TDD (taste before and after).

### OpenWeatherApi

* Licence Attribution-ShareAlike 4.0 (tldr: must provide attribution to OpenWeatherMap in app)
* API Key generated (live in 10 mins)
* API is well documented, https://openweathermap.org/api
* API appears to only be http (will have to generate create exception in app)
* API has a call for a week forcast with data points ever 3 hours. https://openweathermap.org/forecast5
* API does not have all data for all cities / times it seems.
    > If you do not see some of the parameters in your API respond it means that these weather phenomena are just not happened for the time of measurement for the city or location chosen. Only really measured or calculated data is displayed in API respond.
* API suggests using CityId.
* City id's avalible to download in a huge (30MB file) maybe preload this into the binary as a db?
* Also choosing a city will have to be more complicated than just a picker, there are alot of pickers.

### Network Stack

* Use Alamofire for easy model generation, error handling and abstraction
* Use a router model (as suggested by Alamofire)
* Lightweight service as possible that actually does the networking bit - the only bit that won't be covered by unit tests'
