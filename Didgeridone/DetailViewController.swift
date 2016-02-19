//
//  DetailViewController.swift
//  Didgeridone
//
//  Created by Josue Ruchwarger on 2/18/16.
//  Copyright © 2016 Galvanize. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var todoItem:ToDoItem?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
        
        if let todo = todoItem {
            self.nameLabel.text = todo.text
//            print("TESTING")
//            print(todo.latitude)
//            print(todo.longitude)
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // Mark - Location Delegate Methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        //var todoItem:ToDoItem?
        if let todo = todoItem {
            self.nameLabel.text = todo.text
            print("TESTING")
            let titleText = todo.text!
            let myLatitude = Double(todo.latitude!)!
            let myLongitude = Double(todo.longitude!)!
//            print(myLatitude)
//            print(myLongitude)
            
//        let location = locations.last
        
//        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)

        let center = CLLocationCoordinate2D(latitude: myLatitude, longitude: myLongitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
        
        self.mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
            
        var pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLatitude, myLongitude)
        var objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        objectAnnotation.title = titleText
        self.mapView.addAnnotation(objectAnnotation)
        
        self.locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errors: " + error.localizedDescription)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
