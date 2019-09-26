//
//  ChangeCityViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit


//Write the protocol declaration here: Un contrato, el delegate nos vale para que no haga nada hasta que le llegue la info
//Siempre que llamamos algo de fuera, es asíncrono
//0.creamos nuestro protocolo (className+Delegate), nuestro delegate, con tantas func dentro como necesitemos
protocol ChangeCityDelegate {
    func newCityEntered(city:String)
}

class ChangeCityViewController: UIViewController {
    
    //0.1 Declare the delegate variable here, soy yo mimo, mi protocolo: ?-> debo implementarlo
    var delegate : ChangeCityDelegate?
    
    //This is the pre-linked IBOutlets to the text field:
    @IBOutlet weak var changeCityTextField: UITextField!

    
    //This is the IBAction that gets called when the user taps on the "Get Weather" button:
    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        
        //1 Get the city name the user entered in the text field
        let cityName = changeCityTextField.text!
        //si no hubiera delegate, no lo envío a nadie
        
        //2 If we have a delegate set, call the method userEnteredANewCityName. Siempre que haya alguien a la escucha, le paso
        delegate?.newCityEntered(city: cityName)
        
        //3 dismiss the Change City View Controller to go back to the WeatherViewController
        
        //Animación: el self es relativo al ViewController
        self.dismiss(animated:true, completion: nil)
        
    }
    
    
    //This is the IBAction that gets called when the user taps the back button. It dismisses the ChangeCityViewController - cada vez que cambiamos de venta creamos una nueva inst
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        //dismiss: me lo cargo
        self.dismiss(animated: true, completion: nil)
    }
    
}
