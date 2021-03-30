//
//  ViewController.swift
//  SearchApp
//
//  Created by ㅇ오ㅇ on 2021/03/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noneSearchStackView: UIStackView!
    @IBOutlet weak var searchText: UILabel!
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchApp: App? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.isHidden = false
            }
        }
    }
    
    private var error: Error? {
        didSet { guard error == nil else { return print("검색어가 옳바르지 않습니다.")} }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        setCollectionView()
        setNoneSearch()
    }
    
    private func setNavigation() {
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
        searchController.searchBar.delegate = self
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isHidden = true
        collectionView.register(UINib(nibName: "AppCell", bundle: nil), forCellWithReuseIdentifier: "AppCell")
    }
    
    private func setNoneSearch() {
        noneSearchStackView.isHidden = true
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = searchApp?.results else { return 0 }
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppCell", for: indexPath) as! AppCell
        guard let data = searchApp?.results else { return cell }
        cell.data = data[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let estimatedSizeCell = AppCell(frame: frame)
        guard let data = searchApp?.results else { return CGSize(width: view.bounds.width, height: view.bounds.height/2) }
        estimatedSizeCell.data = data[indexPath.row]
        estimatedSizeCell.layoutIfNeeded()

        let targetSize = CGSize(width: view.frame.width, height: view.bounds.height/2)
        let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(targetSize)

        return .init(width: estimatedSize.width, height: estimatedSize.height)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text else { return }
        
        Service.searchApp(searchText: searchText) { data, error in
            guard let data = data else { return }
            if data.results.count > 0 {
                self.searchApp = data
                self.error = error
            } else {
                DispatchQueue.main.async {
                    self.noneSearchStackView.isHidden = false
                    self.searchText.text = "'\(searchText)'"
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.collectionView.isHidden = true
        self.searchApp?.results.removeAll()
        self.noneSearchStackView.isHidden = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.isEmpty == false else {
            self.collectionView.isHidden = true
            self.searchApp?.results.removeAll()
            self.noneSearchStackView.isHidden = true
            return
        }
    }
    
}

