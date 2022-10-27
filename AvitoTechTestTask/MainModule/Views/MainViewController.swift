//
//  MainViewController.swift
//  AvitoTechTestTask
//
//  Created by Денис Медведев on 26.10.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol?
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        //        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setupSubviews()
        configureTableView()
        setupConstraints()
        presenter?.getEmployeesData()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Avito"
    }
    
    private func setupSubviews() {
        self.view.addSubview(tableView)
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseId)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}


extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseId, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        guard let data = presenter?.getEmployee(for: indexPath) else { return UITableViewCell() }
        cell.configure(with: data)
        return cell
    }
    
}


extension MainViewController: MainViewProtocol {
    func updateTableView() {
        tableView.reloadData()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.presenter?.getEmployeesData()
        }
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
    }
    
}
