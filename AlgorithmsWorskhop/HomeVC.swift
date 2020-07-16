//
//  ViewController.swift
//  AlgorithmsWorskhop
//
//  Created by Hem Poudyal on 6/5/20.
//  Copyright © 2020 Hem Poudyal. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    let tableView = UITableView()
    let contentList = ["Array", "Interview Questions-Array", "IQ- Strings", "IQ- Linked List", "IQ- Trees", "IQ- Dynamic Programming", "IQ- Design", "IQ- Math", "IQ- Others","11 Questions - Udemy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = contentList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            // vc.selectedClass = className.ArraySolution
            let vc = ArrayVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = IQ_ArrayVC()
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 2:
            let vc = IQ_StringVC()
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 3:
            let vc = IQ_LinkedList()
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 4:
            let vc = IQ_Trees()
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 5:
            let vc = IQ_DynamicProgramming()
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 10:
            let vc = UdemyVC()
            self.navigationController?.pushViewController(vc, animated: true)
            
        default:
            break
        }
        
        
    }
    
    
}
