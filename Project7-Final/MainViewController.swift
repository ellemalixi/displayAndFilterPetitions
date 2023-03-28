//
//  ViewController.swift
//  Project7-Final
//
//  Created by Michelle Malixi on 3/15/23.
//

import UIKit

class MainViewController: UITableViewController {
    private var viewModel: MainViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MainViewModel(tag: navigationController?.tabBarItem.tag ?? 0)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterData))
        
        viewModel.getJSONData { isFinishedGettingData in
            if isFinishedGettingData {
                self.tableView.reloadData()
            } else {
                self.performSelector(onMainThread: #selector(self.showError), with: nil, waitUntilDone: false)
            }
        }
    }
    
    @objc func filterData() {
        let alert = UIAlertController(title: "Filter Petitions:", message: nil, preferredStyle: .alert)
        alert.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak alert] action in
            guard let answer = alert?.textFields?[0].text else { return }
            self?.viewModel.filterPetitions(with: answer)
        }
        alert.addAction(submitAction)
        present(alert, animated: true)
    }
    
    @objc func showCredits() {
        let alert = UIAlertController(title: "Credits", message: "The JSON data comes from We The People API of the Whitehouse", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed. Please check yoour connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.petitions?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let petition = viewModel.getPetition(using: indexPath.row) {
            cell.textLabel?.text = petition.title
            cell.detailTextLabel?.text = "\(petition.body ?? "")"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let detailItem = viewModel.getPetition(using: indexPath.row) {
            let vc = DetailViewController()
            vc.viewModel = DetailViewModel(detailItem: detailItem)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
