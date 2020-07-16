//
//  IQ-Trees.swift
//  AlgorithmsWorskhop
//
//  Created by Hem Poudyal on 7/14/20.
//  Copyright © 2020 Hem Poudyal. All rights reserved.
//

import Foundation
import UIKit

class IQ_Trees: BaseViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trees"
        
        objectList = [Objects(key: "Easy Category",
                              objects: ["Maximum Depth of Binary",
                                        "Validate Binary Search Tree",
                                        "Symmetric Tree",
                                        "Binary Tree Level Order Traversal",
                                        "Converted Sorted Array to Binary Search Tree"])
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
                break
                
            default:
                break
            }
            
        default:
            break
        }
    }
    
}

extension IQ_Trees {
    public class TreeNode {
         public var val: Int
         public var left: TreeNode?
         public var right: TreeNode?
         public init() { self.val = 0; self.left = nil; self.right = nil; }
         public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
         public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
             self.val = val
             self.left = left
             self.right = right
         }
     }
    
    //1. Max Depth of a Tree
    func maxDepth(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        
        return 1 + max(maxDepth(root.left), maxDepth(root.right))
    }
    
    //2. Valid Binary Tree
    //USing Recursion
    func isValidBST(_ root: TreeNode?) -> Bool {
        guard let root = root else { return false }
       
        return isBSTHelper(root, Int.min, Int.max)
    }
    
    func isBSTHelper(_ node: TreeNode?, _ lowerLimit: Int, _ upperLimit: Int) -> Bool {
        guard let node = node else { return true }
        
        if node.val <= lowerLimit || upperLimit <= node.val{
            return false
        }
        
        return isBSTHelper(node.left, lowerLimit, node.val) && isBSTHelper(node.right, node.val, upperLimit)
    }
    
    //In Order Traversal
    
    func isValidBST1(_ treeNode: TreeNode?) -> Bool {
           var array = [Int]()
           inOrderTraversal(treeNode, array: &array)

           if array.count < 2 {
               return true
           }

           for i in 1 ..< array.count {
               if array[i] <= array[i - 1] {
                   return false
               }
           }

           return true
       }

       func inOrderTraversal(_ treeNode: TreeNode?, array: inout [Int]) {
           guard let treeNode = treeNode else {
               return
           }

           inOrderTraversal(treeNode.left, array: &array)
           array.append(treeNode.val)
           inOrderTraversal(treeNode.right, array: &array)
       }
    
    //3. Symmetric Tree
    func isSymmetric(_ root: TreeNode?) -> Bool {
        
        return isMirror(t1: root, t2: root)
    }
    
    func isMirror(t1: TreeNode?, t2: TreeNode?) -> Bool {
        if t1 == nil && t2 == nil { return true }
        if t1 == nil || t2 == nil { return false }
        
        return t1?.val == t2?.val && isMirror(t1: t1?.right, t2: t2?.left) && isMirror(t1: t1?.left, t2: t2?.right)
    }
    
  /*  func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else { return [] }
        
        var arr = [[Int]]()
        var level = [Int]()
        if root.left?.val != nil {
            level.append(root.left!.val)
        }
        
        if root.right?.val != nil {
            level.append(root.right!.val)
        }
        
        arr.append(level)
        
        arr = levelOrder(root.left)
        arr = levelOrder(root.right)
        
        return arr
    } */
    
    //4. Binary Tree Level order Traversal
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else { return [] }
        
        var q = [TreeNode](), lists = [[Int]]()
        q.append(root)
        
        while !q.isEmpty {
            lists.append(q.map{ $0.val })
            
            q = q.reduce([]) {l, t in
                l + [t.left, t.right]
            }.compactMap({$0})
            
        }
        return lists
    }
    
    func better_LevelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else { return [] }
        
        var arr = [[Int]]()
        helper(root, 0, &arr)
        
        return arr
    }
    
    func helper(_ node: TreeNode?, _ level: Int, _ arr: inout [[Int]]){
        if let node = node {
            if arr.count == level {
                arr.append([])
            }
            arr[level].append(node.val)
            helper(node.left, level + 1, &arr)
            helper(node.right, level + 1, &arr)
        }
    }
   
    //5. Convert Sorted Array to Binary Search Tree (BST)
    //[-10,-3,0,5,9] -> [0,-3,9,-10,null,5]
    
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        if nums.count == 0 { return nil }
                  
        return constructBST(nums, 0, nums.count - 1)
    }
    
    private func constructBST( _ nums: [Int], _ left: Int, _ right: Int) -> TreeNode?{
        if (left > right) {
            return nil
        }
        
        let mid = left + (right - left)/2
        let node: TreeNode? = TreeNode(nums[mid])
        node?.left = constructBST(nums, left, mid - 1)
        node?.right = constructBST(nums, mid + 1, right)
        return node
        
    }
    
}
