//
//  MapViewController.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/11/25.
//

import UIKit
import MapKit
import SnapKit

class MapViewController: UIViewController {
     
    private let mapView = MKMapView()
    private let viewModel = MapViewModel()

     
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMapView()
        addMunraeStationAnnotation()
        bind()
    }
     
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "지도"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "메뉴",
            style: .plain,
            target: self,
            action: #selector(rightBarButtonTapped)
        )
         
        view.addSubview(mapView)
         
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupMapView() {
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none
         
//        let seoulStationCoordinate = CLLocationCoordinate2D(latitude: 37.5547, longitude: 126.9706)
        let munraeStationCoordinate = CLLocationCoordinate2D(latitude: 37.5170, longitude: 126.8978)
        let region = MKCoordinateRegion(
            center: munraeStationCoordinate,
            latitudinalMeters: 2000,
            longitudinalMeters: 2000
        )
        mapView.setRegion(region, animated: true)
    }
    
    private func addSeoulStationAnnotation() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.5547, longitude: 126.9706)
        annotation.title = "서울역"
        annotation.subtitle = "대한민국 서울특별시"
        mapView.addAnnotation(annotation)
    }
    
    private func addMunraeStationAnnotation() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.5188, longitude: 126.8998)
        annotation.title = "문래역"
        annotation.subtitle = "대한민국 서울특별시"
        mapView.addAnnotation(annotation)
    }
     
    @objc private func rightBarButtonTapped() {
        let alertController = UIAlertController(
            title: "메뉴 선택",
            message: "원하는 옵션을 선택하세요",
            preferredStyle: .actionSheet
        )
        
        let categories = viewModel.categories
        categories.forEach { category in
            let action = UIAlertAction(title: category, style: .default) { [weak self] _ in
                self?.viewModel.filter(category: category)
            }
            alertController.addAction(action)
        }
        
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
 
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        
//        print("어노테이션이 선택되었습니다.")
//        print("제목: \(annotation.title ?? "제목 없음")")
//        print("부제목: \(annotation.subtitle ?? "부제목 없음")")
//        print("좌표: \(annotation.coordinate.latitude), \(annotation.coordinate.longitude)")
        
        // 선택된 어노테이션으로 지도 중심 이동
        let region = MKCoordinateRegion(
            center: annotation.coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("어노테이션 선택이 해제되었습니다.")
    }
    
    func bind() {
        viewModel.annotations.bind { [weak self] annotations in
            guard let self = self else {
                return }
            
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.mapView.addAnnotations(annotations)
        }
    }
}
