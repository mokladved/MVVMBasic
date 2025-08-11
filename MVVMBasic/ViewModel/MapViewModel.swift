//
//  MapViewModel.swift
//  MVVMBasic
//
//  Created by Youngjun Kim on 8/12/25.
//

import MapKit
import UIKit

class MapViewModel {

    var annotations: Observable<[MKAnnotation]> = Observable([])
    var categories: [String] = []
    
    private let restaurants = RestaurantList.restaurantArray
    
    init() {
        let uniqueCategories = Set(restaurants.map { $0.category })
        var categoriesArray = Array(uniqueCategories)
        categoriesArray.append("전체보기")
        self.categories = categoriesArray
        
        filter(category: "전체보기")
    }
    
    func filter(category: String) {
        let filteredRestaurants: [Restaurant]
        if category == "전체보기" {
            filteredRestaurants = restaurants
        } else {
            filteredRestaurants = restaurants.filter { $0.category == category }
        }
        
        let newAnnotations = filteredRestaurants.map { restaurant in
            return RestaurantAnnotation(restaurant: restaurant)
        }
        
        annotations.value = newAnnotations
    }
}

