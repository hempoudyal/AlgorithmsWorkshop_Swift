//
//  IQ-StringVC.swift
//  AlgorithmsWorskhop
//
//  Created by Hem Poudyal on 6/20/20.
//  Copyright © 2020 Hem Poudyal. All rights reserved.
//

import Foundation
import UIKit

class IQ_StringVC: BaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Array"
        
        objectList = [Objects(key: "Easy Category",
                              objects: ["Reverse String",
                                        "Reverse Integer",
                                        "First Unique Character in a String",
                                        "Valid Anagram",
                                        "Valid Palindrome",
                                        "String to Integer (atoi)",
                                        "Implement strStr()",
                                        "Count and Say",
                                        "Longest Common Prefix"])
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
                reverseString(["h","e","l","l","o"])
                
            case 1:
                let s = reverse(1200)
                print(s)
                
            case 2:
                //let s = firstUniqChar("dddccdbba")
                let s = betterSolfirstUniqChar("dddccdbba")
                print(s)
                
            case 3:
                //Valid Anagram
                let a = isAnagram("anagram", "nagaram")
                print(a)
                
            case 4:
                //Valid Palindrome
                let p = isPalindrome("A man, a plan, a canal: Panama")
                print(p)
                let x = betterSolIsPalindrome("abb'a")
                print(x)
                
            case 5:
                //String to Integer (atoi)
                // "+-2"
                // "-91283472332"
                let p = betterSol_myAtoi("4193 with words")
                print(p)
                
            case 6:
                //let s = strStr("mississippi", needle: "issip")
                //print(s)
                let x = alternativeSol_strStr("mmiiississippi", needle: "issip")
                print(x)
                
            case 7:
                let n = countAndSay(6)
                print(n)
                break
            
            case 8:
                //Longest common prefix
//                let l = longestCommonPrefix(["flower","flow","flight"])
//                print(l)
                let l = betterSol_longestCommonPrefix(["flower","flow","flight"])
                print(l)
                permutation(string: "abc")
                
                let n = rev_longestCommonPrefix(["c","c"])
                print(n)
                
            default:
                break
            }
            
        default:
            break
        }
    }
    
    func rev_longestCommonPrefix(_ strs: [String]) -> String {
        
        guard strs.count > 0 else { return "" }
        
        var prefix = Array(strs[0])
        
        for i in 1..<strs.count{
            
            let s = Array(strs[i])
            let word = prefix
            prefix.removeAll()
        
            for j in 0..<strs[i].count {
                if j < word.count{
                    if s[0] != word[0] {
                        return ""
                    } else if s[j] == word[j] {
                        prefix.append(s[j])
                    }
                }
            }
        }
        
        return String(prefix)
    }
    
}

//Easy Solutions
extension IQ_StringVC {
    
    func reverseString(_ s: [Character]) {
        //Beats 92 %
        
        var s = s
        var i = 0
        var j = s.count - 1
        
        guard j > 0 else { return }
        
        while i < j {
            let temp = s[i]
            s[i] = s[j]
            s[j] = temp
            i += 1
            j -= 1
        }
        
        print(s)
    }
    
    func reverse(_ x: Int) -> Int {
        // 2147483648
        //Beats 83% of swift submission
        
        guard x > 9 || x < -9 else { return x }
        
        var num = x
        var numArr = [Int]()
        var isNonZeroFound = false
        //var s = String()
        
        while num != 0{
            let digit = abs(num % 10)
            //s.append(String(digit))
            if digit != 0 {
                isNonZeroFound = true
            }
            if isNonZeroFound {
                print(digit)
                numArr.append(digit)
            }
            num /= 10
        }
        
        //var digitx = Int(s)
        //print(digitx)
        var newDigit = numArr.reduce(0, { return $0*10 + $1 })
        
        if x < 0 {
            newDigit = -newDigit
        }
        
        if  Double(newDigit) > ( pow(2, 31) - 1) || Double(newDigit) < -(pow(2, 31)) {
            newDigit = 0
        }
        
        return newDigit
    }
    
    func firstUniqChar(_ s: String) -> Int {
        //Beats 73%
        if s == "" { return -1 }
        if s.count == 1 { return 0 }
        
        let char = Array(s)
        var j = 0
        var i = 1
        
        while j != char.count {
            
            if char[j] == char[i] && i != j {
                j += 1
                i = -1
            }
            
            if i == char.count - 1 {
                break
            }
            
            i += 1
        }
        
        if j == char.count {
            return -1
        }
        
        return j
    }
    
    func betterSolfirstUniqChar(_ s: String) -> Int {
        var array = Array(repeating: 0, count: 26)
        let base = Int("a".unicodeScalars.first!.value)
        print(base)
        for i in s.unicodeScalars{
            print(i)
            print(i.value)
            let index = Int(i.value) - base
            array[index] += 1
        }
        print(array)
        var resultIndex = 0
        for c in s.unicodeScalars{
            print(c)
            let index = Int(c.value) - base
            if array[index] == 1{
                return resultIndex
            }
            resultIndex += 1
        }
        return -1
        
        //do with Hash Map
    }
    
    func isAnagram(_ s: String, _ t: String) -> Bool {
        
        //Beats 72 % of runtime
        //Runtime - O(n)
        //Space complexity - O(1)
        /*
         if s.count != t.count {
         return false
         }
         
         var dictS = [Character: Int]()
         var dictT = [Character: Int]()
         
         s.map { dictS[$0, default: 0] += 1 }
         
         t.map { dictT[$0, default: 0] += 1}
         
         return dictS == dictT ? true : false
         
         */
        /* Better - Beats 99% -> it is less than 2*O(n)
         */
        if s.count != t.count {
            return false
        }
        var count: [Int] = [Int](repeating: 0, count: 26)
        let start: UInt32 = "a".unicodeScalars.first!.value
        for c in s.unicodeScalars {
            count[Int(c.value - start)] += 1
        }
        for c in t.unicodeScalars {
            let index = Int(c.value - start)
            count[index] -= 1
            if count[index] < 0 {
                return false
            }
        }
        return true
        
        // */
    }
    
    func isPalindrome(_ s: String) -> Bool {
        // empty string and single string is also a palindrome
        //beats 10% - poor performance
        
        let pattern = "[^A-Za-z0-9]+"
        let str = s.replacingOccurrences(of: pattern, with: "", options: .regularExpression).lowercased()
        let arr = Array(str)
        
        if arr.count < 2 {
            return true
        }
        
        if arr.count == 2 {
            if arr[0] == arr[1]{
                return true
            }
            return false
        }
        
        let mid = arr.count/2
        var leftStr = [Character]()
        var rightStr = [Character]()
        
        for l in (0...(mid - 1)).reversed(){
            leftStr.append(arr[l])
        }
        
        if arr.count % 2 == 0 { //for even number of string
            rightStr.append(arr[mid])
        }
        
        for r in (mid + 1)..<arr.count {
            rightStr.append(arr[r])
        }
        
        return leftStr == rightStr
        
    }
    
    func betterSolIsPalindrome(_ s: String) -> Bool {
        var arr = [String]()
        
        for c in s {
            if c.isLetter || c.isNumber {
                arr.append(c.lowercased())
            }
        }
        
        var i = 0
        var j = arr.count - 1
        
        print(arr)
        while i < j {
            if arr[i] != arr[j] {
                return false
            }
            
            i += 1
            j -= 1
        }
        
        return true
    }
    
    func myAtoi(_ str: String) -> Int {
        
        //couldn't solve - trapped in condition one after another
        // var arr = Array(str)
        var res = [Character]()
        var isNumFound = false
        
        for c in str{
            if c.isNumber || c == "+" || c == "-" {
                
                if !isNumFound && c == "0"{
                    res.append(c)
                    isNumFound = true
                }
                
            } else {
                if isNumFound {
                    break
                }
                
                if c != " "{
                    if c.isLetter {
                        if !isNumFound {
                            return 0
                        } else {
                            break
                        }
                    } else { return 0 }
                }
            }
        }
        
        print(res)
        if res.count > 10 {
            if res[0] == "-" {
                return -2147483648
            }
            return 2147483647
        }
        
        let myStr = String(res)
        if let myInt = Int(myStr){
            if  Double(myInt) > (pow(2, 31) - 1){
                let i = NSDecimalNumber(decimal: pow(2, 31))
                return Int(truncating: i)
            }
            if Double(myInt) < -(pow(2, 31)){
                let i = NSDecimalNumber(decimal: -(pow(2, 31)))
                return Int(truncating: i)
            }
            return myInt
        } else {
            return 0
        }
        
    }
    
    func betterSol_myAtoi(_ str: String) -> Int {
        //always start with the condition that has to meet, slowly ignore what is not needed
        //Beat 90 %
        var res = 0
        var isPos = true
        var isNum = false
        
        for c in str {
            if let i = Int(String(c)) {
                res = res * 10 + i
                isNum = true
                guard res <= Int32.max else { return isPos ? Int(Int32.max) : Int(Int32.min) }
                
            } else if !isNum && (c == "+" || c == "-") { //no entry for second time
                isPos = c == "+"
                isNum = true
                
            } else if !isNum && c == " " {
                continue
                
            } else {
                break
            }
        }
        
        return isPos ? res : -res
    }
    
    func strStr(_ hayStack: String, needle: String) -> Int {
        
        // time taken 30 mins
        //     ** Brute Force - Time limit exceeded **
        
        //
        //        while i < hArr.count {
        //            if hArr[i] == nArr[j] {
        //                j += 1
        //
        //            } else {
        //                if j > 1{
        //                    i = j - 1
        //                    j = 0
        //                    continue
        //                }
        //                j = 0
        //            }
        //
        //            i += 1
        //
        //            if j == nArr.count{
        //                return (i - j)
        //            }
        //
        //        }
        //
        //        return -1
        
        //Sliding window technique - time complexity is linear/ most of the time
        //Took like 10 minutes
        //Beats 80% of submission
        
        let nArr = Array(needle)
        let hArr = Array(hayStack)
        var j = 0
        var currentArr = [Character]()
        
        if (nArr.count == 0 ) { return 0 }
        if (hArr.count == 0 ) { return -1 }
        
        for i in 0..<hArr.count {
            currentArr.append(hArr[i])
            
            if (i >= nArr.count - 1) {
                if currentArr == nArr {
                    return j
                }
                currentArr.remove(at: 0)
                j += 1
            }
        }
        
        return -1
    }
    
    func alternativeSol_strStr(_ haystack: String, needle: String) -> Int {
        //Smart one - best with time complexity and space complexity
        //Break array into two components by needle - return count of first component
        if haystack.count == needle.count {
            return haystack != needle ? -1 : 0
        } else if needle.isEmpty {
            return 0
        }
        
        //print(haystack.components(separatedBy: needle))

        let count = haystack.components(separatedBy: needle)[0].count
        return count != haystack.count ? count : -1
    }
    
    func countAndSay(_ n: Int) -> String {
        
        //Beat 68% to 94% - solved by own !!!
        
        guard n >= 1 && n <= 30 else { return "" }
        
        var res = "1"
        
        for _ in 1..<n {
            let arr = Array(res)
            var rep = arr[0]
            var count = 0
            res.removeAll()
            
            for n in arr {
                if rep == Character(String(n)) {
                   count += 1
                } else {
                    res.append(String(count))
                    res.append(rep)
                                        
                    rep = n
                    count = 1
                }
            }
            
            res.append(String(count))
            res.append(rep)
        
        }
        
        return res
    }
    
    func longestCommonPrefix(_ strs: [String]) -> String {
        //rubbish approach, doesn't work - took 35 mins
        
        var count = [Int](repeating: -1, count: 26)
        let k = strs.count
        
        guard k > 0 else { return "" }
        
        var shortest = strs[0]
        
        for s in strs{
            if s.count < shortest.count {
                shortest = s
            }
        }
        print(shortest)
        
        let start: UInt32 = "a".unicodeScalars.first!.value
        for c in shortest.unicodeScalars {
            count[Int(c.value - start)] += k
        }
        print(count)
        for i in 0..<strs.count{
            for c in strs[i].unicodeScalars {
                count[Int(c.value - start)] -= k - i
            }
        }
        print(count)
        var finalString = ""
        let starting = Int(("a" as UnicodeScalar).value)
        for i in 0..<count.count {
            if count[i] == 0 {
                finalString.append(Character(UnicodeScalar(starting + i)!))
            }
        }
        print(finalString)
        
        return finalString
    }
    
    func betterSol_longestCommonPrefix(_ strs: [String]) -> String {
        
        //1. Horizontal Scanning
        // Beats 78 % - using swifts default prefix method
        
        guard strs.count > 0 else { return "" }
       /*  var prefix = strs[0]
        if strs.count > 1 {
            for i in 1..<strs.count {
                
                prefix = prefix.commonPrefix(with: strs[i])
            }
        }
        
        return prefix */
        
        //2. Vertical Scanning
        let s = strs.sorted{$0.count < $1.count}.map { Array($0) } //2D Array
        print(s)

        for i in 0..<s[0].count {
            let letter = s[0][i]
            for j in 0..<s.count {
                if i == s[j].count || s[j][i] != letter {
                    return String(s[0][0..<i]) //first matched letters of first word
                }
            }

        }
        
        return String(s[0])

    }
    
    func permutation(string: String, current: String = "") {
        let length = string.count
        let strArray = Array(string)
        if (length == 0) {
            // there's nothing left to re-arrange; print the result
            print(current)
            print("******")
        } else {
            // loop through every character
            for i in 0 ..< length {
                // get the letters before me
                let left = String(strArray[0 ..< i])
                // get the letters after me
                let right = String(strArray[i+1 ..< length])
                // put those two together and carry on
                permutation(string: left + right, current: current +
                    String(strArray[i]))
            }

        }
    }
     
}
