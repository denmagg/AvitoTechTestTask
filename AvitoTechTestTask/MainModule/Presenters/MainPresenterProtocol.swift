//
//  MainPresenterProtocol.swift
//  AvitoTechTestTask
//
//  Created by Денис Медведев on 27.10.2022.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    func getNumberOfRows() -> Int?
    func getEmployee(for indexPath: IndexPath) -> Employee?
    func getEmployeesData()
}
