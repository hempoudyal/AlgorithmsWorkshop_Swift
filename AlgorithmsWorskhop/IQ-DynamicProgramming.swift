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
                                        "House Robber"]),
                      
                      Objects(key: "Design",
                      objects: ["Shuffle an Array",
                                "Min Stack"])
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
                let s = sortArray([1,2,3,0,0,0], [2,5,6], 3, 3)
                print(s)
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
                
            case 1:
                let m = maxProfit([2,5,7,1,8])
                print(m)
                
            case 2:
                let m = maxSubArray([-2,1,-3,4,-1,2,1,-5,4])
                print(m)
                let r = maxSubArray_Rev([1,2])
                print(r)
                
            case 3:
                let r = rob([1,1,3,4])
                print(r)
                let x = rob_Rev([1,2,3,1,1,2,3,9])
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
    
    //2. Best Time to Buy and Sell Stock
    // Approach : One Pass, find max value and min value, get the diff
    
    func maxProfit(_ prices: [Int]) -> Int {
        var max = Int.min
        var min = Int.max
        var diff = 0
        var profit = 0
        
        for i in 0..<prices.count {
            if prices[i] < min {
                min = prices[i]
                max = prices[i]
            }
            
            if prices[i] > max {
                max = prices[i]
            }
            
            diff = max - min
            if diff > profit {
                profit = diff
            }
        }
        
        return profit
    }
    
    func better_maxProfit(_ prices: [Int]) -> Int {
        var min = Int.max
        var profit = 0
        
        for i in 0..<prices.count {
            if prices[i] < min {
                min = prices[i]
            } else if (prices[i] - min > profit) {
                profit = prices[i] - min
            }
        }
        return profit
    }
    
    func maxSubArray(_ nums: [Int]) -> Int {
        //Beats 78% of submission - O(n)
        var maxSub = Int.min
        var subSum = 0
        
        for n in nums {
            subSum += n
            
            if subSum < n {
                subSum = n
            }
            
            if subSum > maxSub {
                maxSub = subSum
            }
        }
        
        return maxSub
    }
    
    func rob(_ nums: [Int]) -> Int {
        //Beats 95%
        
        if nums.count == 0 { return 0 }
        if nums.count == 1 { return nums[0] }
        if nums.count == 2 { return max(nums[0], nums[1])}
        
        var dp = Array(repeating: 0, count: nums.count)
        dp[0] = nums[0]
        dp[1] = max(nums[0], nums[1])
        
        for i in 2..<nums.count {
            dp[i] = max(nums[i] + dp[i - 2], dp[i - 1])
        }
        
        return dp[nums.count - 1]
    }
    
}

//MARK:- Design

extension IQ_DynamicProgramming {
    
    class Solution{
        var array = [Int]()
        var original = [Int]()
        
        init(_ nums: [Int]) {
            array = nums
            original = nums
        }
    
        func reset() -> [Int] {
            array = original
            return original
        }
    
        func shuffle() -> [Int] {
            for i in 1..<array.count {
                let temp = array[i] //swap with random element
                let randomIndex = (0..<i).randomElement()
                array[i] = array[randomIndex!]
                array[randomIndex!] = temp
            }
            
            return array
        }
    }
}

//MARK:-  Sorting and Searching Revision

extension IQ_DynamicProgramming{
    
    func sortArray(_ nums1: [Int], _ nums2: [Int], _ m : Int, _ n: Int) -> [Int] {
        var k = m+n-1
        var i = m-1
        var j = n-1
        var nums1 = nums1
        
        while k >= 0 && j>=0 {
            if i>=0 && nums1[i] > nums2[j] {
                nums1[k] = nums1[i]
                i-=1
            } else {
                nums1[k] = nums2[j]
                j-=1
            }
            k-=1
        }
        
        return nums1
    }
    
    func firstBadVersion_Rev(_ n: Int) -> Int {
        //O(logn)
        var left = 0
        var right = n - 1
        
        while (left < right){
            let mid = left + (right - left) / 2
            
            if isBadVersion(mid){
                right = mid
            } else {
                left = mid + 1
            }
        }
        
        return left
    }
}

//MARK:- Dynamic Programming Revision

extension IQ_DynamicProgramming{
    
    func climbStairs_Rev(_ n: Int) -> Int {
        if n == 0 { return 0 }
        if n == 1 { return 1 }
        if n == 2 { return 2 }
        
        var d = [1:1, 2:2]
        
        for i in 3...n {
            let curr = d[i - 1]! + d[i - 2]!
            d[i] = curr
        }
        
        return d[n]!
    }
    
    func maxSubArray_Rev(_ nums: [Int]) -> Int {
        var sum = 0
        var maxSum = Int.min
        
        for n in nums{
            sum += n
            
            if n > sum{
                sum = n
            }
            
           maxSum = max(maxSum, sum)
        }
        
        return maxSum
    }
    
    func rob_Rev(_ nums: [Int]) -> Int {
        if nums.count == 0 { return 0 }
        if nums.count == 1 { return nums[0] }
        if nums.count == 2 { return max(nums[0], nums[1])}
        
        var dp = Array(repeating: 0, count: nums.count)
        dp[0] = nums[0]
        dp[1] = max(nums[0], nums[1])
        
        for i in 2..<nums.count{
            print(dp)
            dp[i] = max(nums[i] + dp[i - 2], dp[i - 1])
        }
        
        return dp[nums.count - 1]
    }

}

