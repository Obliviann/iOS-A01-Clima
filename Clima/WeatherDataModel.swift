//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Angela Yu on 24/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class WeatherDataModel {

    //Declare your model variables here
    var temp : Double?
    var city : String?
    var cond : Int?    //optional 1. String
    //var JSONStandard : String?
    
    //construcor de WeatherDataModel, initializer
    convenience init(temp :Double, city: String, conditionn:Int) {
        self.init()
        self.temp = temp
        self.city = city
        self.cond = conditionn
        //optional 2. updateWeatherIcon(condition : conditionn)
    }

    //This method turns a condition code into the name of the weather condition image
    
    func updateWeatherIcon(condition: Int) -> String {
        
    switch (condition) {
    //numeros : id del condition (weather) en el json
    //palabras: los nombres de las fotos que ha metido S
        case 0...300 :
            return "tstorm1"
        
        case 301...500 :
            return "light_rain"

        case 501...600 :
            return "shower3"
        
        case 601...700 :
            return "snow4"
        
        case 701...771 :
            return "fog"
        
        case 772...799 :
            return "tstorm3"
        
        case 800 :
            return "sunny"
        
        case 801...804 :
            return "cloudy2"
        
        case 900...903, 905...1000  :
            return "tstorm3"
        
        case 903 :
            return "snow5"
        
        case 904 :
            return "sunny"
        
        default :
            return "dunno"
        }
    }
}
