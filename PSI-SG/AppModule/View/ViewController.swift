//
//  ViewController.swift
//  PSI-SG
//
//  Created by Praful Mahajan on 30/11/19.
//  Copyright © 2019 prafulmahajan. All rights reserved.
//

import UIKit
import MapKit

//**************************************************
// MARK: - ViewController Class
//**************************************************
class ViewController: UIViewController {

    //**************************************************
    // MARK: - IBOutlets
    //**************************************************
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
        }
    }
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var statusView: DesignableView!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var updatedTime: UILabel!

    //**************************************************
    // MARK: - Properties
    //**************************************************
    private var viewModel: PSIViewModel?

    //**************************************************
    // MARK: - View life cycle Methods
    //**************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = PSIViewModel.init()
        observeEvents()
    }

    //**************************************************
    // MARK: - Required Methods
    //**************************************************
    /// Function to observe various event call backs from the viewmodel as well as Notifications.
    private func observeEvents() {
        viewModel?.updateUI = { [weak self] in
            DispatchQueue.main.async(execute: {
                self?.showPSIIndex()
                self?.setStatusAndTime()
            })
        }
    }

    private func showPSIIndex() {
        var lastCoordinate = CLLocationCoordinate2D()
        for region in self.viewModel?.psiIndex?.regionMetadata ?? []{

            let annotation = PSIAnnotation()

            let lat:Double = Double(region.labelLocation.latitude)
            let long:Double = Double(region.labelLocation.longitude)

            let centerCoordinate = CLLocationCoordinate2D(latitude: lat , longitude: long)
            lastCoordinate = centerCoordinate
            annotation.coordinate = centerCoordinate
            annotation.title = region.name.capitalized
            mapView.addAnnotation(annotation)
        }
        let center = lastCoordinate
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4))
        mapView.setRegion(region, animated: true)
    }

    func setStatusAndTime() {
        self.status.text = self.viewModel?.status
        if let isHealthy = self.viewModel?.isHealthy {
            self.statusView.isHidden = !(isHealthy)
            self.statusView.backgroundColor = isHealthy ? .green : .red
        }
        self.timeStamp.text = self.viewModel?.timeStamp
        self.updatedTime.text = self.viewModel?.updatedTime
    }
}

//**************************************************
// MARK: MKMapViewDelegate methods
//**************************************************
extension ViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        let identifier = "PSIAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        configuredView(annotation: annotation)
    }

    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        if mapView.annotations.count > 0 {
            let annotation = mapView.annotations[0]
            configuredView(annotation: annotation)
            mapView.selectAnnotation(annotation, animated: true)
        }
    }
}

//**************************************************
// MARK: Refresh UI by user action
//**************************************************
extension ViewController {
    func configuredView(annotation: MKAnnotation) {

        guard let annotationTitle = annotation.title else { return }

        switch annotationTitle?.lowercased() {
        case Region.NATIONAL.rawValue:
            viewModel?.region = .NATIONAL
            break
        case Region.CENTRAL.rawValue:
            viewModel?.region = .CENTRAL
            break
        case Region.NORTH.rawValue:
            viewModel?.region = .NORTH
            break
        case Region.SOUTH.rawValue:
            viewModel?.region = .SOUTH
            break
        case Region.EAST.rawValue:
            viewModel?.region = .EAST
            break
        case Region.WEST.rawValue:
            viewModel?.region = .WEST
            break
        default:
            break
        }
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

//**************************************************
// MARK: Delegate methods UITableViewDataSource, UITableViewDelegate
//**************************************************
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.numberOfRows ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PSICell.cellIdentifier(), for: indexPath) as! PSICell
        let data = viewModel?.getReadingData(index: indexPath.row)
        cell.prepareCell(data: data, region: viewModel?.region)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 420.0
    }
}

