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
                
            case 1:
                let c = countPrimes(20)
                print(c)
                let d = countPrimes2(10)
                print(d)
                
            case 2:
                let x = isPowerOfThree(243)
                print(x)
                
            case 3:
                let r = romanToInt("LVIII")
                print(r)
                
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
            case 1:
                break
                
            case 2:
                let x = reverseBits(0b000010100101000001111010011100)
                print(x)
                let s = reverseBits2(0b000010100101000001111010011100)
                print(s)
                let r = reverseBits3(0b000010100101000001111010011100)
                print(r)
            case 3:
                break
                
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
            input = input >> 1
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
