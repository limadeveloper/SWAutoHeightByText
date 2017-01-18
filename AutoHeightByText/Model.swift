//
//  Model.swift
//  AutoHeightByText
//
//  Created by John Lima on 18/01/17.
//  Copyright © 2017 limadeveloper. All rights reserved.
//

import Foundation

typealias DictionaryModel = Dictionary<String, [Model]>

class Model {
    
    // MARK: - Properties
    fileprivate var header: String?
    fileprivate var message: String?
    
    // MARK: - Constructor
    init() {}
    
    fileprivate init(header: String, message: String) {
        self.header = header
        self.message = message
    }
}

extension Model {
    
    // MARK: - Getters
    func getHeader() -> String? {
        return header
    }
    
    func getMessage() -> String? {
        return message
    }
    
    // MARK: - Actions
    func getData() -> [Model] {
        return [
            Model(header: "Header1Header1Header1Header1Header1Header1Header1Header1Header1Header1Header1Header1Header1", message: "Message1"),
            Model(header: "Header1Header1Header1Header1Header1Header1Header1Header1Header1Header1Header1Header1Header1", message: "Message2"),
            Model(header: "Header1Header1Header1Header1Header1Header1Header1Header1Header1Header1Header1Header1Header1", message: "Message3"),
            Model(header: "Header1Header1Header1Header1Header1Header1Header1Header1Header1Header1Header1Header1Header1", message: "Message5"),
            Model(header: "Header1Header1Header1Header1Header1Header1Header1Header1Header1Header1Header1Header1Header1", message: "Message4"),
            Model(header: "Header2", message: "Message2"),
            Model(header: "Header3", message: "Message1"),
            Model(header: "Header3", message: "Message2"),
            Model(header: "Header3", message: "Message3"),
            Model(header: "Header5", message: "Message1"),
            Model(header: "Header4Header4Header4Header4Header4Header4Header4Header4Header4Header4Header4Header4Header4Header4Header4Header4Header4Header4Header4Header4Header4Header4Header4Header4Header4Header4Header4Header4Header4Header4", message: "Message1")
        ]
    }
    
    func getDictionaryData(from: [Model]) -> (keys: [String], data: DictionaryModel?)? {
        
        var result = DictionaryModel()
        var items = [Model]()
        var previoursKey = String()
        var currentKey = String()
        var keys = [String]()
        
        if from.count > 0 {
            
            let data = from.sorted { $0.header! < $1.header! }
            
            func save() {
                if items.count > 0 {
                    for item in items {
                        if let key = item.header {
                            if keys.contains(key) {
                                result[key] = items
                                items = [Model]()
                                break
                            }
                        }
                    }
                }
            }
            
            for i in 0 ..< data.count {
                
                if let key = data[i].header {
                    
                    if currentKey != key {
                        save()
                        currentKey = key
                    }
                    
                    keys.append(key)
                    keys = Array(Set(keys))
                    
                    items.append(data[i])
                }
                
                if i == data.count-1 {
                    save()
                }
            }
        }
        
        keys = keys.sorted { $0 < $1 }
        
        if result.count > 0 {
            let sorted = result.sorted(by: { $0.0 < $1.0 })
            for (key, value) in sorted {
                result[key] = value.sorted { $0.header! < $1.header! }
            }
            return (keys, result)
        }
        
        return nil
    }
}
