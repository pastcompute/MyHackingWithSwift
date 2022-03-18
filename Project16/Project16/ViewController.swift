//
//  ViewController.swift
//  Project16
//
//  Created by Andrew McDonnell on 18/3/2022.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let adelaide = Capital(title: "Adelaide", coordinate: CLLocationCoordinate2D(latitude: -34.91552, longitude: 138.59611), info: "Best city in the world")
        let mallala = Capital(title: "Mallala", coordinate: CLLocationCoordinate2D(latitude: -34.43851, longitude: 138.510345), info: "Race cars")
        let glenelg = Capital(title: "Glenelg", coordinate: CLLocationCoordinate2D(latitude: -34.980537, longitude: 138.51095), info: "Beaches")

        mapView.addAnnotation(adelaide)
        mapView.addAnnotation(mallala)
        mapView.addAnnotation(glenelg)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // check if it is one of ours
        guard annotation is Capital else { return nil }

        // 2 - our ref
        let identifier = "Capital"

        // 3 - a view for showing it
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            //4 - make a new one dynamically if it doesnt exist yet
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true

            // 5 abd a button for doing stuff
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            // 6 - found the current one, change it
            annotationView?.annotation = annotation
        }

        return annotationView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let placeInfo = capital.info

        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
}

