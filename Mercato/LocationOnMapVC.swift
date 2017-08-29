//
//  LocationOnMapVC.swift
//  Mercato
//
//  Created by Macbook Pro on 8/16/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit
import MapKit
class LocationOnMapVC: UIViewController , MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    
    let coords = [  CLLocation(latitude: 30.7921024, longitude: 31.0024722),
                    CLLocation(latitude: 30.7936133, longitude: 30.9961207) ];
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Our Location"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after loading the view.
        mapView.delegate = self
        
        addAnnotations(coords: coords)
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        
    }
    
    @IBAction func zoomToLocation(_ sender: UIButton) {
        
        if sender.tag == 0 {
            let span = MKCoordinateSpanMake(0.001, 0.001)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.7921024, longitude: 31.0024722), span: span)
            mapView.setRegion(region, animated: true)
        }else {
            let span = MKCoordinateSpanMake(0.001, 0.001)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.7936133, longitude: 30.9961207), span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    func addAnnotations(coords: [CLLocation]){
        for coord in coords{
            let CLLCoordType = CLLocationCoordinate2D(latitude: coord.coordinate.latitude,
                                                      longitude: coord.coordinate.longitude);
            let anno = MKPointAnnotation();
            anno.coordinate = CLLCoordType;
            mapView.addAnnotation(anno);
        }
        
    }
    
    //    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //        if annotation is MKUserLocation{
    //            return nil;
    //        }else{
    //            let pinIdent = "Pin";
    //            var pinView: MKPinAnnotationView;
    //            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: pinIdent) as? MKPinAnnotationView {
    //                dequeuedView.annotation = annotation;
    //                pinView = dequeuedView;
    //            }else{
    //                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinIdent);
    //
    //            }
    //
    //            return pinView;
    //        }
    //    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let annotationIdentifier = "Identifier"
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            
            annotationView.canShowCallout = true
            annotationView.image =  #imageLiteral(resourceName: "push-pin")
        }
        return annotationView
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
