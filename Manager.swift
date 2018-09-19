//
//  Manager.swift
//  
//
//  Created by Juan Manuel Moreno on 19/9/18.
//

import UIKit
import Reachability

private let single = Manager()

class Manager: NSObject {

    // MARK: - Singleton
    
    class var instance: Manager {
        
        return single
    }

    // MARK: - Business
    
    func getWeather() -> NSMutableDictionary {
    
        // Evaluamos conectividad con framework cocoapods Reachability
        var networkReachability: Reachability = Reachability.forInternetConnection()
        var weather: NSMutableDictionary!
        
        if !networkReachability.isReachable() {
            
            print("No internet connection")
        } else {
            
            let aURL:NSURL = NSURL(string: "https://api.darksky.net/forecast/5bffa7a1da70ff0a39d4aaca51d96647/37.8267,-122.4233")! // REMAIN 998
            var request: NSURLRequest = NSURLRequest.init(url: aURL as URL)
            var response: URLResponse?
            var error: NSError?
            do {
                
                print("Oh yes")
                
                // Recibimos
                let urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: &response)
                var result: NSMutableDictionary = try JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
                weather = result.mutableCopy() as! NSMutableDictionary // Agregamos a contenedor restaurantes
            } catch (let e) {
                
                print(e)
            }
        }
        return weather
    }
    
    func say() {
        
        print("Make me happy")
    }
    

}
