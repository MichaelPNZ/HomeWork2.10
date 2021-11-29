//
//  DataUSA.swift
//  HomeWork2.10
//
//  Created by Михаил Позялов on 26.11.2021.
//
struct DataUSA: Decodable {
    let country_code: String
    let country_name: String
    let region_code: String
    let region_name: String
    
    var description: String {
        """
name: \(country_name)
"""
    }
}
