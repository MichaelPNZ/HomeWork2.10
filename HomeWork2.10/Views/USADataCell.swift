//
//  USADataCell.swift
//  HomeWork2.10
//
//  Created by Михаил Позялов on 26.11.2021.
//

import UIKit

class USADataCell: UITableViewCell {

    @IBOutlet var nationLabel: UILabel!
    
    func configure(with data: DataUSA) {
        nationLabel.text = data.description
    }
}
