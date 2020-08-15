//
//  OpenWeatherWS+Model.swift
//  OpenWeatherFramework
//
//  Created by owee on 15/08/2020.
//  Copyright © 2020 Devios. All rights reserved.
//

import Foundation

public protocol OWAPIWeather : class {
    
    /// Request Param
    var cityNameRequest : String {get}
    
    /// City geo location, longitude
    var coordLon        : Double {get set}
    
    /// City geo location, latitude
    var coorLat         : Double {get set}
    
    /// Weather condition id
    var weatherId       : Int {get set}
    
    ///  Group of weather parameters (Rain, Snow, Extreme etc.)
    var weatherMain     : String {get set}
    
    /// Weather condition within the group.
    var weatherDesc     : String {get set}
    
    /// Weather icon id
    var weatherIcon     : String {get set}
    
    /// Temperature
    var mainTemp        : Double {get set}
    
    /// Temperature. This temperature parameter accounts for the human perception of weather.
    var mainFeelslike   : Double {get set}
    
    /// Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa
    var mainPressure    : Int {get set}
    
    /// Humidity, %
    var mainHumidity    : Int {get set}
    
    /// Minimum temperature at the moment. This is minimal currently observed temperature
    var mainTempMin     : Double {get set}
    
    /// Maximum temperature at the moment. This is maximal currently observed temperature
    var mainTempMax     : Double {get set}
    
    /// Visibility, meter
    var visibility  : Int {get set}
    
    /// Wind speed
    var windSpeed   : Double {get set}
    
    /// Wind direction, degrees (meteorological)
    var windDeg     : Int {get set}
    
    /// Cloudiness, %
    var cloudsAll   : Int {get set}
    
    /// Time of data calculation, unix, UTC
    var dt          : Int {get set}
    
    /// Country code (GB, JP etc.)
    var sysCountry  : String {get set}
    
    /// Sunrise time, unix, UTC
    var sysSunrise  : Int {get set}
    
    /// Sunset time, unix, UTC
    var sysSunset   : Int {get set}
    
    /// Shift in seconds from UTC
    var timezone    : Int {get set}
    
    /// City ID
    var id          : Int {get set}
    
    /// City name
    var name        : String {get set}
            
}
