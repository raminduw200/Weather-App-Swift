---
Aurthor: Ramindu Walgama 
Date: 2023-05-08
---

# Weather-App-Swift
This is a simple weather IOS app developed using SwiftUI. Connected with <a href="https://openweathermap.org/api/">OpenWeather API</a>. <br>
<hr> 

App features,
- Allow user to find weather infomation by selecting a location <br>
Consists of 5 views,
  - Home page: Basic weather information such as temperature, humidity, pressure. User can change the location from this view and will reflect the changes in other views.
  - Forecast view: More detailed view regarding today's weather. Inlcude wind speed, wind direction, sunset, sunrise etc.
  - Hourly Forecast: Give an hourly forecast weather information including temperture and how the weather would be fore each hour.
  - Daily forecast: Daily forecast for next upcoming 8 days(Including today). User can see expected minimum and highest temperature for each day, and how the day would be.
  - Pollution: Besides feel like temperature, user can see information such as Carbon monoxide (CO), Nitrogen monoxide (NO), Sulphur dioxide (SO2), and particulates (PM2.5 and PM10).
  
<hr>

## OpenWeather API
At the time of developing, this consists of two versions; 2.5 and 3. 
OpenWeather 2.5 API is being used to collect <a href="https://openweathermap.org/api/air-pollution">air pollution</a> information while <a href="https://openweathermap.org/api/one-call-3">OpenWeather 3.0 API</a> is being used to collect other data such as forecast, and current weather information.

