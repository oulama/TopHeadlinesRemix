//
//  TopHeadlinesView.swift
//  HeadLineRemix
//
//  Created by Hamza DOUMARI on 1/20/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import UIKit

protocol AdvertListViewDelegate: class {
    func viewIsReady()
    func didSelect(article: TopHeadlinesDetailViewData)
}

protocol TopHeadlinesViewProtocol: class {
    func setDelegate(delegate: AdvertListViewDelegate)
    func updateView(articles :TopHeadlinesViewData)
    func showErrorMessage(message: String)
}

protocol AdvertListViewFactory: class {
    static func makeView() -> TopHeadlinesViewProtocol
}

class TopHeadlinesView: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView?
    private weak var delegate: AdvertListViewDelegate?
    private let cellId = "cellId"
    private var articles: TopHeadlinesViewData = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setUpNavigation()
        delegate?.viewIsReady()
        
    }
    
    private func setUpCollectionView(){
        collectionView?.register(UINib(nibName: "TopHeadlinesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    
    private func setUpNavigation(){
        navigationItem.title = "Top Headlines"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - UICollectionViewDataSource
extension TopHeadlinesView: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TopHeadlinesCollectionViewCell
        cell.article = articles[indexPath.row]
        return cell
    }
}

//  MARK: - UICollectionViewDelegateFlowLayout
extension TopHeadlinesView: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height - 50
        let width =  collectionView.frame.width - 50
        return CGSize(width: width, height: height)
    }
}

//  MARK: - UICollectionViewDelegate
extension TopHeadlinesView: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(article: articles[indexPath.row])
    }
}

//  MARK: - TopHeadlinesViewProtocol
extension TopHeadlinesView: TopHeadlinesViewProtocol{
    func showErrorMessage(message: String) {
        let alertMessage = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertMessage.addAction(action)
        DispatchQueue.main.async {
            self.present(alertMessage, animated: true, completion: nil)
        }
    }
    
    func updateView(articles: TopHeadlinesViewData) {
        self.articles = articles
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    func setDelegate(delegate: AdvertListViewDelegate){
        self.delegate = delegate
    }
}

//  MARK: - AdvertListViewFactory
extension TopHeadlinesView: AdvertListViewFactory{
    static func makeView() -> TopHeadlinesViewProtocol {
        return TopHeadlinesView(nibName: "TopHeadlinesView", bundle: nil)
    }
}

