//
//  DetailViewModel.swift
//  Project7-Final
//
//  Created by Michelle Malixi on 3/17/23.
//

import Foundation

class DetailViewModel {
    private var detailItem: Petition?
    
    init(detailItem: Petition?) {
        self.detailItem = detailItem
    }
    
    func getBody() -> String {
        detailItem?.body ?? ""
    }
}
