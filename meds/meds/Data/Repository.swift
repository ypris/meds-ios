//
//  Repository.swift
//  meds
//
//  Created by Yohana Priscillia on 07/12/20.
//

import Foundation

class Repository {
    // loadFromBundle retrieves data from json file in bundle (e.g., for dummy data)
    private static func loadFromBundle(_ filename: String) -> Data {
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            return try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
    }
    
    // convertToLocal create a copy of the file in bundle so it's writeable
    private static func convertToLocal(_ filename: String) -> URL {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("Directory not found in application bundle.")
        }
        
        let fileURL = directory.appendingPathComponent(filename)
        
        if (try? fileURL.checkResourceIsReachable()) == nil {
            // File does not exist, create a write-able copy
            do {
                let originalData = loadFromBundle(filename)
                try originalData.write(to: fileURL, options: .atomic)
            } catch {
                fatalError("Couldn't create file \(filename) from main bundle:\n\(error)")
            }
        } else {
            // File exist, do nothing
        }
        
        return fileURL
    }
    
    static func load<T: Decodable>(_ filename: String) -> T {
        let data: Data
        let file = convertToLocal(filename)
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
    static func save<T: Encodable>(_ objects: T, to filename: String) {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("Directory not found in application bundle.")
        }
        
        let path = directory.appendingPathComponent(filename)
        
        guard let data = try? JSONEncoder().encode(objects) else {
            fatalError("Couldn't encode JSON objects from \(T.self).")
        }
        
        do {
            try data.write(to: path, options: .atomic)
            print("Data written:\n\(String(decoding: data, as: UTF8.self))")
        } catch {
            fatalError("Couldn't write data to \(path):\n\(error)")
        }
    }
}
