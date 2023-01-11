//
//  MainPresenter.swift
//  AvitoTechTestTask
//
//  Created by Денис Медведев on 26.10.2022.
//

import Foundation

final class MainPresenter {
    
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
        getEmployeesData()
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
            DispatchQueue.main.async {
                switch result {
                case .success(let employees):
                    self?.employeesModel = employees
                    self?.view?.updateTableView()
                case .failure(let error):
                    self?.view?.showAlert(title: error.rawValue, message: error.localizedDescription)
                }
            }
        }
    }
    
}
