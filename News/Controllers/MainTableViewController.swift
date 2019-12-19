//
//  MainTableViewController.swift
//  Good News
//
//  Created by PRIYANS on 18/12/19.
//  Copyright © 2019 PRIYANS. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    private var articleListViewModel: ArticleListViewModel!
    var activityIndicator: UIActivityIndicatorView = {
        let actIndication = UIActivityIndicatorView(style: .large)
        return actIndication
    }()
    var networkError: NetworkError!
    

    var webServices: WebServices!
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.frame = view.frame
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        setup()

    }
    
    private func setup() {
        
        let resource = Resource<ArticleList>()
        
        WebServices().loadArticles(resourse: resource) { (result) in
            switch result {
                
            case .success(let articles):
                self.articleListViewModel = ArticleListViewModel(articles: articles.articles)
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.articleListViewModel == nil ? 0 : self.articleListViewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListViewModel == nil ? 0 : self.articleListViewModel.numberOfRowsInSection(section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("article cell not found.")
        }
        
        let articleVM = self.articleListViewModel.articleAtIndex(indexPath.row)
        
        cell.titleLabel.text = articleVM.title
        cell.descriptionLabel.text = articleVM.description
        
        return cell
    }

}
