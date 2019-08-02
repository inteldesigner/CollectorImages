//
//  FirstViewController.swift
//  Collector
//
//  Created by Eric Stein on 7/25/19.
//  Copyright © 2019 Eric Stein. All rights reserved.
//

import UIKit

class FirstViewController: UITableViewController {

    
    var collectables : [Collectable] = []
    
    override func viewWillAppear(_ animated: Bool) {
        getCollectables()
    }
    
    func getCollectables() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let collectables = try?
                context.fetch(Collectable.fetchRequest()) {
            if let theCollectables = collectables as? [Collectable] {
                self.collectables = theCollectables
                tableView.reloadData()
            }
        }
    }
 
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectables.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let collectable = collectables[indexPath.row]
        
        cell.textLabel?.text = collectable.title
        if let data = collectable.image {
         cell.imageView?.image = UIImage(data: data)
        }

        return cell
    }
// (gray whos showing up by clicking)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
//     code for delete button when swiping it
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let collectable = collectables[indexPath.row]
                context.delete(collectable)
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                getCollectables()
                
            }
                    }
    }

}
