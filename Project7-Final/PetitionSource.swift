//
//  PetitionSource.swift
//  Project7-Final
//
//  Created by Michelle Malixi on 3/17/23.
//

import Foundation

enum PetitionSource: Int {
    case petition1 = 0
    case petition2 = 1
    
    func getUrlString() -> String {
        switch self {
            case .petition1: return "https://www.hackingwithswift.com/samples/petitions-1.json"
            case .petition2: return "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
    }
}
