//
//  OpenWeatherWS+Model.swift
//  OpenWeatherFramework
//
//  Created by owee on 15/08/2020.
//  Copyright © 2020 Devios. All rights reserved.
//

import Foundation

public protocol OWAPIWeather : class {
    
    var cityName    : String {get set}
    
    var lon         : Double {get set}
    var lat         : Double {get set}
    
    var base        : String {get set}
    
    var main        : String {get set}
    var desc        : String {get set}
    var icon        : String {get set}
    
    var temp        : Double {get set}
    var feelsLike   : Double {get set}
    var tempMin     : Double {get set}
    var tempMax     : Double {get set}
    var pressure    : Int {get set}
    var humidity    : Int {get set}
    
    var visibility  : Int {get set}
    
    var clouds      : Int {get set}
    
    var timezone    : Int {get set}
    
    var id          : Int {get set}
    var sunrise     : Int {get set}
    var sunset      : Int {get set}
        
}
