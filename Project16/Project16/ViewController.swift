//
//  ViewController.swift
//  Project16
//
//  Created by Andrew McDonnell on 18/3/2022.
//

import UIKit
import MapKit
import WebKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(toggleSatellite)),
        ]

        // Do any additional setup after loading the view.
        let adelaide = Capital(title: "Adelaide", coordinate: CLLocationCoordinate2D(latitude: -34.91552, longitude: 138.59611), info: "Best city in the world", url: "https://en.wikipedia.org/wiki/Adelaide")
        let mallala = Capital(title: "Mallala", coordinate: CLLocationCoordinate2D(latitude: -34.43851, longitude: 138.510345), info: "Race cars", url: "https://en.wikipedia.org/wiki/Glenelg,_South_Australia")
        let glenelg = Capital(title: "Glenelg", coordinate: CLLocationCoordinate2D(latitude: -34.980537, longitude: 138.51095), info: "Beaches", url: "https://en.wikipedia.org/wiki/Mallala,_South_Australia")

        mapView.addAnnotation(adelaide)
        mapView.addAnnotation(mallala)
        mapView.addAnnotation(glenelg)
    }
    func showSatellite(action: UIAlertAction!) {
        mapView.mapType = .satellite
    }
    func showRoadmap(action: UIAlertAction!) {
        mapView.mapType = .standard
    }

    @objc func toggleSatellite() {
        let ac = UIAlertController(title: "Show?", message: "Choose Style", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: showSatellite))
        ac.addAction(UIAlertAction(title: "Roadmap", style: .default, handler: showRoadmap))
        present(ac, animated: true)
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
        let pinthing = annotationView as! MKPinAnnotationView
        pinthing.pinTintColor = UIColor.magenta


        return annotationView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let vc = DetailViewController()
        vc.detailItem = capital
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

