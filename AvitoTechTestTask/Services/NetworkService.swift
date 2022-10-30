//
//  NetworkService.swift
//  AvitoTechTestTask
//
//  Created by Денис Медведев on 26.10.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func getEmployeesData(complition: @escaping (Result<Employees, NetworkError>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    private enum Consts {
        static let employeesUrlString = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
        enum UserDefaltsKeys {
            static let data = "employeesData"
            static let timeTracker = "timeTracker"
        }
    }
    
    func getEmployeesData(complition: @escaping (Result<Employees, NetworkError>) -> Void) {
        
        //пытаемся дернуть данные c UserDefaults, если время кеширования не истекло
        if let data = UserDefaults.standard.object(forKey: Consts.UserDefaltsKeys.data) as? Data, let timeTracker = UserDefaults.standard.object(forKey: Consts.UserDefaltsKeys.timeTracker) as? Date {
            let currentDate = Date()
            if timeTracker > currentDate {
                do {
                    let obj = try JSONDecoder().decode(Employees.self, from: data)
                    complition(.success(obj))
                    return
                } catch {
                    complition(.failure(.parsingError))
                    return
                }
            }
        }
        
        if !NetworkMonitor.shared.isConnected {
            complition(.failure(.noConnection))
        }
        
        guard let employeesUrlString = URL(string: Consts.employeesUrlString) else {
            print("Проверьте валидность URL адреса")
            complition(.failure(.badUrl))
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: employeesUrlString) { (data, _, error) in
            
            if let data = data, error == nil {
                do {
                    let obj = try JSONDecoder().decode(Employees.self, from: data)
                    let hour: TimeInterval = 3600
                    let hourCacheDate = Date().addingTimeInterval(hour)
                    UserDefaults.standard.set(hourCacheDate, forKey: Consts.UserDefaltsKeys.timeTracker)
                    UserDefaults.standard.set(data, forKey: Consts.UserDefaltsKeys.data)
                    complition(.success(obj))
                    return
                } catch {
                    complition(.failure(.parsingError))
                    return
                }
            } else {
                complition(.failure(.serverError))
                return
            }
        }.resume()
    }
    
}
