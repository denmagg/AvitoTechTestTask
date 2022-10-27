//
//  Employees.swift
//  AvitoTechTestTask
//
//  Created by Денис Медведев on 26.10.2022.
//

import Foundation

struct Employees: Codable, Equatable {
    let company: Company
}

struct Company: Codable, Equatable {
    let name: String
    let employees: [Employee]
}

struct Employee: Codable, Equatable {
    let name, phoneNumber: String
    let skills: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone_number"
        case skills
    }
}
