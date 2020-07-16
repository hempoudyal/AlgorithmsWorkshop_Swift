//
//  UdemyVC.swift
//  AlgorithmsWorskhop
//
//  Created by Hem Poudyal on 6/30/20.
//  Copyright © 2020 Hem Poudyal. All rights reserved.
//

import Foundation
import UIKit

class UdemyVC: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Udemy Course - 11 Questions"
        
        objectList = [Objects(key: "Arrays",
                              objects: ["Most Frequently Occuring Item in an Array",
                                        "Common Elements in Two Sorted Arrays",
                                        "Is One Array a Rotation of Another?"]),
                      Objects(key: "Strings",
                              objects: ["Non-Repeating Character",
                                        "One Away Strings"]),
                      Objects(key: "Two Dimensional Arrays",
                              objects: ["Assign Numbers in Minesweeper",
                                        "Find where to Expand in MineSweeper"])
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
                let m = mostFrequest([3,3,1,3,2,1])
                print(m)
                
            case 1:
                let s = commonElements([1, 2, 9, 10, 11, 12], [0, 1, 2, 3, 4, 5, 8, 9, 10, 12, 14, 15])
                print("Set - \(s)")
                let a = commonElements([1, 2, 9, 10, 11, 12], [0, 1, 2, 3, 4, 5, 8, 9, 10, 12, 14, 15])
                print("Smart Two Pointers - \(a)")
                
            case 2:
                let s = rotationOfAnother([8, 2, 3, 4, 5, 6, 7], [6, 7, 8, 2, 3, 4, 5]) // - fails here
                print(s)
                let x = betterSol_rotation([8, 2, 3, 4, 5, 6, 7], arrB: [6, 7, 8, 2, 3, 4, 5])
                print(x)
                
            default:
                break
            }
            
        case 1:
            switch indexPath.row {
            case 0:
                let s = nonRepeatingCharacter("aabbdbc")
                print("first-\(s)")
                let x = betterSol_nonRepeatingCharacter("aabbbc")
                print("second-\(x)")
                
            case 1:
                let s = oneAwayString("abcd", "abcde")
                print(s)
                let x = instructor_oneAwayString("abbbe", "abcde")
                print(x)
            default:
                break
            }
            
        case 2:
            switch indexPath.row {
            case 0:
                mine_sweeper([[0,0],[0,1]], 3, 4)
                betterSol_mine_sweeper([[0,0],[0,1]], 3, 4)
                
            case 1:
//                click_MineSweeper([[0,0,0,0,0],
//                                   [0,1,1,1,0],
//                                   [0,1,-1,1,0]], 3, 5, 0, 1)
                click_MineSweeper([[-1,1,0,0],
                                   [1,1,0,0],
                                   [0,0,1,1],
                                   [0,0,1,-1]], 4, 4, 1, 3)
                instructorSol_ClickMineSweeper([[-1,1,0,0],
                                               [1,1,0,0],
                                               [0,0,1,1],
                                               [0,0,1,-1]], 4, 4, 1, 3)
                
            default:
                break
            }
            
            
        default:
            break
        }
    }
}

extension UdemyVC {
    
    func mostFrequest(_ array: [Int]) -> Int {
        
        var dict = [Int: Int]()
        array.map {dict[$0, default: 0] += 1}
        
        var maxCount = Int.min
        var maxItem = 0
        for (key, value) in dict {
            if value > maxCount {
                maxCount = value
                maxItem = key
            }
        }
        
        return maxItem
        
    }
    
    func commonElements(_ arr1: [Int], _ arr2: [Int]) -> [Int] {
        //10 minutes - net slow
        //Forgot to check for empty array
        if arr1.count == 0 || arr2.count == 0 {
            return []
        }
        
        let s = Set<Int>(arr1)
        var commonElements = [Int]()
        
        for n in arr2 {
            if s.contains(n){
                commonElements.append(n)
            }
        }
        
        return commonElements
    }
    
    func alternative_commonElements(_ arr1: [Int], _ arr2: [Int]) -> [Int] {
        //O(2n) -> O(n) speed - impressive solution
        
        if arr1.count == 0 || arr2.count == 0 {
            return []
        }
        
        var i = 0
        var j = 0
        var commonElements = [Int]()
        
        while i < arr1.count && j < arr2.count {
            if arr1[i] == arr2[j]{
                commonElements.append(arr1[i])
            } else if arr1[i] > arr2[j]{
                j += 1
            } else {
                i += 1
            }
        }
        
        return commonElements
    }
    
    func rotationOfAnother(_ arr1: [Int],_ arr2: [Int]) -> Bool {
        // Wrong solution - couldn't solve it
        if arr1.count != arr2.count {
            return false
        }
        
        if arr1.count == 0 || arr2.count == 0 {
            return false
        }
        
        if arr1 == arr2 {
            return false
        }
        
        var diff1 = arr1[1] - arr1[0]
        var nonLinearArr = [Int]()
        var linearArr = [Int]()
        for i in 0..<arr1.count - 1{
            if arr1[i + 1] - arr1[i] != diff1 {
                //non linear
                diff1 = arr2[1] - arr2[0]
                nonLinearArr = arr1
                linearArr = arr2
                break
            }
        }
        
        if nonLinearArr.count == 0 {
            nonLinearArr = arr2
            linearArr = arr1
        }
        
        var j = 0
        for i in 0..<nonLinearArr.count - 1 {
            if nonLinearArr[i + 1] - nonLinearArr[i] != diff1 {
                j = i + 1
            }
        }
        
        if j != 0 {
            let newArr = Array(nonLinearArr[j..<nonLinearArr.count] + nonLinearArr[0..<j])
            print(newArr)
            
            if newArr == linearArr{
                return true
            }
        }
        
        return false
    }
    
    func betterSol_rotation(_ arrA: [Int], arrB: [Int]) -> Bool {
        //We have to find if B is rotation of A
        if arrA.count != arrB.count { return false }
        
        let N = arrA.count
        let key = arrA[0]
        var keyI = -1
        
        for i in 0..<N - 1 {
            if arrB[i] == key{
                keyI = i
                break
            }
        }
        
        if keyI == -1 {
            return false //first element of A not found
        }
        
        for i in 0..<N {
            let j = (keyI + i) % N
            
            if arrA[i] != arrB[j] { return false }
        }
        
        return true
    }
    
    func nonRepeatingCharacter(_ str: String) -> Character? {
        //took more than 45 minutes
        //1. return first non repeating character
        //2. return nil if not found
        let arr = Array(str)
        
        var j = 0
        var i = 1
        var s = Set<Character>()
        
        while j < arr.count {
            
            if arr[j] == arr[i]{
                s.insert(arr[j])
                j += 1
                i = j
            }
            
            if s.contains(arr[j]){
                j += 1
                i = j
            }
            
            i += 1
            
            if i == arr.count {
                if !s.contains(arr[j]){
                    return arr[j]
                }
                
                break
            }
        }
        
        return nil
        
    }
    
    func betterSol_nonRepeatingCharacter(_ str: String) -> Character? {
        // took around 5 minutes
        // runtime - O(n)
        var dict = [Character: Int]()
        str.map {dict[$0, default: 0] += 1}
        
        for c in Array(str) {
            if dict[c] == 1 {
                return c
            }
        }
        
        return nil
    }
    
    func oneAwayString(_ s1: String, _ s2: String) -> Bool {
        // has to be logical check in the end
        
        var dict = [Character: Int]()

        s1.map { dict [$0, default: 0] += 1 }
        s2.map { dict [$0, default: 0] -= 1 }

        var count = 0
        for (key, value) in dict {
            if value != 0 {
               count += 1
            }
        }
        
        if count == 0 { return true }
        
        var sum = 0
        if count > 1 {
             for (key, value) in dict {
                sum += value
            }
        }
        
        if sum == 0 { return true}
        
        return false
    }
    
    func instructor_oneAwayString(_ s1: String, _ s2: String) -> Bool {

        var countDiff = 0
        let s1Arr = Array(s1)
        let s2Arr = Array(s2)
        
        if abs(s1Arr.count - s2Arr.count) >= 2 { return false }
        else if s1Arr.count == s2Arr.count {
            for i in 0..<s1Arr.count {
                if s1Arr[i] != s2Arr[i]{
                    countDiff += 1
                    if countDiff > 1 {
                        return false // abcde - abd
                    }
                }
            }
        }
        else if s1Arr.count > s2Arr.count {
            return oneAwayDiffLengths(s1Arr, s2Arr)
        } else {
            return oneAwayDiffLengths(s2Arr, s1Arr)
        }
        
        return true
    }
    
    func oneAwayDiffLengths(_ s1: [Character], _ s2: [Character]) -> Bool {
        // when s1.length == s2.length + 1
        //abcde - abde
        var i = 0
        var countDiff = 0
        while i < s2.count {
            if s1[i + countDiff] == s2[i]{
                i += 1
            } else {
                countDiff += 1
                if countDiff > 1 {
                    return false
                }
            }
        }
        
        return true
    }
    
    //MARK:- Two Dimensional Arrays
    
    func mine_sweeper(_ bombs: [[Int]], _ rowSize: Int, _ ColSize: Int) {
        //took around 40 minutes
        
        var matrix =  Array(repeating: Array(repeating: 0, count: ColSize), count: rowSize)
        
        for bomb in bombs {
            if let x = bomb.first, let y = bomb.last {
                matrix[x][y] = -1
                
                for i in 0..<rowSize {
                    for j in 0..<ColSize{
                        print("\(i),\(j)")
                        if abs(i - 1) == x && j == y{
                            if matrix[i][j] != -1 {
                                matrix[i][j] += 1
                            }
                        }
                        
                        if abs(j - 1) == y && x == i{
                            if matrix[i][j] != -1 {
                                matrix[i][j] += 1
                            }
                        }
                        
                        if abs(j - 1) == y && (i - 1) == x {
                            if matrix[i][j] != -1 {
                                matrix[i][j] += 1
                            }
                        }
                    }
                }
            }
        }
        
        print(matrix)
    }
    
    func betterSol_mine_sweeper(_ bombs: [[Int]], _ rowSize: Int, _ ColSize: Int) {
        
        var matrix =  Array(repeating: Array(repeating: 0, count: ColSize), count: rowSize)
        
        for bomb in bombs{
            let row_i = bomb[0]
            let col_i = bomb[1]
            matrix[row_i][col_i] = -1
            
            for i in (row_i - 1)..<(row_i + 2) {
                for j in (col_i - 1)..<(col_i + 2) {
                    
                    if 0 <= i && i < rowSize && 0 <= j && j < ColSize && matrix[i][j] != -1 {
                        matrix[i][j] += 1
                    }
                }
            }
        }
        
        print(matrix)
    }
    
    func click_MineSweeper(_ matrix: [[Int]], _ rowSize: Int, _ colSize: Int, _ clickedI: Int, _ clickedJ: Int ) {
        
        var matrix = matrix
        
        switch matrix[clickedI][clickedJ] {
        case -1 :
            print(matrix)
            
        case 1 :
            print(matrix)
            
        case 0 :
            //proceed
            for i in 0..<rowSize {
                for j in 0..<colSize {
                    if matrix[i][j] == 0 {
                        //search for other points around it to be zero
                        for m in (i - 1)..<(i + 2){
                            for n in (j - 1)..<(j + 2){
                                if 0 <= m && m < rowSize && 0 <= n && n < colSize{
                                    if matrix[m][n] == 0 {
                                        matrix[i][j] = -2
                                        matrix[m][n] = -2
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        default:
            break
        }
        print(matrix)
    }
    
    func instructorSol_ClickMineSweeper(_ matrix: [[Int]], _ rowSize: Int, _ colSize: Int, _ clickedI: Int, _ clickedJ: Int ){
        var toCheck = [[Int]]() // queue
        var matrix = matrix
        
        switch matrix[clickedI][clickedJ] {
        case 0 :
            //proceed
            matrix[clickedI][clickedJ] = -2
            toCheck.append([clickedI, clickedJ])
            
            while !toCheck.isEmpty {
                let firstElement = toCheck[0]
                let currentI = firstElement[0]
                let currentJ = firstElement[1]
                toCheck.remove(at: 0) // remove first element from queue
                
                for i in (currentI - 1)..<(currentI + 2) {
                    for j in (currentJ - 1)..<(currentJ + 2) {
                        if 0 <= i && i < rowSize && 0 <= j && j < colSize && matrix[i][j] == 0 {
                            matrix[i][j] = -2
                            toCheck.append([i,j])
                            print(toCheck)
                        }
                    }
                }
            }
            
        default:
            print(matrix) // for 1 and -1
        }
        
        print(matrix)
    }

}
