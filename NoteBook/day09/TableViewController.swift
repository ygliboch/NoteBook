//
//  TableViewController.swift
//  day09
//
//  Created by Yaroslava HLIBOCHKO on 7/6/19.
//  Copyright © 2019 Yaroslava HLIBOCHKO. All rights reserved.
//

import UIKit
import LocalAuthentication
import yhliboch2019
import CoreData

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    var articles: [Entity] = []
    let articleManeger = ArticleManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .clear
        articles = articleManeger.getAllArticles()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(articles.count)
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell") as! NewTableViewCell
        cell.tintColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.article = articles[indexPath.row]
        return cell
    }
    
    @IBAction func unWindSegue(segue: UIStoryboardSegue){
        articles = articleManeger.getAllArticles()
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let evc = segue.destination as? SecondViewController {
            if (segue.identifier == "addSegue" && sender != nil) {
                evc.article = sender as? Entity
                evc.articleManager = self.articleManeger
            }
            if (segue.identifier == "addSegue") {
                evc.articleManager = self.articleManeger
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "addSegue", sender: articles[indexPath.row])
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            articleManeger.removeArticle(article: articles[indexPath.row])
            articleManeger.save()
            articles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
}
