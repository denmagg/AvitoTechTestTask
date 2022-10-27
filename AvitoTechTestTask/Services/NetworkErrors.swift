//
//  NetworkErrors.swift
//  AvitoTechTestTask
//
//  Created by Денис Медведев on 26.10.2022.
//

import Foundation

enum NetworkError: String, Error {
    case parsingError
    case noConnection
    case badUrl
    case serverError
}
