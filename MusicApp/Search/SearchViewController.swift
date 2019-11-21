//
//  SearchViewController.swift
//  MusicApp
//
//  Created by Vadim  Gorbachev on 20.11.2019.
//  Copyright © 2019 Vadim  Gorbachev. All rights reserved.
//

import UIKit

protocol SearchDisplayLogic: class {
    func displayData(viewModel: Search.Model.ViewModel.ViewModelData)
}

class SearchViewController: UIViewController, SearchDisplayLogic {
    
    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic)?
    
    @IBOutlet weak var table: UITableView!
    private var timer: Timer?
    private let cellId = "cellId"
    private lazy var footerView = FooterView()
   
   
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: инициализируем экземпляр структуры SearchViewModel для отображения данных
     private var searchViewModel = SearchViewModel.init(cells: [])
    
    // MARK: setup
    
    private func setup() {
        let viewController = self
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    // MARK: Routing
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupTableView()
        setupSearchBar()
        
    }
    
    // MARK: sutupTableView, setupSearchBar  ( настройка search bar'a и navigation bar'a )
    
    private func setupTableView() {
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        let nib = UINib(nibName: "TrackCell", bundle: nil)
        table.register( nib, forCellReuseIdentifier: TrackCell.reuseId)
        table.tableFooterView = footerView
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        
    }
    
    func displayData(viewModel: Search.Model.ViewModel.ViewModelData) {
        
        switch viewModel {
        case .displayTracks(let searchViewModel):
            print("viewController .displayTracks")
            self.searchViewModel = searchViewModel
            table.reloadData()
            footerView.hideLoader()
        case .displayFooterView:
            footerView.showLoader()
        }
            
    }
    
}

// MARK: UITableViewDelegate, UITableViewDataSource extension

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: TrackCell.reuseId, for: indexPath) as! TrackCell
        
        let cellViewModel = searchViewModel.cells[indexPath.row]
//        print("cellViewModel.previewUrl: ", cellViewModel.previewUrl!)
        cell.trackImageView.backgroundColor = .red
        cell.set(viewModel: cellViewModel)
        
        return cell

    }
    // высота ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    // параметры текста на таблице
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Please enter search term above..."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }
    // настройка высоты текста на таблице
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return searchViewModel.cells.count > 0 ? 0 : 250
    }
    // реализация нажатия на ячейку таблицы
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewModel = searchViewModel.cells[indexPath.row]
        let window = UIApplication.shared.keyWindow
        let trackDetailView = Bundle.main.loadNibNamed("TrackDetailView", owner: self, options: nil)?.first as! TrackDetailView
        window?.addSubview(trackDetailView)
    }
}




// MARK: UISearchBarDelegate extension ( Пересылка данных интерактору из search bar с таймером )

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.interactor?.makeRequest( request: Search.Model.Request.RequestType.getTracks(searchTerm: searchText))
       })
        
    }
}

