//
//  BaseViewController.swift
//  AlgorithmsWorskhop
//
//  Created by Hem Poudyal on 6/13/20.
//  Copyright © 2020 Hem Poudyal. All rights reserved.
//

import Foundation
import UIKit

enum className {
    case ArraySolution
    case InterviewQuestionsArray
    case IQStrings
    case IQLinkedList
    case IQTrees
    case IQSortingSearching
    case IQDynamicProgramming
    case IQDesign
    case IQMath
    case IQOthers
}

class BaseViewController: UIViewController {
    
    var selectedClass : className?
    let tableView = UITableView()
    
    struct Objects {
        var key : String
        var objects : [String]
    }
    
    var objectList = [Objects]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
 
}

extension BaseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectList[section].objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = objectList[indexPath.section].objects[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objectList[section].key
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
