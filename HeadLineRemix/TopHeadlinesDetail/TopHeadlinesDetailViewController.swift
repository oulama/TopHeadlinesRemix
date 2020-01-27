//
//  TopHeadlinesDetailViewController.swift
//  HeadLineRemix
//
//  Created by Hamza DOUMARI on 1/22/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import UIKit

protocol TopHeadlinesDetailProtocol: AnyObject {
    func setDelegate(delegate: TopHeadlinesDetailDelegate)
    func updateView(article :TopHeadlinesDetailViewData)
}

protocol TopHeadlinesDetailDelegate: AnyObject {
    func viewIsReady()
}

protocol TopHeadlinesDetailFactory: AnyObject {
    static func makeView() ->TopHeadlinesDetailProtocol
}

class TopHeadlinesDetailViewController: UIViewController {
    @IBOutlet weak var thumbnailImage: UIImageView?
    @IBOutlet weak var articleDate: UILabel?
    @IBOutlet weak var articleLabel: UILabel?
    @IBOutlet weak var articleAuthor: UILabel?
    @IBOutlet weak var articleDescription: UILabel?
    
    private weak var delegate: TopHeadlinesDetailDelegate?
    
    private var article: TopHeadlinesDetailViewData?{
        didSet{
            DispatchQueue.main.async {
                self.thumbnailImage?.setImage(from: self.article?.url ?? "")
                self.articleDate?.text = self.article?.publishedAt ?? "Not specified"
                self.articleLabel?.text = self.article?.title ?? "Not specified"
                self.articleAuthor?.text = self.article?.author ?? "Not specified"
                self.articleDescription?.text = self.article?.description ?? "Not specified"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.viewIsReady()
    }
}

//  MARK: - TopHeadlinesDetailProtocol
extension TopHeadlinesDetailViewController :TopHeadlinesDetailProtocol{
    func setDelegate(delegate: TopHeadlinesDetailDelegate) {
        self.delegate = delegate
    }
    
    func updateView(article: TopHeadlinesDetailViewData) {
        self.article = article
    }
}

//  MARK: - TopHeadlinesDetailFactory
extension TopHeadlinesDetailViewController: TopHeadlinesDetailFactory{
    static func makeView() -> TopHeadlinesDetailProtocol {
        return TopHeadlinesDetailViewController(nibName: "TopHeadlinesDetailViewController", bundle: nil)
    }
}
