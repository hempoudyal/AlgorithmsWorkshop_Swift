//
//  IQ-ArrayVC.swift
//  AlgorithmsWorskhop
//
//  Created by Hem Poudyal on 6/15/20.
//  Copyright © 2020 Hem Poudyal. All rights reserved.
//

import Foundation
import UIKit

class IQ_ArrayVC: BaseViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Array"
        
        objectList = [Objects(key: "Easy Category",
                              objects: ["Best Time to Buy and Sell Stock II",
                                        "Rotate Array",
                                        "Contains Duplicate",
                                        "Single Number",
                                        "Intersection of Two Arrays II",
                                        "Plus One",
                                        "Two Sum",
                                        "Valid Sudoku",
                                        "Rotate Image"]),
                    Objects(key: "Cracking Code Interview",
                                    objects:["Zero Matrix"])
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
                //Best Time to Buy and Sell Stock II
                // [1,2,3,4,5] -> 4
                // [7,6,4,3,1] -> 0
                // [6,1,3,2,4,7]
                //let p = maxProfit([6,1,3,2,4,7])
                //print(p)
                let b = betterSol_MaxProfit([6,1,3,2,4,7])
                print(b)
                
            case 1:
                //Rotate Array
                //Given an array, rotate the array to the right by k steps, where k is non-negative.
                rotate([1,2], 3)
                rotate_Rev([1,2,3,4,5,6,7], 3)
                
            case 2:
                //Contains Duplicate
                let dup = containsDuplicate([1,2,3])
                print(dup)

            case 3:
                //Single Number
                let s = singleNumber([1,2,4,1,2])
                print(s)
                
            case 4:
                //Intersection of Two Arrays II
                //let i = intersect([2,2], [1,2,2,1])
                let i = betterSolIntersect([2,2,1,3], [2,2,5,3,5])
                print(i)
                
            case 5:
                //Plus One
                //Given a non-empty array of digits representing a non-negative integer, plus one to the integer.
                // The digits are stored such that the most significant digit is at the head of the list, and each element in the array contain a single digit.
                let d = plusOne([7,2,9])
                print(d)
                let x = plusOne_Rev([7,2,8,5,0,9,1,2,9,5,3,6,6,7,3,2,8,4,3,7,9,5,7,7,4,7,4,9,4,7,0,1,1,1,7,4,0,0,6])
                print(x)
                
            case 6:
                //Two Sum
                //Given an array of integers, return indices of the two numbers such that they add up to a specific target.
                //You may assume that each input would have exactly one solution, and you may not use the same element twice.
                let r = twoSum([2,1,14,5,15,18], 7)
                print(r)
                let t = twoSum1([2,7,11,15], 9)
                print(t)
                
            case 7:
                //Valid Sudoku
                //Determine if a 9x9 Sudoku board is valid.
                let s = isValidSudoku([
                    ["5","3",".",".","7",".",".",".","."],
                    ["6",".",".","1","9","5",".",".","."],
                    [".","9","8",".",".",".",".","6","."],
                    ["8",".",".",".","6",".",".",".","3"],
                    ["4",".",".","8",".","3",".",".","1"],
                    ["7",".",".",".","2",".",".",".","6"],
                    [".","6",".",".",".",".","2","8","."],
                    [".",".",".","4","1","9",".",".","5"],
                    [".",".",".",".","8",".",".","7","9"]
                ])
                print(s)
                
                let x = isValidSudoku_Rev([
                    ["5","3",".",".","7",".",".",".","."],
                    ["6",".",".","1","9","5",".",".","."],
                    [".","9","8",".",".",".",".","6","."],
                    ["8",".",".",".","6",".",".",".","3"],
                    ["4",".",".","8",".","3",".",".","1"],
                    ["7",".",".",".","2",".",".",".","6"],
                    [".","6",".",".",".",".","2","8","."],
                    [".",".",".","4","1","9",".",".","5"],
                    [".",".",".",".","8",".",".","7","9"]
                ])
                print(x)
                
            case 8:
                
                let r = rotate([
                  [1,2,3],
                  [4,5,6],
                  [7,8,9]
                ])

                
            default:
                break
            }
            
        case 1:
            switch  indexPath.row {
            case 0:
                //Zero Matrix
                //Write an algorithm such that if an element in an MxN matrix is 0, its entire row and
//column are set to 0.
                zeroMatrix([
                [1,2,3],
                [0,1,2],
                [4,5,6]
                ])
                
            default:
                break
            }
            
            
        default:
            break
        }
        
    }
    
    func quickSort(_ arr: [Int]) -> [Int] {
        var less = [Int]()
        var equal = [Int]()
        var more = [Int]()
        
        if arr.count > 1 {
            let pivot = arr[0]
            
            for n in arr{
                if pivot > n {
                    less.append(n)
                } else if pivot < n {
                    more.append(n)
                } else {
                    equal.append(n)
                }
            }
            
            return (quickSort(less) + equal + quickSort(more))
        } else {
            return arr
        }
    }
    
    func rotate_Rev(_ arr: [Int],_ k: Int) {
        var nums = arr
        
        if arr.count < 2 { print(arr) }
        
        for i in 0..<arr.count {
            let keyI = (i + k) % arr.count
            nums[keyI] = arr[i]
        }
        print(nums)
    }
    
    func plusOne_Rev(_ digits: [Int]) -> [Int] {
        //wrong approach
        var sum = Int.min
        for n in digits{
            sum *= 10
            sum += n
        }
        
        sum += 1
        
        var newDigits = [Int]()
        while sum != 0 {
            let n = sum % 10
            sum /= 10
            newDigits.append(n)
        }
        
        return newDigits.reversed()
        
    }
    
    func isValidSudoku_Rev(_ board: [[Character]]) -> Bool {
        
        for row in board {
            var rowNums = [Int]()
            for n in row {
                if let num = Int(String(n)){
                    rowNums.append(num)
                }
            }
            let s = Set<Int>(rowNums)
            if s.count < rowNums.count{
                return false
            }
        }
        
        var boardT = board
        for i in 0..<board.count {
            for j in 0..<board.count {
                let temp = boardT[i][j]
                boardT[i][j] = boardT[j][i]
                boardT[j][i] = temp
            }
        }
        
        for col in boardT {
            var colNums = [Int]()
            for n in col {
                if let num = Int(String(n)){
                    colNums.append(num)
                }
            }
            let s = Set<Int>(colNums)
            if s.count < colNums.count{
                return false
            }
        }
        
        return true
    }
    
}

// Solutions
extension IQ_ArrayVC {
    
    func maxProfit(_ prices: [Int]) -> Int {
        
        //your runtime beats 19% of submission - not a good solution
        if prices.count < 2 {
            return 0
        }
        
        var profit1 = 0
        var i = 0
        var j = 0
        
        while i != prices.count {
            
            var diff = 0
            print(i)
            print(j)
            
            if prices[i] <= prices[j] {
                j = i
            } else if prices[i] > prices[j] {
                
                if i < prices.count - 1 {
                    if prices[i + 1] > prices[i] {
                        i += 1
                        continue
                    }
                    else {
                        diff =  prices[i] - prices[j]
                        profit1 += diff
                        j = i + 1
                    }
                } else {
                    diff =  prices[i] - prices[j]
                    profit1 += diff
                    j = i + 1
                }
                
            }
            
            i += 1
        }
        print(profit1)
        
        var max = 0
        var p = 0
        for i in 1..<prices.count {
            if max < prices[i] {
                max = prices[i]
                p = i
            }
        }
        
        var min = prices[0]
        for j in 0..<p {
            if min > prices[j]  {
                min = prices[j]
            }
        }
        
        var profit2 = max - min
        if profit2 < 0 {
            profit2 = 0
        }
        
        return profit2 > profit1 ? profit2 : profit1
        
    }
    
    func betterSol_MaxProfit(_ prices: [Int]) -> Int {
        var maxProfit = 0
        for i in 1 ..< prices.count {
            if prices[i] > prices[i - 1] {
                maxProfit += prices[i] - prices[i - 1]
            }
        }
        return maxProfit
    }
    
    func rotate(_ nums: [Int], _ k: Int) {
        //Beats 76% of swift Submission
        //Using Extra Array
        
        var newArr = nums
        
        for i in 0..<nums.count {
            newArr[(i + k) % nums.count] = nums[i]
        }
        
        print(newArr)
    }

    func containsDuplicate(_ nums: [Int]) -> Bool {
        //Better than 53%
        //Hash Table Approach
        
        //let s = Set<Int>(nums)
        var s = Set<Int>()
        for n in nums {
            if s.contains(n){
                return true
            }
            s.insert(n)
        }
        
        return false
        
        //Better one line solution
        //return Set(nums).count != nums.count
        
        //Using Key-Value Pair Approach
        /*
         
        var freqMap = [Int: Int]()
        nums.map { freqMap[$0, default: 0] += 1 }
        for (key, val) in freqMap {
            if val > 1 { rerturn true }
        }
        
        return false
         
        */
    }
    
    func singleNumber(_ nums: [Int]) -> Int {
        //Beats 90%
        // Bit Manipulation

        var a = 0
        for n in nums {
            a ^= n
        }

        return a
        
        // Math -> 2 ∗ (a+b+c)−(a+a+b+b+c)=c
   /*     var s = Set<Int>()
        var sumOfSet = 0
        
        for n in nums {
            if !s.contains(n){
                s.insert(n)
                sumOfSet += n
            }
        }
        
        var sumOfArray = 0
        for n in nums {
            sumOfArray += n
        }
        
        return (2 * sumOfSet) - sumOfArray */
    }
    
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        //Beats 77 % of Swift submission
        
        if nums1.count == 0 || nums2.count == 0 {
            return []
        }
        
        let smallArray = nums1.count < nums2.count ? nums1 : nums2
        var largeArray = nums1.count > nums2.count ? nums1 : nums2
        
        var interArray = [Int]()
        
        var i = 0
        
        outerLoop: while i != smallArray.count {
            for j in 0..<largeArray.count {
            
                if largeArray[j] == smallArray[i] {
                    interArray.append(largeArray[j])
                    largeArray.remove(at: j)

                    if i == smallArray.count {
                        break outerLoop
                    }
                    
                    break
                }
            }
            
            i += 1
        }
        
        return interArray
    }
    
    func betterSolIntersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        
        var map = [Int: Int]()
        for n in nums1 {
            map[n] = (map[n] ?? 0) + 1
        }
        print(map)
        
        var result = [Int]()
        for n in nums2 {
            if map[n] ?? 0 > 0 {
                map[n] = (map[n] ?? 0) - 1
                result.append(n)
            }
            print(map)
        }
        
        return result
    }
    
    /*
    //Ditch this approach-- don't take your ego too far - idiot
    func plusOne(_ digits: [Int]) -> [Int] {
        
        if digits.count < 1 {
            return []
        }
        
        var arr = digits
        let N = digits.count
        var count = 0
 
        for n in digits {
            if n == 9 {
                count += 1
            }
        }
        
        if count == N { // 9, 99 ,999
            arr.append(0)
            arr[0] = 1
            if N > 1{
                for i in 1..<N {
                    arr[i] = 0
                }
            }
            
        } else if count == 0 {
            //232
             arr[N - 1] += 1
            
        }else if count == N - 1 { // 399, 919, 2
            if arr[0] != 9 { //399
                arr[0] += 1 // 2
                if N > 1{
                    for i in 1..<N {
                        arr[i] = 0
                    }
                }
            } else { // 919, 29
                arr[N - 1] = 0
                arr[N - 2] += 1
            }
        } else if arr[N - 1] == 9{ //249
            arr[N - 1] = 0
            arr[N - 2] += 1
        } else {// 210
            arr[N - 1] += 1
        }
 
        return arr
    } */
    
    /* String Approach - failed with large Int
    func plusOne(_ digits: [Int]) -> [Int] {
        
        if digits.count == 0 {
            return []
        }
        
        let nums = digits
        var numStr = ""
        
        for n in nums {
            numStr += String("\(n)")
        }
        
        let newDigit = Int(numStr) ?? 0 + 1
            // var newDigitStr = "\(newDigit)"
        let res = String(newDigit).compactMap { Int(String($0)) }
        
        print(res)
        return res
        
    } */
    
    func plusOne(_ digits: [Int]) -> [Int] {
        //Beats 84 %
        
        var res = digits
        for i in (0..<res.count).reversed() {
            if res[i] != 9 {
                res[i] = res[i] + 1
                return res
            } else {
                res[i] = 0
            }
        }
        if res.first == 0 {
            res.insert(1, at: 0)
        }
        return res
    }
    
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        
        //Runtime Beats 16 % - bad performance for linear solution - Brute Force
        if nums.count < 2 {
            
            return nums
        }
        
        var j = 0
        var res = [Int]()
        
        while j != nums.count {
            for i in (j + 1)..<nums.count {
                if i != j {
                   // if nums[i] <= target && nums[j] <= target{
                        if nums[i] + nums[j] == target{
                            res = [j,i]
                            return res
                        }
                   // }
                }
            }
            j += 1
        }
        
        return res
    }
    
    func twoSum1(_ nums: [Int], _ target: Int) -> [Int] {
        guard nums.count > 1 else { return [] }
        
        var result = [Int]()
        var dict = [Int: Int]()
        
        for i in 0..<nums.count {
            let value = nums[i]
            //print(dict[value])
            
            if dict[value] != nil {
                result = [i, dict[value]!]
                break
            } else {
                let key = target - value
                dict[key] = i
            }
        }
        
        return result
    }
    
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        
        //Check the entire row and column
        //Runtime beats 95 % of solution - previously 53%
        
        for i in 0..<9 {
            var row = Set<Character>()
            var col = Set<Character>()
            
            for j in 0..<9 {
                print(board[i][j])
                if board[i][j] != "."{
                    if !row.contains(board[i][j]){
                        row.insert(board[i][j])
                    } else {
                        return false
                    }
                }
            }
            
            for j in 0..<9 {
                if board[j][i] != "."{
                    if !col.contains(board[j][i]){
                        col.insert(board[j][i])
                    } else {
                        return false
                    }
                }
            }
            
        }
        
        //Check every 3 by 3 sudoku matrix in a 9 by 9 matrix
        var i = 0
        while(i<9){
            i += 3
            var j = 0
            while(j<9){
                j += 3
                let s = sudoku(board: board, starti: i-3, startj: i-3, endi: i, endj: j)
                if s == false{
                    return false
                }
            }
        }
        
        return true
    }
    
    func sudoku(board: [[Character]],starti: Int, startj: Int, endi: Int, endj: Int) -> Bool{
        print(board)
        
        var box = Set<Character>()

        for i in starti..<endi {
            for j in startj..<endj{
                if board[i][j] != "."{
                    if !box.contains(board[i][j]){
                        box.insert(board[i][j])
                    } else {
                        return false
                    }
                }
            }
        }
        
        return true
    }
    
    func rotate(_ matrix: [[Int]]) {
        
        //Beats 92%
        
        var m = matrix
        let N = matrix.count
        
        for i in 0..<N {
            for j in 0..<i {
                let temp = m[i][j]
                m[i][j] = m[j][i]
                m[j][i] = temp
            }
        }
        
//        for i in 0..<N{
//            for j in 0..<N/2{
//                let temp = m[i][j]
//                m[i][j] = m[i][N - j - 1]
//                m[i][N - j - 1] = temp
//            }
//        }
        for i in 0..<N {
            m[i] = m[i].reversed()
        }
        
        print(m)
    }

}

//Cracking Code Interview
extension IQ_ArrayVC {
    
    func zeroMatrix(_ matrix: [[Int]]) {
        //M by N matrix
        let N = matrix.count // number of rows
        let M = matrix[0].count // number of cloumns
        var matrix = matrix
        
        //var newMatrix = matrix
        var zeroRows = [Bool](repeating: false, count: N)
        var zeroColumns = [Bool](repeating: false, count: M)

        for i in 0..<N {
            for j in 0..<M {
                if matrix[i][j] == 0 {
                    zeroRows[i] = true
                    zeroColumns[j] = true
                }
            }
        }
        
        //set zeroRows items to zero
        for i in 0..<zeroRows.count {
            if zeroRows[i] {
                makeRowZero(matrix: &matrix, i: i)
            }
        }
        
        print(matrix)
        
       //set zeroColumns items to zero
        for j in 0..<zeroColumns.count {
            if zeroColumns[j]{
                makeColumnZero(matrix: &matrix, j: j)
            }
        }
        
        //Uses O(N) space and operates in O(NM) time
        print(matrix)
    }
    
    func makeRowZero(matrix: inout [[Int]], i: Int) {
        // make all elements 0 of a particular row
        for j in 0..<matrix[0].count {
            matrix[i][j] = 0
        }
    }
    
    func  makeColumnZero(matrix: inout [[Int]], j: Int) {
        // make all elements 0 of a particular column
        for i in 0..<matrix.count {
            matrix[i][j] = 0
        }
    }
    
}
