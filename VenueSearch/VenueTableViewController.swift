//
//  VenueTableViewController.swift
//  MyApp
//
//  Created by Barkin Ozbek on 3/16/16.
//  Copyright © 2016 Barkin Ozbek. All rights reserved.
//

import UIKit
import CoreLocation
import ObjectMapper

class VenueTableViewController: UITableViewController,CLLocationManagerDelegate {
    var count: Int = 0
    var longitude: Double? = 29.066357
    var latitude: Double? = 40.977156
    //42.3447814,-71.0970766
    //29.066357,40.977156
    var locationManager = CLLocationManager()
    
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    var dataTask: NSURLSessionDataTask?
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count != 0 {
            print(locations.first?.coordinate)
            longitude = locations.first?.coordinate.longitude
            latitude = locations.first?.coordinate.latitude
            ExploreVenue()
            
        }
    }
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error.localizedDescription)
    }
    @IBAction func goBackToMain(segue:UIStoryboardSegue) {
        
    }

    func ExploreVenue(){
        if dataTask != nil {
            dataTask?.cancel()
        }
        //make it to get from user /////
        let limit: Int
        limit = 20
        print(latitude)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let url = NSURL(string: "https://api.foursquare.com/v2/venues/search?v=20131016&ll=\(latitude!)%2C\(longitude!)&radius=100&limit=\(limit)&intent=browse&client_id=SC5MIONNLNSBW1O0VQBI5JCBUD0WGS2WDACHOBBT35DKBGHS&client_secret=Y2OBXGK2UDICS2ZQ4V0NYGUAKY4M3CVX0C503OJNRX1D2WKP")
        dataTask = defaultSession.dataTaskWithURL(url!) {
            data, response, error in
            // 6
            dispatch_async(dispatch_get_main_queue()) {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    
                  self.reloadVenues(data,limit: limit)
                }
            }
            
        }
        dataTask?.resume()
    }
    var result: VenueContainer<Venue>?
    func reloadVenues(data: NSData?,limit: Int?){
        do{
            if let data = data, response = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue:0)) as? [String:AnyObject]{
                result = Mapper<VenueContainer<Venue>>().map(response)
                tableView.reloadData()
                
            }else {
                print("JSON Error")
            }
        }catch let error as NSError {
            print("Error parsing results: \(error.localizedDescription)")
            
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if result == nil{
            return 0
        }else{
        return (result?.venues!.count)!
        }
    }
    override func tableView(tableView: UITableView,  cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let venue: Venue
        venue = (result?.venues![indexPath.row])!
        cell.textLabel!.text = venue.placeName
        // #warning Incomplete implementation, return the number of rows
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "displayOnMap"{
            if let indexPath = tableView.indexPathForSelectedRow {
                let selecetedVenue : Venue
                selecetedVenue = (result?.venues![indexPath.row])!
                let destination = (segue.destinationViewController as? UINavigationController)?.topViewController as? MapViewController
                destination!.venue = selecetedVenue
            }
            
        }
    }


}
