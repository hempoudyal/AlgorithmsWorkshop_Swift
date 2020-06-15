//
//  ArrayVC.swift
//  AlgorithmsWorskhop
//
//  Created by Hem Poudyal on 6/13/20.
//  Copyright © 2020 Hem Poudyal. All rights reserved.
//

import Foundation
import UIKit

class ArrayVC: BaseViewController {
    
    //var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Array"
        
        objectList = [Objects(key: "Introduction",
                              objects: ["Numbers with Even Number of Digits",
                                        "Squares of Sorted Array"]),
                      
                      Objects(key: "Inserting Items",
                              objects: ["Duplicate Zeros",
                                        "Merge Sorted Array"]),
                      
                      Objects(key: "Deleting Items",
                              objects: ["Remove Element",
                                        "Remove Duplicates from Sorted Array"]),
                      
                      Objects(key: "Searching for Items",
                              objects: ["Check If N and Its Double Exist",
                                        "Valid Mountain Array"]),
                      
                      Objects(key: "In Place Operations",
                              objects: ["Replace Elements with Greatest Element on Right Side",
                                        "Move Zeroes",
                                        "Sort Array by Parity",
                                        "Squares of a Sorted Array"]),
                      
                      Objects(key: "Conclusion",
                              objects: ["Height Checker",
                                        "Third Maximum Number",
                                        "Max Consecutive Ones II",
                                        "Find all numbers disappeared in an array"])
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
                //Given an array nums of integers, return how many of them contain an even number of digits.
                print(countDigits(3242))
                
            case 1:
                print(squaresOfaSortedArray([2,4,6,7,9]))
                
            default:
                break
            }
            
        case 1:
            switch indexPath.row {
            case 0:
                //Given a fixed length array arr of integers, duplicate each occurrence of zero, shifting the remaining elements to the right.
                duplicateZeros([1,0,2,3,0,4,5,0])
                
            case 1:
                merge1([1,2,3,0,0,0], 3, [2,5,6], 3)
                
            default:
                break
            }
            
        case 2:
            switch indexPath.row {
            case 0:
                //5. Remove Element
                //        Given nums = [3,2,2,3], val = 3,
                //        Your function should return length = 2, with the first two elements of nums being 2.
                //     ****    It doesn't matter what you leave beyond the returned length. ****
                
                let length = removeElement([0,1,2,2,3,0,4,2], 2)
                //let length = removeElement([2], 2)
                print(length)
                
            case 1:
                //6. Remove Duplicates from Sorted Array
                //Given a sorted array nums, remove the duplicates in-place such that each element appear only once and return the new length.
                let dups = removeDuplicates([0,1,2,2,2,3,3,4])
                print(dups)
                
            default:
                break
            }
            
        case 3:
            switch indexPath.row {
            case 0:
                //1. Check if N and Its Double Exist
                //Given an array arr of integers, check if there exists two integers N and M such that N is the double of M ( i.e. N = 2 * M).
                let double = checkIfnAndDoubleExist([10,2,5,3])
                print(double)
                
            case 1:
                //2. Valid Mountain Array
                let mountain = validMountainArray([0,3,2,1])
                print(mountain)
                
            default:
                break
            }
            
        case 4:
            switch indexPath.row {
            case 0:
                //1. Replace every element in that array with the greatest element among the elements to its right, and replace the last element with -1.
                //let arr = replaceElements([17,18,4,2,6,1])
                let arr = betterSolReplaceElements([17,18,4,2,6,1])
                print(arr)
                
            case 1:
                //2. Move Zeroes
                moveZeroes([0,1,0,3,12])
                
            case 2:
                //3. Sort Array By Parity
               // [3,1,2,4,6,7,110,0]
                let arr = sortArrayByParity([0,2,4])
                print(arr)
            
            case 3:
                //4. Square of a Sorted Array
                let arr = squaresOfaSortedArray([-1,-4,0,9,3,10])
                print(arr)
                
            default:
                break
            }
            
        case 5:
            switch indexPath.row {
            case 0:
                //5. Height Checker - count of students moved to rearrange based on heights
                let arr = heightChecker([1,1,4,2,1,3])
                print(arr)
                
            case 1:
                //6. Third Maximum Number
                let num = thirdMax([1,2,4,5,5,5,0,2])
                print(num)
                
            case 2:
               // Find Max Consecutives One II
                let num = maxConsecutiveOnesII([1,0,1,1,0])
                print(num)
                
            case 3:
                //7. Find All Disappeared Numbers in an Array
                 let nums = findDisappearedNumbers([4,3,2,7,8,2,3,1])
                 print(nums)
                
            default:
                break
            }
            
        default:
            break
        }
        
    }
    
    
    
    func countDigits(_ n: Int) -> Int {
        var number = n
        var count = 0
        while number != 0 {
            count += 1
            number /= 10
        }
        return count
    }
    
    
    func sortArray(_ A: [Int]) -> [Int] {
        guard A.count > 0 else {
            return []
        }
        
        var res = Array(repeating: 0, count: A.count)
        var leftPointer = 0
        var rightPointer = A.count - 1
        var insertPointer = A.count - 1
        
        while leftPointer <= rightPointer{
            if A[leftPointer] > A[rightPointer]{
                res[insertPointer] = A[leftPointer]
                leftPointer += 1
            } else {
                res[insertPointer] = A[rightPointer]
                rightPointer -= 1
            }
            
            insertPointer -= 1
        }
        
        return res
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
    
    
    func duplicateZeros(_ arr: [Int]) {
        // time taken - 1 hr
        
        var newArr = Array(repeating: 0, count: arr.count)
        
        var countZero = 0
        for n in arr {
            if n == 0 {
                countZero += 1
            }
        }
        
        if countZero == 0 {
            return
        }
        
        var j = 0
        for i in 0..<arr.count{
            
            if j == arr.count {
                break
            }
            if arr[i] == 0 {
                j += 2
                if j > arr.count{
                    j -= 1
                }
            } else {
                newArr[j] = arr[i]
                j += 1
            }
        }
        
        print(newArr)
    }
    
    func merge(_ nums1: [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        // time taken - 12 minutes
        var i = m
        var arr1 = nums1
        
        for n in nums2{
            arr1[i] = n
            i += 1
        }
        
        print(arr1)
        let sorted = sortArray(arr1)
        print(sorted)
        
    }
    
    //Better approach -->>> Based on Merge Sort Algorithm
    func merge1(_ nums1: [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var p1 = 0
        var p2 = 0
        var result = [Int]()
        while p1 < (nums1.count - nums2.count) && p2 < nums2.count {
            if nums1[p1] < nums2[p2] {
                result.append(nums1[p1])
                p1 += 1
            } else {
                result.append(nums2[p2])
                p2 += 1
            }
        }
        while p1 < (nums1.count - nums2.count) {
            result.append(nums1[p1])
            p1 += 1
        }
        while p2 < nums2.count {
            result.append(nums2[p2])
            p2 += 1
        }
        
        print(result)
    }
    
}

//MARK:- Delete from an Array
extension ArrayVC {
    
    func removeElement(_ nums: [Int], _ val: Int) -> Int {
        
        //move values to the end of array
        //remove last values
        //[0,1,2,2,3,0,4,2] /2
        //[2,2,2] / 3
        //[4,5] /4
        
        var arr = nums
        //
        //        var p1 = 0
        //        var p2 = nums.count
        //
        //        while p1 < p2 {
        //            if arr[p1] == val {
        //                arr[p1] = arr[p2 - 1]
        //                p2 -= 1
        //            } else {
        //                 p1 += 1
        //            }
        //            print(p1)
        //            print(p2)
        //            print(arr)
        //        }
        //        print(arr)
        //        print(p2)
        //
        //        return p2
        //    }
        //
        
        if arr.count <= 1 { return arr.count }
        
        var j : Int = 0
        
        for i in 1 ..< arr.count
        {
            if arr[i] != arr[j]
            {
                j += 1
                arr[j] = arr[i]
            }
            print(arr)
        }
        
        return j + 1
    }
    
    func removeDuplicates(_ nums: [Int]) -> Int {
        
        guard nums.count > 0 else {
            //nums = []
            return 0
        }
        
        var arr = nums
        var p1 = 0
        var p2 = 1
        
        while arr.count != p2 {
            if arr[p1] == arr [p2] {
                p2 += 1
            } else {
                if p1+1 != p2 {
                    arr[p1 + 1] = arr[p2]
                }
                p1 += 1
            }
        }
        
        return p1 + 1
    }
    
}

//MARK:- Searching for Array

extension ArrayVC {
    
    func checkIfnAndDoubleExist(_ arr: [Int]) -> Bool{
        //Beat 92%
        
        if arr.count == 0 {
            return false
        }
        
        var i = 0
        var j = 1
        var exist = false
        
        while i != arr.count-1 {
            
            if arr[i] * 2 == arr[j] || arr[j] * 2 == arr[i]{
                exist = true
                break
            }
            
            j += 1
            
            if j == arr.count {
                i += 1
                j = i+1
            }
            
        }
        
        return exist
        
    }
    
    func validMountainArray(_ A: [Int]) -> Bool {
        // Beat 96%
        
        let N = A.count
        if N < 3 {
            return false
        }
        
        var i = 1
        var j = 0
        var isValid = false
        
        while i != N {
            //increment
            if A[j] < A[i] {
                j += 1
                i += 1
            } else {
                break
            }
        }
        
        if j == 0 || j < N {
            return false
        }
        
        i = j
        j = i + 1
        
        while j != N {
            //decrement
            if A[j] < A[i] {
                i += 1
                j += 1
                
                if i == N - 1 {
                    isValid = true
                }
            } else {
                break
            }
        }
        
        return isValid
    }
    
}

//MARK:- In-Place Operations

extension ArrayVC {
    
    func replaceElements(_ arr: [Int]) -> [Int] {
        // Runtime beats 10.36 % - not good, took more than 1 hour to solve - 1156 ms
        var nums = arr
        if arr.count < 2 {
            if arr.count == 1{
                return [-1]
            }
            return arr
        }
        
        var j = 0
        var i = 1
        let N = nums.count
        var max = nums[i]
        
        while j != N {
            
            if i == N {
                nums[j] = max
                j += 1
                
                if j != N - 1{
                    i = j + 1
                    max = nums[i]
                } else {
                    nums[j] = -1
                    break
                }
                
            }
            
            if nums[i] > max {
                max = nums[i]
            }
            
            i += 1
            
        }
        
        return nums
        
    }
    
    func betterSolReplaceElements (_ arr: [Int]) -> [Int] {
        
        var i = arr.count-1
        var max = arr[i]
        var array = arr
        while i >= 0 {
            print(array)
            
            let temp = array[i]
            if i == arr.count-1 {
                array[i] = -1
            } else {
                array[i] = max
            }
            max = temp > max ? temp : max
            
            i -= 1
        }
        return array
        
    }
    
    func moveZeroes(_ nums : [Int]) {
        //1,0,1
        //Beats 87.7% runtime
        
        if nums.count < 2
        { print(nums) }
        
        var arr = nums
        var j = 0
        
        for i in 1..<arr.count {
            
            if arr[j] == 0 && arr[i] != 0 {
                arr[j] = arr[i]
                arr[i] = 0
                j += 1
            }
            
            if arr[j] != 0 {
                j += 1
            }
            
        }
        
        print(arr)
        
    }
    
    func sortArrayByParity(_ A: [Int]) -> [Int] {
        // Beats 81.79 % runtime
        
        guard A.count > 1 else { return A }
        
        var arr = A
        var j = 0
        
        for i in 1..<arr.count {
            print(arr)
            
            if arr[j] % 2 != 0 && arr[i] % 2 == 0 {
                //swap
                let temp = arr[j] // odd
                arr[j] = arr[i] // pass even
                arr[i] = temp //odd
                j += 1
            }
            
            if arr[j] % 2 == 0 {
                j += 1
            }
        }
        
        return arr
    }
    
    func squaresOfaSortedArray(_ A: [Int]) -> [Int] {
        
        // [-4, -1, 0, 3, 10]
        
        // Only works for sorted Array, which is already sorted but with negative values
        
        guard A.count > 0 else { return [] }
        
        
        var i = A.count - 1
        var j = 0
        var k = A.count - 1
        var res = Array.init(repeating: 0, count: A.count)
        
        while i >= j {
            
            if A[j] * A[j] < A[i] * A[i]  {
                res[k] = A[i] * A[i]
                i -= 1
            } else {
                res[k] = A[j] * A[j]
                j += 1
            }
            
            k -= 1
        }
        
        return res
    }
    
    func heightChecker(_ heights:[Int]) -> Int {
        
        //Beats 84 % of runtime
        //[1,2,3,4,5,3]
        guard heights.count > 0 else { return 0 }
        
        var moveCount = 0
        
        let sortedArr = quickSort(heights)
        print(sortedArr)
        
        for i in 0..<heights.count {
            if heights[i] != sortedArr[i] {
                moveCount += 1
            }
        }
        
        return moveCount
    }
    
    //Right Approach but slight mistakes :
    
    func thirdMax(_ nums:[Int]) -> Int {
        //Beats runtime of 70 % submissions
        
        var max = Int.min
        var max2 = Int.min
        var max3 = Int.min
        
        for n in nums {
            if n >= max {
                if n == max {
                    continue
                }
                max3 = max2
                max2 = max
                max = n
            } else if n >= max2 {
                if n == max2 {
                    continue
                }
                max3 = max2
                max2 = n
            } else if n > max3 {
                max3 = n
            }
        }
        
        return max3 == Int.min ? max : max3 // if still Int.min send max
        
    }
    
    //Wrong Approach - O(n) not considered
    //    func thirdMax (_ nums: [Int]) -> Int {
    //
    //        var max = 0
    //        var count = 0
    //        var i = nums.count - 1
    //
    //        let sortedArr = quickSort(nums)
    //
    //        while i >= 0 {
    //
    //            if max != sortedArr[i] {
    //                max = sortedArr[i]
    //                count += 1
    //            }
    //
    //            if count == 3 {
    //                break
    //            }
    //
    //            i -= 1
    //        }
    //
    //        return count != 3 ? sortedArr[nums.count - 1] : max
    //
    //    }
    
    /*       func thirdMax(_ nums: [Int]) -> Int {
     var maxOne = Int.min
     var maxTwo = Int.min
     var maxThree = Int.min
     
     var index = 0
     
     while index < nums.count {
     let value = nums[index]
     if value >= maxOne {
     if value == maxOne { index += 1; continue }
     maxThree = maxTwo
     maxTwo = maxOne
     maxOne = value
     } else if value >= maxTwo {
     if value == maxTwo { index += 1; continue }
     maxThree = maxTwo
     maxTwo = value
     } else if value > maxThree {
     maxThree = value
     }
     
     index += 1
     }
     
     return maxThree == Int.min ? maxOne : maxThree
     } */
    
    func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
        //Beats 70 % runtime
        var nums = nums
        var res = [Int]()
        
        if nums.count < 2 {
            return nums
        }
        
        for n in nums {
            let i = n - 1
            nums[i] = 0
        }
        
        for i in 0..<nums.count {
            
            if nums[i] != 0 {
                res.append(i+1)
            }
            
        }
        
        return res
        
    }
    
    func maxConsecutiveOnesII(_ nums: [Int]) -> Int {
        
        var i = 0
        var j = 0 //index
        var countZero = 0 //zero -> can be bool
        var max = 0
        var n = 0 //count
        
        while i != nums.count {
            //            print ("---*---")
            //            print(i)
            //            print(j)
            //            print(n)
            //            print(max)
            //            print(countZero)
            
            if nums[i] == 0 {
                countZero += 1
                let temp = i
                
                if countZero == 2 {
                    
                    if max < n {
                        max = i
                    }
                    
                    countZero = 1
                    i = j
                    n = 0
                }
                
                j = temp
            }
            
            i += 1
            n += 1
        }
        
        return max
    }
    
}


