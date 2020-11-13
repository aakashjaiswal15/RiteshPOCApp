//
//  HomeViewController.swift
//  POCApp
//
//  Created by Ritesh on 07/11/20.
//  Copyright © 2020 Ritesh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let tableView = UITableView()
    
    var rowData = [Row]()
    var refreshControl = UIRefreshControl()

    @objc func refreshScreen(_ sender: AnyObject) {
        fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRefreshControl()
        configureTableView()
        setupConstraints()
        fetchData()
    }
    
    //Function for Pull To Referesh
    func addRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refreshScreen(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    //Configure table view properties
    func configureTableView() {
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "homeRow")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
    }
    
    //Set table view constraints
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    //Fetch data
    func fetchData() {
        self.fetchDataDetails { (homeData, error) in
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                guard let homeData = homeData else {
                    self.showAlert(withMessage: error?.localizedDescription ?? "Request failed")
                    return
                }
                self.displayHomeData(data: homeData)
            }
        }
    }
    
    //Display data
    func displayHomeData(data: Home) {
        title = data.title
        rowData = data.rows
        tableView.reloadData()
    }
    
    func showAlert(withMessage message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    func fetchImage(indexPath: IndexPath) {
        let imageURL = rowData[indexPath.row].imageURL ?? ""
        if let url = URL(string: imageURL) {
            self.fetchImageDetails(url: url) { [unowned self] (image, error) in
                DispatchQueue.main.async {
                    guard let image = image else {
                        return
                    }
                    self.rowData[indexPath.row].image = image
                    self.tableView.reloadRows(at: [indexPath], with: .none)
                }
            }
        }
    }
}

extension HomeViewController {
    func fetchDataDetails(_ callback: ((Home?, Error?) -> Void)?) {
        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts") else {
            callback?(nil, NetworkError.invalidRequest)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                callback?(nil, error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                 httpResponse.statusCode == 200,
                 let data = data,
                 let response = try? JSONDecoder().decode(Home.self, from: (String(data: data, encoding: .isoLatin1)?.data(using: .utf8))!) else {
                callback?(nil, NetworkError.invalidResponse)
                return
            }
            callback?(response, nil)
        }
        task.resume()
    }
    
    func fetchImageDetails(url: URL, _ callback: ((UIImage?, Error?) -> Void)?) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                callback?(nil, NetworkError.invalidResponse)
                return
            }
            let image = UIImage(data: data)
            callback?(image, nil)
        }
        task.resume()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeRow", for: indexPath) as? HomeTableViewCell else {
            return HomeTableViewCell()
        }
        setupCell(atIndexPath: indexPath, cell: cell)
        return cell
    }
    
    func setupCell(atIndexPath indexPath: IndexPath, cell: HomeTableViewCell) {
        let row = rowData[indexPath.row]
        cell.titleLabel.text = row.title
        cell.descriptionLabel.text = row.rowDescription
        cell.descriptionLabel.numberOfLines = 0
        cell.descriptionLabel.lineBreakMode = .byWordWrapping
        cell.wikiImageView.image = row.image
        if cell.wikiImageView.image == nil {
            fetchImage(indexPath: indexPath)
        }
    }
}

enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
}
