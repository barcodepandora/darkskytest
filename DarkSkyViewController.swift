//
//  DarkSkyViewController.swift
//  DarkSkyTest
//
//  Created by Juan Manuel Moreno on 19/9/18.
//  Copyright © 2018 Juan Manuel Moreno. All rights reserved.
//

import UIKit

class DarkSkyViewController: UIViewController {

    @IBOutlet weak var lblWeather: UILabel!
    @IBOutlet weak var lblToday: UILabel!
    @IBOutlet weak var lblDegreesToday: UILabel!
    @IBOutlet weak var lblTomorrow: UILabel!
    @IBOutlet weak var lblDegreesTomorrow: UILabel!
    @IBOutlet weak var lblAfterTomorrow: UILabel!
    @IBOutlet weak var lblDegreesAfterTomorrow: UILabel!
    
    @IBOutlet weak var imgToday: UIImageView!
    @IBOutlet weak var imgTomorrow: UIImageView!
    @IBOutlet weak var imgAfterTomorrow: UIImageView!
    
    var weather: NSMutableDictionary = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getWeather()
        loadWeather()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Business
    
    func getWeather() {
      
        let manager = Manager.instance
        weather = manager.getWeather()
        
        guard let data = try? JSONSerialization.data(withJSONObject: weather, options: []) else {
            exit(-1)
        }

    }
    
    func loadWeather() {
    
        // Weather
        
        var currently: NSMutableDictionary = weather.object(forKey: "currently") as! NSMutableDictionary
//        print(String(describing: currently.object(forKey: "temperature") as! NSNumber))
        lblWeather.text = String(describing: currently.object(forKey: "temperature") as! NSNumber)
        
        // Forecast
        
        var daily: NSMutableDictionary = weather.object(forKey: "daily") as! NSMutableDictionary
        let sprint: NSMutableArray = daily.object(forKey: "data") as! NSMutableArray
        var time1970: NSNumber
        var lunes: String
//        for day in sprint {
        
        var day: NSMutableDictionary = sprint[0] as! NSMutableDictionary
        time1970 = (day as! NSMutableDictionary).object(forKey: "time") as! NSNumber
        var exactDate = NSDate(timeIntervalSince1970: TimeInterval(truncating: time1970))
        lblToday.text = exactDate.dayOfTheWeek()
        lblDegreesToday.text = String(describing: currently.object(forKey: "temperature") as! NSNumber)
        imgToday.image = UIImage(named: (day as! NSMutableDictionary).object(forKey: "icon") as! String)
        day = sprint[1] as! NSMutableDictionary
        time1970 = (day as! NSMutableDictionary).object(forKey: "time") as! NSNumber
        exactDate = NSDate(timeIntervalSince1970: TimeInterval(truncating: time1970))
        lblTomorrow.text = exactDate.dayOfTheWeek()
        lblDegreesTomorrow.text = String(describing: currently.object(forKey: "temperature") as! NSNumber)
        imgTomorrow.image = UIImage(named: (day as! NSMutableDictionary).object(forKey: "icon") as! String)
        day = sprint[2] as! NSMutableDictionary
        time1970 = (day as! NSMutableDictionary).object(forKey: "time") as! NSNumber
        exactDate = NSDate(timeIntervalSince1970: TimeInterval(truncating: time1970))
        lblAfterTomorrow.text = exactDate.dayOfTheWeek()
        lblDegreesAfterTomorrow.text = String(describing: currently.object(forKey: "temperature") as! NSNumber)
        imgAfterTomorrow.image = UIImage(named: (day as! NSMutableDictionary).object(forKey: "icon") as! String)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NSDate {
    func dayOfTheWeek() -> String? {
        let weekdays = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Satudrday,"
        ]
        
        let calendar: NSCalendar = NSCalendar.current as NSCalendar
        let components: NSDateComponents = calendar.components(.weekday, from: self as Date) as NSDateComponents
        return weekdays[components.weekday - 1]
    }
}
