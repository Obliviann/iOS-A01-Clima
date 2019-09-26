//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
//1. import libraries
//Alamofire framework is used to create the GET request and fetch the data from the weather API
import Alamofire
import SwiftyJSON
import CoreLocation

                                                //2.                        //implementamos el protocolo
class WeatherViewController: UIViewController , CLLocationManagerDelegate, ChangeCityDelegate{
    
    //Constants
    //we define the URL we'll use to fetch the JSON data from
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    //The sign up API key to connect to the API
    let APP_ID = "e72ca729af228beabd5d20e3b7749713"

    //3. Declare instance variables here
    let locManager = CLLocationManager()
    var currentWeatherData : WeatherDataModel?  //guardaremos la resp del request
    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
        //4. Set up the location manager
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation() //5.
        
    }
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    
    //6. convert string into url in order to use with Alamofire - String interpolation
    //let url = URL(string: "http://api.openweathermap.org/data/2.5/weather")
    
    //6. Add Alamofire.request func, the response we get is a completion handler
    func getWeatherData(url : String){
                        //el primer valor (url) no te pide el param, solo el valor
        Alamofire.request(url, method: .get).responseJSON {
            (respuesta) in
            if respuesta.result.isSuccess{ //not ifSUccess
                print("Weather acquired!")
                
                
                
                //if - para desempaquetar el valor de respuesta.data
                if let resp = respuesta.data{       //var
                   self.updateWeatherData(responss: resp) //llamamos a nuestra func
                }
            }
            else {
                print("Error")
            }
        }
    }
    
    
    //MARK: - JSON Parsing
    /***************************************************************/

    //7.Write the updateWeatherData method here:
                                    //tipo
    func updateWeatherData(responss: Data){
        //8. parseamos
                        //metodo de Swifty con param data de tipo Data
        let json = try! JSON(data: responss)
        //TODO: 9. le pasamos los datos del json a nuestro constructor
        //currentWeatherData
        print(json)
        //llamo a la funcion para actualizar la vista
        updateUIWithWeatherData(weatherData: json)
    }
    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    //9. Write the updateUIWithWeatherData method here:
    //uso los campos del json para poner datos en la vista
    func updateUIWithWeatherData(weatherData: JSON){
//        cityLabel.text = weatherData.city
//        temperatureLabel.text = "\(weatherData.temperature)°"
//        weatherIcon.image = UIImage(named: weatherData.weatherIconName!)
    }
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    //5. Write the didUpdateLocations method here:
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
     
        //print(locManager.location?.coordinate.latitude)
        //guardamos en una var la última location del arr
        let loca = locations[locations.count-1]
        //aseguramos que solo se utilize la var si tiene valor
        guard let locValue = locManager.location
            else {
                return
            }
        //determina si es una loc válida, si lo es, dejamos de buscar, update una loc
        if loca.horizontalAccuracy > 0{
            locManager.stopUpdatingLocation()
            let lat = locValue.coordinate.latitude
            let long = locValue.coordinate.longitude
            //le asigno el valor a mis var; \()-> indica a un String que lo que hay entro del () es el valor de una var, en vez de tener que concatenar el string
            //la api te obliga a usar param con los nombre (lat, lon y appid)
            let uri = WEATHER_URL+"?lat=\(lat)&lon=\(long)&appid=\(APP_ID)"
            getWeatherData(url: uri)
        }
    }
    
    
    //Write the didFailWithError method here:
    
    
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    
    func newCityEntered(city: String) {
        //let params : [String : String] = ["q" : city, "appid" : APP_ID] //Sergio
        let params = WEATHER_URL+"?q=\(city)&appid=\(APP_ID)"
         getWeatherData(url: params)
    }

    //Write the PrepareForSegue Method here
    //sobreescribimos la func prepare que ya E, //coje todos los id de Stroyboard //desde cualquier sitio que tenga el id "changeCityName"
                            //segue: pantalla ala que vamos
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) { //el sender soy yo
        //si no se cumple esta condición, no hace nada
        if segue.identifier == "changeCityName" {
            //me creo una var, cuyo destino es el OTRO controlador, AHORA LO TENGO AQUÍ INSTANCIADO
            let destionationVC = segue.destination as! ChangeCityViewController
            //AQUÍ le doy el valor al delegate de ChangeCityViewController
            destionationVC.delegate = self
        }
        //
        //self.performSegue(withIdentifier: "sfds", sender: self)
    }
    //Si tuvieramos más botones, o hago un IBAction por botón, o lo hago así genérico
}


