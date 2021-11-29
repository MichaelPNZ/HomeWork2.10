//
//  USADateViewController.swift
//  HomeWork2.10
//
//  Created by Михаил Позялов on 26.11.2021.
//

import UIKit

class USADateViewController: UITableViewController {
    
    private var usaDate: [DataUSA] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        usaDate.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! USADataCell
        let usa = usaDate[indexPath.row]
        
        cell.configure(with: usa)
        
        return cell
    }
    
}
//MARK: Networking
        extension USADateViewController {
            func infoUSA() {
                guard let url = URL(string: Link.usa.rawValue) else { return }
                
                URLSession.shared.dataTask(with: url) { data, _, error in
                    guard let data = data else {
                        print(error?.localizedDescription ?? "No error description")
                        return
                    }
                    do {
                        self.usaDate = try JSONDecoder().decode([DataUSA].self, from: data)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }.resume()
            }
}
