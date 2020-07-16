//
//  IQ-DynamicProgramming.swift
//  AlgorithmsWorskhop
//
//  Created by Hem Poudyal on 7/14/20.
//  Copyright © 2020 Hem Poudyal. All rights reserved.
//

import Foundation
import UIKit

class IQ_DynamicProgramming: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Array"
        
        objectList = [Objects(key: "Sorting and Searching",
                              objects: ["First Bad Version"]),
            
                      Objects(key: "Dynamic - Easy Category",
                              objects: ["Climbing Stairs",
                                        "Best Time to Buy and Sell Stock",
                                        "Maximum Subarray",
                                        "House Rubber"])
        ]
        
        
        tableView.dataSource = super.self
        tableView.delegate = super.self
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(tableView)
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section{
        case 0:
            //Array
            switch indexPath.row {
            case 0:
                let l = firstBadVersion(2)
                print(l)
                break
                
            default:
                break
            }
        
        case 1:
            switch indexPath.row {
            case 0:
                let c = climbStairs(5)
                print(c)
                let x = climbStairs2(5)
                print(x)
            default:
                break
            }
            
        default:
            break
        }
    }
}

//Sorting and Searching
extension IQ_DynamicProgramming {
    
    func firstBadVersion(_ n: Int) -> Int {
       var left = 1
        var right = n
        while (left < right){
            let mid = left +  (right - left)/2
            if isBadVersion(mid){
                right = mid
            } else {
                left = mid + 1
            }
        }
        
        return left
    }
    
    func isBadVersion(_ n: Int) -> Bool {
        if n == 1{
            return true
        }
        return false
    }
}

extension IQ_DynamicProgramming {
    //1. Climbing Stairs
    
    //Recursion and Memoization
    func climbStairs(_ n: Int) -> Int {
        var memo = [Int: Int]()
        return climbStairsHelper(n, &memo)
    }
    
    func climbStairsHelper(_ n: Int,_ memo: inout [Int: Int]) -> Int {
        if n <= 1 { return 1 }
        print(memo[n])
        if memo[n] != nil { return memo[n]! }
        memo[n] = climbStairsHelper(n - 1, &memo) + climbStairsHelper(n - 2, &memo)
        return memo[n]!
    }
    
    //Dynamic Programming OR Fibonacci number using dict
    //Dynamic programming - breaking problem into subproblems, it contains the optimal substructure property
    
    func climbStairs2(_ n : Int) -> Int {
        if n == 0 { return 0 }
        if n == 1 { return 1 }
        if n == 2 { return 2 }
        
        var d = [1: 1, 2: 2]
        
        for i in 3..<n+1 {
            let curr = d[i - 1]! + d[i - 2]!
            d[i] = curr
        }
        
        return d[n]!
    }
}
