//
//  MainViewController.swift
//  HomeWork2.10
//
//  Created by Михаил Позялов on 26.11.2021.
//

import UIKit

enum Link: String {
    case usa = "https://freegeoip.app/json/"
}

enum UserAction: String, CaseIterable {
    case usaInfo = "Data USA"
}

class MainViewController: UICollectionViewController {
    
    let userActions = UserAction.allCases

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! UserActionCell
        
        cell.userActionLabel.text = userActions[indexPath.item].rawValue
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let useAction = userActions[indexPath.item]
        
        switch useAction {
        case .usaInfo:
            performSegue(withIdentifier: "showUSAData", sender: nil)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUSAData" {
            guard let usaDataVC = segue.destination as? USADateViewController else { return }
            
            usaDataVC.infoUSA()
        }
    }
}

//MARK: - Networking
extension MainViewController {
    private func dataUSA() {
        guard let url = URL(string: Link.usa.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let usa = try JSONDecoder().decode(DataUSA.self, from: data)
                print(usa)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}

