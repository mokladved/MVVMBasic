//
//  RestaurantAnnotation.swift
//  MVVMBasic
//
//  Created by Youngjun Kim on 8/12/25.
//

import MapKit

class RestaurantAnnotation: NSObject, MKAnnotation {
    let restaurant: Restaurant
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
    }
    
    var title: String? {
        return restaurant.name
    }
    
    var subtitle: String? {
        return restaurant.category
    }
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        super.init()
    }
}
