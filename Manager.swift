//
//  Manager.swift
//  
//
//  Created by Juan Manuel Moreno on 19/9/18.
//

import UIKit
import Reachability
import CoreLocation

private let single = Manager()

class Manager: NSObject, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    var locationPattern: CLLocation!
    var locationCurrent: CLLocation!
    var regiona: CLCircularRegion!

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
            
            self.getLocation()
//            let aURL:NSURL = NSURL(string: "https://api.darksky.net/forecast/5bffa7a1da70ff0a39d4aaca51d96647/" + String(describing: locationManager.location?.coordinate.latitude) + "," + String(describing: locationManager.location?.coordinate.longitude))!
            let aURL:NSURL = NSURL(string: "https://api.darksky.net/forecast/5bffa7a1da70ff0a39d4aaca51d96647/37.8267,-122.4233")!

            var request: NSURLRequest = NSURLRequest.init(url: aURL as URL)
            var response: URLResponse?
            var error: NSError?
            do {
                
                // Recibimos
                let urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: &response)
                var result: NSMutableDictionary = try JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
                weather = result.mutableCopy() as! NSMutableDictionary // Agregamos a contenedor restaurantes
                print(weather)
            } catch (let e) {
                
                print(e)
            }
        }
        return weather
    }
    
    // MARK: Location
    
    func getLocation() {
    
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [CLLocation]!) {
        
    }
    
    func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion!) {
        
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        
    }
    
    func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion region: CLRegion) {

    }
    
    func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion?, withError error: NSError) {

    }
    
    // MARK: Misc
    
    func say() {
        
        print("Make me happy")
    }
    

}
