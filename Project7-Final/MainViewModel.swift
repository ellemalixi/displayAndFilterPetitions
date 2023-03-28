//
//  MainViewModel.swift
//  Project7-Final
//
//  Created by Michelle Malixi on 3/17/23.
//

import Foundation
import UIKit

class MainViewModel {
    private var tag: Int
    private(set) var petitions: [Petition]?
    private var filteredPetitions: [Petition]?
    let mainVC = MainViewController()
    
    init(tag: Int) {
        self.tag = tag
    }
    
    func getJSONData(completion: @escaping (Bool) -> Void) {
        guard let petitionSource = PetitionSource(rawValue: tag) else {
            completion(false)
            return
        }
        
        let urlString: String = petitionSource.getUrlString()
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self?.parse(json: data) { isDoneParsing in
                        completion(isDoneParsing)
                    }
                    return
                }
            }
            self?.mainVC.showError()
        }
        completion(false)
    }
    
    func parse(json: Data, completion: @escaping (Bool) -> Void) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            
            mainVC.tableView.reloadData()
            filteredPetitions = petitions
        } else {
            mainVC.performSelector(onMainThread: #selector(mainVC.showError), with: nil, waitUntilDone: false)
        }
    }
    
    func filterPetitions(with petition: String) {
        if petition.isEmpty == false {
            filteredPetitions = petitions?.filter { article in
                petitions?[0].title?.lowercased().contains(petition.lowercased()) ?? false
            }
        } else {
            filteredPetitions = self.petitions
        }
    }
    
    func getPetition(using idx: Int) -> Petition? {
        if !(filteredPetitions?.isEmpty ?? true) {
            return filteredPetitions?[idx]
        } else {
            return petitions?[idx]
        }
    }
}
