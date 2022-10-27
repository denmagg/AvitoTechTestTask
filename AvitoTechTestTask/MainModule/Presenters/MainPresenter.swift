//
//  MainPresenter.swift
//  AvitoTechTestTask
//
//  Created by Денис Медведев on 26.10.2022.
//

import Foundation

final class MainPresenter {
    
    //MARK: Consts
    
    private enum Consts {
        enum NoConnectionError {
            static let title = "No internet connection"
            static let description = "Please make sure your device is connected to the internet and try again"
        }
        enum ServerError {
            static let title = "Unable to connect to the server"
            static let description = "Please try again later or contact contact our Support team"
        }
        enum ParsingBadUrlError {
            static let title = "Internal application error"
            static let description = "Please make sure you have the latest version of the app installed. If everything is correct, please contact our Support team."
        }
    }
    
    //MARK: Private properties
    
    private weak var view: MainViewProtocol?
    private var router: RouterProtocol?
    private var networkService: NetworkServiceProtocol?
    private var employeesModel: Employees?
    
    //MARK: Init
    
    required init(view: MainViewProtocol, router: RouterProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
    }
    
}

extension MainPresenter: MainPresenterProtocol {
    
    func getNumberOfRows() -> Int? {
        guard let model = employeesModel else { return nil }
        return model.company.employees.count
    }
    
    func getEmployee(for indexPath: IndexPath) -> Employee? {
        guard let model = employeesModel else { return nil }
        return model.company.employees.sorted { $0.name < $1.name }[indexPath.row]
    }
    
    func getEmployeesData() {
        networkService?.getEmployeesData { [weak self] result in
            switch result {
            case .success(let employees):
                self?.employeesModel = employees
                self?.view?.updateTableView()
            case .failure(let error):
                switch error {
                case .noConnection:
                    self?.view?.showAlert(title: Consts.NoConnectionError.title, message: Consts.NoConnectionError.description)
                case .serverError:
                    self?.view?.showAlert(title: Consts.ServerError.title, message: Consts.ServerError.description)
                case .parsingError, .badUrl:
                    self?.view?.showAlert(title: Consts.ParsingBadUrlError.title, message: Consts.ParsingBadUrlError.description)
                }
            }
        }
    }
    
}
