//
//  NetworkErrors.swift
//  AvitoTechTestTask
//
//  Created by Денис Медведев on 26.10.2022.
//

import Foundation

enum NetworkError: String, Error {
    case parsingOrBadUrlError = "Internal application error"
    case noConnection = "No internet connection"
    case serverError = "Unable to connect to the server"
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .parsingOrBadUrlError:
            return NSLocalizedString("Please make sure you have the latest version of the app installed. If everything is correct, please contact our Support team.", comment: "")
        case .noConnection:
            return NSLocalizedString("Please make sure your device is connected to the internet and try again", comment: "")
        case .serverError:
            return NSLocalizedString("Please try again later or contact contact our Support team", comment: "")
        }
    }
}
