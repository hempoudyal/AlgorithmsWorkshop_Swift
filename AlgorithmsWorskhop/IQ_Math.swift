//
//  IQ_Math.swift
//  AlgorithmsWorskhop
//
//  Created by Hem Poudyal on 7/18/20.
//  Copyright © 2020 Hem Poudyal. All rights reserved.
//

import Foundation
import UIKit

class IQ_Math: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Array"
        
        objectList = [Objects(key: "Easy Category",
                              objects: ["Fizz Buzz",
                                        "Count Primes",
                                        "Power of Three",
                                        "Roman to Integer"]),
            
                      Objects(key: "Others - Easy Category",
                              objects: ["Number of 1 Bits",
                                        "Hamming Distance",
                                        "Reverse Bits",
                                        "Pascal's Triangle",
                                        "Valid Parentheses",
                                        "Missing Number"])
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
            switch indexPath.row {
            case 0:
                let f = fizzBuzz(10)
                print(f)
                let r = fizzBuzz_Rev(15)
                print(r)
                
            case 1:
                let c = countPrimes(20)
                print(c)
                let d = countPrimes2(10)
                print(d)
                
            case 2:
                let x = isPowerOfThree(243)
                print(x)
                let r = isPowerOfThree_Rev(243)
                print(r)
                
            case 3:
                let r = romanToInt("LVIII")
                print(r)
                let x = romanToInt_Rev("IV")
                print(x)
                
            default:
                break
            }
        
        case 1:
            switch indexPath.row {
            case 0:
                let n = hammingWeight(0b000000000000000000000000001011)
                print(n)
                let x = hammingWeight2(00000000000000000000000000001011)
                print(x)
                let r = hammingWeight_Rev(0b000000000000000000000000001011)
                print(r)
            case 1:
                let h = hammingDistance(3, 1)
                print(h)
                let x = hammingDistance2(93, 73)
                print(x)
                let r = hammingDistance_Rev(93, 73)
                print(r)
                
            case 2:
                let x = reverseBits(0b000010100101000001111010011100)
                print(x)
                let s = reverseBits2(0b000010100101000001111010011100)
                print(s)
                let r = reverseBits3(0b000010100101000001111010011100)
                print(r)
                let z = reverseBits_Rev(0b000010100101000001111010011100)
                print(z)
                
            case 3:
                let x = generate_PascalsTriangle(10)
                print(x)
                let r = generate_Rev(10)
                print(r)
                
            case 4:
                let r = isValid("()[]{}")
                print(r)
                let s = Sol_isValid("(])")
                print(s)
                let x = isValid_Rev("{()[]{}}")
                print(x)
                
            case 5:
                let m = missingNumber([9,6,4,2,3,5,7,0,1])
                print(m)
                let x = betterSol_MissingNumber([9,6,4,2,3,5,7,0,1])
                print(x)
                let r = missingNumber_Rev([9,6,4,2,3,5,7,0,1,8])
                print(r)
            default:
                break
            }
                
            
        default:
            break
        }
    }
}

extension IQ_Math {
    
    func fizzBuzz(_ n: Int) -> [String] {
        
        var arr = [String]()
        
        for i in 1...n {
            
            switch (i % 3 == 0, i % 5 == 0) {
            case (true, true):
                arr.append("FizzBuzz")
            case (true, false):
                arr.append("Fizz")
            case (false, true):
                arr.append("Buzz")
            default:
                arr.append("\(i)")
            }
        }
        
        return arr
    }
    
    func countPrimes(_ n: Int) -> Int {
        //Exceeded Time Limit
        
        if n <= 2 { return 0 }
        
        var isPrime = Array(repeating: true, count: n)
        isPrime[0] = false
        isPrime[1] = false
        
        for i in 2..<n{
            if isPrime[i] {
               markPrime(i, n, primeArr: &isPrime)
            }
        }
        
        var count = 0
        for n in isPrime{
            if n{
                count += 1
            }
        }
        
        return count
    }
    
    func markPrime(_ prime: Int, _ n: Int, primeArr: inout [Bool]){
        
        for i in prime+1..<n {
            if i % prime == 0 {
                primeArr[i] = false
            }
        }
    }
    
    func countPrimes2(_ n: Int) -> Int{
        if n <= 2 { return 0 }
        var isPrime = Array(repeating: true, count: n)
        isPrime[0] = false
        isPrime[1] = false
        var count = 0
        
        for i in 2..<n {
            guard isPrime[i] else { continue }
            count += 1
  
            var j = i + i
            while j < n {
                isPrime[j] = false
                j += i
            }
        }
       
        return count
    }
    
    func isPowerOfThree(_ n: Int) -> Bool {
        
        if n <= 0 { return false }

        let i = log(Double(n)) / log(Double(3))
        return pow(3.0, round(i)) == Double(n)
        
    }
    
    func romanToInt(_ s: String) -> Int {
        //Solved on my own
        
        let str = Array(s)
        
        let romanDict : [Character : Int] = ["I": 1,
                                             "V": 5,
                                             "X": 10,
                                             "L": 50,
                                             "C": 100,
                                             "D": 500,
                                             "M": 1000]
        
        var num = 0
        var i = str.count - 2
        var j = str.count - 1
        var sum = 0
        while j >= 0 {
            
            num = romanDict[str[j]]!
            
            if i >= 0 {
                if romanDict[str[i]]! < romanDict[str[j]]!{
                    num = num - romanDict[str[i]]!
        
                    i -= 1
                    j -= 1
                }
            }
            sum += num
            
            i -= 1
            j -= 1
        }
        
        return sum
    }
    
    func betterSol_romanToInt(_ s: String) -> Int {
         let romanSymbols: [ Character: Int ] = ["M":1000 ,"D": 500, "C": 100, "L": 50, "X": 10, "V": 5, "I": 1]

         var result = 0
         var prevWeight = 0
       
         for c in s.uppercased().reversed() {
             let weight = romanSymbols[c]!
             if weight >= prevWeight {
                 result += weight
             } else {
                 result -= weight
             }
             prevWeight = weight
         }
         
         return result
    }
}

//MARK:- Others

extension IQ_Math {
    //1. Number of 1 Bits
    func hammingWeight(_ n: UInt32) -> Int {
        var bits = 0
        var num:UInt32 = n
        
        while num != 0 {
            if (1 & num) == 1 {
                bits += 1
            }
            num >>= 1
        }
        
        return bits
    }
    
    func hammingWeight2(_ n: Int) -> Int {
        var count = 0, temp = n

        while temp != 0 {
            temp &= temp-1
            count += 1
        }

        return count
    }
    
    func reverseBits(_ n : UInt32) -> UInt32 {
        var n = n
        print(n)
        n = (n >> 16) | (n << 16)
        print(n)
        n = ((n & 0xff00ff00) >> 8) | ((n & 0x00ff00ff) << 8)
        print(n)
        n = ((n & 0xf0f0f0f0) >> 4) | ((n & 0x0f0f0f0f) << 4)
        print(n)
        n = ((n & 0xcccccccc) >> 2) | ((n & 0x33333333) << 2)
        print(n)
        n = ((n & 0xaaaaaaaa) >> 1) | ((n & 0x55555555) << 1)
        print(n)
        
        return n
    }
    
    func reverseBits2(_ n: Int) -> Int {
        //easy to understand
        var result = 0, input = n
        
        for _ in 0 ..< 32 {
            result = result << 1
            if input & 1 > 0 {
                result = result + 1
            }
            input >>= 1
        }
        
        return result
    }
    
    func reverseBits3(_ n: UInt32) -> UInt32 {
        var res: UInt32 = 0
        var n = n
        var power = 31
        
        for _ in 0..<32 {
            res += (n & 1) << power
            n = n >> 1
            power -= 1
        }
        
        return res
    }
    
    func hammingDistance(_ x: Int,_ y: Int) -> Int {
        var num1 = x, num2 = y
        var count = 0
        
        for _ in 0..<32{
            if num1 & 1 == 1 && num2 & 1 != 1{
                count += 1
            } else if num1 & 1 != 1 && num2 & 1 == 1{
                count += 1
            }
            num1 >>= 1
            num2 >>= 1
        }
        
        return count
    }
    
    func hammingDistance2(_ x: Int,_ y: Int) -> Int {
        let value = x ^ y
        let string = String(value, radix: 2)
        print(string)
        
        var count = string.count
        for i in string.indices{
            if string[i] == "0"{
                count -= 1
            }
        }
        
        return count
    }
    
    func generate_PascalsTriangle(_ numRows: Int) -> [[Int]] {
        guard numRows > 0 else { return [] }
        
        var arr = [[Int]]()
        
        for i in 0..<numRows{
            var nums = [Int]()
            
            for j in 0...i {
                if j == 0 || j == i {
                    nums.append(1)
                } else {
                    let prevArr = arr[i - 1]
                    let n = prevArr[j] + prevArr[j - 1]
                    nums.append(n)
                }
            }
            
            arr.append(nums)
        }
        
        return arr
    }
    
    func isValid(_ s: String) -> Bool {
        // Valid Parantheses
        if s == "" {return false}
        
        var arr = Array(s)
        let dict : [Character: Int] = ["(": 1, ")": 1,"{": 2,"}": 2, "[": 3, "]": 3]
        
        let mid = s.count / 2
        if dict[arr[mid]] == dict[arr[mid - 1]] {
            arr.remove(at: mid - 1)
            arr.remove(at: mid - 1)
        } else {
            return false
        }
        
        let str = String(arr)
        if str == "" { return true }

        return isValid(str)
    }
    
    func Sol_isValid(_ s: String) -> Bool {
        // Using Stack
        let bracketMap: [Character: Character] = ["(": ")", "[": "]",  "{": "}"]
        let openPar = Set<Character>(["(","[","{"])
        var stack = [Character]()
        for i in s {
            if openPar.contains(i){
                stack.append(i)
            } else if !stack.isEmpty{
                if i == bracketMap[stack.last!]{
                    stack.removeLast()
                } else { return false }
            } else {
                return false
            }
        }
        
        return stack.isEmpty
    }
    
    func missingNumber(_ nums: [Int]) -> Int {
        
        if nums.count == 0 { return 0 }
        
        var max = 0
        for n in nums{
            if n > max {
                max = n
            }
        }
        
        let arr = Array(0...max)
        let s1 = Set<Int>(arr)
        let s2 = Set<Int>(nums)
        let x = s1.symmetricDifference(s2)
        print(x)
        //way to go ahead
        if x.count == 1{ return x.first! }
        
//        for s in s1{
//            if !s2.contains(s){
//                return s
//            }
//        }
//
        return max + 1
        
    }
    
    func betterSol_MissingNumber(_ nums: [Int]) -> Int {
        var missing = nums.count
        for i in 0..<nums.count {
            missing ^= i ^ nums[i]
        }
        
        return missing
    }
}


enum Bit: UInt8, CustomStringConvertible {
    case zero, one

    var description: String {
        switch self {
        case .one:
            return "1"
        case .zero:
            return "0"
        }
    }
}


//MARK:- Revision
extension IQ_Math{
    func fizzBuzz_Rev(_ n: Int) -> [String] {
        var s = [String]()
        
        for i in 1...n{
            if i % 3 == 0 && i % 5 == 0 {
                s.append("FizzBuzz")
            } else if i % 5 == 0 {
                s.append("Buzz")
            } else if i % 3 == 0 {
                s.append("Fizz")
            } else {
                s.append(String(i))
            }
        }
        
        return s
    }
    
    func countPrimes_Rev(_ n: Int) -> Int {
        if n <= 2 { return 0 }
        var isPrime = Array(repeating: true, count: n )
        isPrime[0] = false
        isPrime[1] = false
        var count = 0
        
        for i in 2..<n{
            guard isPrime[i] else { continue }
            count += 1
            
            var j = i + i
            while j < n {
                isPrime[j] = false
                j += i
            }
        }
        
        return count
    }
    
    func isPowerOfThree_Rev(_ n: Int) -> Bool {
        if n <= 0 { return false }
        
        let i = log(Double(n)) / log(Double(3))
        return pow(3.0, round(i)) == Double(n)
    }
    
    func romanToInt_Rev(_ s: String) -> Int {
        let romanDict:[Character: Int] = ["I": 1, "V": 5, "X": 10, "L": 50, "C": 100, "D": 500, "M": 1000]
        var num = Int()
        var prev = 0
        
        for c in s.reversed(){
            let n = romanDict[c]!
            if n < prev {
                num -= n
            } else {
                num += n
            }
            prev = n
        }
        
        return num
    }
    
    func hammingWeight_Rev(_ n: Int) -> Int {
        var n = n
        var bits = 0
        
        while n != 0 {
            if (1 & n) == 1 {
                bits += 1
            }
            n >>= 1
        }
        
        return bits
    }
    
    func hammingDistance_Rev(_ x: Int, _ y: Int) -> Int {
        var x = x, y = y
        var count = 0
        
        for _ in 0..<32 {
            if x & 1 != y & 1{
                count += 1
            }
            x >>= 1
            y >>= 1
        }
        
        return count
    }
    
    func reverseBits_Rev(_ n: Int) -> Int {
        var result = 0
        var n = n
        print(n)
        //00000010100101000001111010011100
        
        for _ in 0..<32{
            result <<= 1
            if n & 1 == 1 {
                result += 1
            }
            n >>= 1
        }
        
        return result
        //00111001011110000010100101000000
    }
    
    func generate_Rev(_ numRows: Int) -> [[Int]] {
        if numRows < 1 { return [[]] }
        var arr = [[Int]]()
        
        for i in 1...numRows{
            var temp = [Int]()
            
            for j in 0..<i {
                if j == 0 || j == i - 1 {
                    temp.append(1)
                } else {
                    let prevRow = arr[i - 2]
                    let num = prevRow[j - 1] + prevRow[j]
                    temp.append(num)
                }
            }
            
            arr.append(temp)
        }
        
        return arr
    }
    
    func isValid_Rev(_ s: String) -> Bool {
        //Didn't work - wrong approach - solve using Queue
        let bracketDict: [Character: Character] = ["]":"[",")":"(","}":"{"]
        let openArr : [Character] = ["[","(","{"]
        var stack = [Character]()
        
        for c in s{
            if openArr.contains(c){
                stack.append(c)
            } else if !openArr.contains(c){
                let i = bracketDict[c]
                if stack.last == i {
                    stack.removeLast()
                } else {
                    return false
                }
            }
        }
        
        return true
    }
    
    func missingNumber_Rev(_ nums: [Int]) -> Int {
        if nums.count == 0 { return 0 }
        var maxValue = 0
        
        for n in nums{
            maxValue = max(maxValue, n)
        }
        
        let r = Array(0...maxValue)
        let setA = Set<Int>(r)
        let setB = Set<Int>(nums)
        let diff = setA.symmetricDifference(setB)
        
        if diff.count == 1 { return diff.first! }
    
        return maxValue + 1
    }
}
