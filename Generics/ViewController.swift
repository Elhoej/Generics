//
//  ViewController.swift
//  Generics
//
//  Created by Simon Elhoej Steinmejer on 04/09/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

struct CountedSet<Element: Hashable>
{
    private(set) var dictionary = [Element : Int]()
    private(set) var isEmpty: Bool = true
    private var count = 0
    
    mutating func insert(_ element: Element)
    {
        dictionary[element] = count
        count += 1
        isEmpty = false
    }
    
    mutating func remove(_ element: Element) -> Int?
    {
        if dictionary[element] != nil
        {
            let temp = dictionary[element]
            dictionary[element] = nil
            count -= 1
            if count < 1
            {
                isEmpty = true
            }
            return temp
        }
        return nil
    }
    
    func contains(_ element: Element) -> Bool
    {
        for (key, _) in dictionary
        {
            if key == element
            {
                return true
            }
        }
        return false
    }
    
}

extension CountedSet: ExpressibleByArrayLiteral
{
    init(arrayLiteral: Element...)
    {
        for element in arrayLiteral
        {
            dictionary[element] = count
            count += 1
        }
    }
}

extension CountedSet
{
    func `subscript`(_ element: Element) -> Int
    {
        return self.dictionary[element] != nil ? dictionary[element]! : 0
    }
    
    func uniqueCount() -> Int
    {
        var unique = [Element]()

        for (key, _) in self.dictionary
        {
            if !unique.contains(key)
            {
                unique.append(key)
            }
        }
        
        return unique.count
    }
}


class ViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        var countedSet: CountedSet<String> = CountedSet()
        countedSet.insert("hej")
        print("dictionary: \(countedSet.dictionary)")
        countedSet.insert("lol")
        print("dictionary: \(countedSet.dictionary)")
        countedSet.insert("bye")
        countedSet.insert("bye")
        print("dictionary: \(countedSet.dictionary)")
        print("removed \"lol\" at: \(countedSet.remove("lol") ?? 0)")
        print("subscript hej: \(countedSet.subscript("hej"))")
        print("unique count: \(countedSet.uniqueCount())")
        
        var anotherCountedSet: CountedSet = ["hej", "haha", "hej", "lol", "hej"]
        print(anotherCountedSet.remove("hej") ?? 0)
        print(anotherCountedSet.uniqueCount())
        print(anotherCountedSet.remove("hej") ?? 0)
        
    }




}

