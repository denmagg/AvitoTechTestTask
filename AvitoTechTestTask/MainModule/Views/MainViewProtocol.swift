//
//  MainViewProtocol.swift
//  AvitoTechTestTask
//
//  Created by Денис Медведев on 27.10.2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func updateTableView()
    func showAlert(title: String, message: String)
}
