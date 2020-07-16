//
//  IQ-LinkedList.swift
//  AlgorithmsWorskhop
//
//  Created by Hem Poudyal on 7/10/20.
//  Copyright © 2020 Hem Poudyal. All rights reserved.
//

import Foundation
import UIKit

class IQ_LinkedList: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Linked List"
        
        objectList = [Objects(key: "Easy Category",
                              objects: ["Delete Node in a Linked List",
                                        "Remove Nth Node from End of List",
                                        "Reversed Linked List",
                                        "Merge Two Sorted Lists",
                                        "Palindrome Linked List",
                                        "Linked List Cycle"])
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
              //  removeNthNode(ListNode(), 2)
               // deleteNode(T##node: ListNode?##ListNode?)
                break
                
            default:
                break
            }
            
        default:
            break
        }
    }
    
//    public class ListNode {
//        public var val: Int
//        public var next: ListNode?
//        public init(_ val: Int) {
//            self.val = val
//            self.next = nil
//         }
//    }
    
     public class ListNode {
         public var val: Int
         public var next: ListNode? // child
         public init() { self.val = 0; self.next = nil; }
         public init(_ val: Int) { self.val = val; self.next = nil; }
         public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
     }
}

//Easy Solutions
extension IQ_LinkedList {
    //1. Delete Node in a Linked List
    //Given linked list -- head = [4,5,1,9] -> [4,1,9]
    
    func deleteNode(_ node: ListNode?) {
//        if let n = node?.next?.val{
//            node?.val = n
//        }
//        node?.next = node?.next?.next
        guard let node = node, let value = node.next?.val else { return }
        node.val = value // assign next value to current node - [4,1,1,9]
        node.next = node.next?.next //bypass next 1 - [4,1,9]
    }
    
    //2.Remove Nth Node
    // [4,5,3,2,1] , n = 2 -> [4,5,3,1]
    
    func removeNthNode(_ head: ListNode?,_ n: Int) -> ListNode? {
        guard let head = head else { return nil }
        
        // Get count of nodes
        var node: ListNode? = head
        var nodesCount = 0
        while node != nil {
            nodesCount += 1
            node = node?.next
        }
        
        // Remove node
        guard n <= nodesCount else { return nil }
        
        let nodeIndex = nodesCount - n
        guard nodeIndex != 0 else { return head.next } // remove header // -> 3
        
        let prevNodeIndex = nodeIndex - 1 // -> 2
        node = head // -> 0
        for _ in 0..<prevNodeIndex {
            node = node?.next // 3
        }
        
        node?.next = node?.next?.next //1
        
        return node
    }
    
    //Udemy Course - find Nth Element of a Linked List
    //[5,4,3,2,1], 3 -> 3
    //[5,4,3,2,1], 6 -> nil
    //[1,2,3], 3 -> 3
    
    func findNthNode(_ head: ListNode?,_ n: Int) -> ListNode? {
        guard let head = head else { return nil }
        
        var node: ListNode? = head
        var nodesCount = 0
        while node != nil {
            nodesCount += 1
            node = node?.next
        }
        
        guard n <= nodesCount else { return nil }
        
        let nodeIndex = nodesCount - n //2
        
        for _ in 0..<nodeIndex {
            node = node?.next
        }
        
        return head
    }
    
    func instructor_findNthNode(_ head: ListNode?, _ n: Int) -> ListNode? {
        // Using two pointers
        var left = head
        var right = head
        
        for _ in 0..<n - 1 { //2
            if right == nil {
                return nil
            }
            right = right?.next //3
        }
        
        while right != nil {
            right = right?.next //4, 5
            left = left?.next //4, 3 <-
        }
        
        return left
    }
    
    //3. Reverse Linked List
    // [1,2,3,4,5] -> [5,4,3,2,1]
    func reverseList(_ head: ListNode?) -> ListNode? {
        if head?.next == nil || head == nil {
            return head
        }
        
        let p = reverseList(head?.next)
        head?.next?.next = head
        head?.next = nil
        return p
    }
    
    //4. Merge Two Sorted Lists
    // [1,2,4], [1,3,4] -> [1,1,2,3,4,4]
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        guard let l1 = l1 else { return l2 }
        guard let l2 = l2 else { return l1 }
        var result: ListNode? = nil
        
        if l1.val < l2.val {
            result = l1
            result?.next = mergeTwoLists(l1.next, l2)
        } else {
            result = l2
            result?.next = mergeTwoLists(l1, l2.next)
        }
        
        return result
    }
    
    func isPalindrome(_ head: ListNode?) -> Bool {
        //use array to make it easier
        //self solved - 132 ms - beats 21 % - runtime O(n)
        
        guard let head = head else { return false }
        
        var node: ListNode? = head
        var nodesCount = 0
        while node != nil {
            nodesCount += 1
            node = node?.next
        }
        
        node = head
        var array = [Int]()
        for _ in 0..<nodesCount {
            array.append(node!.val)
            node = node?.next
        }
        
        var firstHalf = [Int]()
        for i in 0..<nodesCount{
            firstHalf.append(array[i])
        }
        
        var mid = nodesCount/2
        if nodesCount % 2 != 0 {
            mid += 1
        }
        
        var reversedHalf = [Int]()
        for i in nodesCount/2..<nodesCount {
            reversedHalf.append(array[i])
        }
        reversedHalf = reversedHalf.reversed()
    
        return firstHalf == reversedHalf ? true: false
    }
    
    func alternative_isPalindrome(_ head: ListNode?) -> Bool {
        
        guard head != nil, head!.next != nil else { return true }
        
        var count = 0
        var l = head
        
        while l != nil {
            count += 1
            l = l!.next
        }
        
        var (l1, l2) = reverse(head, count/2)
        if count % 2 == 1 {
            l2 = l2!.next
        }
        
        while l2 != nil {
            if l1!.val != l2!.val {
                return false
            }
            l1 = l1!.next
            l2 = l2!.next
        }
        return true
    }
    
    func reverse(_ head: ListNode?, _ endNum: Int) -> (ListNode?, ListNode?) {
        guard endNum > 1 else { return (head, head!.next) }
        var count = 1
        var a = head, b = head!.next, c = head!.next!.next
        a!.next = nil
        
        while count < endNum {
            b!.next = a
            count += 1
            a = b
            b = c
            c = c!.next
        }
        return (a,b)
    }
    
    func hasCycle(_ head: ListNode?) -> Bool {
        //Floyd's cycle algorithm
        if head == nil || head?.next == nil { return false }
        
        var slowNode: ListNode? = head
        var fastNode: ListNode? = head?.next
        
       // while (slowNode != fastNode){
            if (fastNode == nil || fastNode?.next == nil){
                return false
            }
            slowNode = slowNode?.next
            fastNode = fastNode?.next?.next
        //}
        
        return true
    }
    
}



