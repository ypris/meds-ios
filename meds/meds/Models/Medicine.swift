//
//  medicine.swift
//  meds
//
//  Created by Yohana Priscillia on 06/12/20.
//

import Foundation

// Medicine represent a medicine
struct Medicine: Hashable, Codable {
    var name: String
    var usage: String
    var dosage: String
    var status: Status
    var prescription: Prescription
    var nextTakenTs: Date
    var stock: Stock
    
    static func initEmpty() -> Medicine {
        return Medicine(
            name: "",
            usage: "",
            dosage: "",
            status: .inactive,
            prescription: Prescription(),
            nextTakenTs: Date(),
            stock: Stock(quantity: 0, type: "", qtyPerType: 0)
        )
    }
}

// Status is the medicine status
enum Status: Int, CaseIterable, Codable {
    case active = 0
    case inactive = 1
    case onHold = 2
    
    // @todo make localized https://developer.apple.com/forums/thread/126706
    var displayName: String {
        switch self {
        case .active:
            return "Active"
        case .inactive:
            return "Stopped"
        case .onHold:
            return "On Hold"
        }
    }
}

// Prescription repesent the doctor's prescription
struct Prescription: Hashable, Codable {
    init(
        morning: Float? = nil,
        afternoon: Float? = nil,
        evening: Float? = nil,
        night: Float? = nil,
        afterMeal: Bool = true,
        repeatInDays: Int = 1
    ) {
        self.morning = morning
        self.afternoon = afternoon
        self.evening = evening
        self.night = night
        self.afterMeal = afterMeal
        self.repeatInDays = repeatInDays
    }
    
    var morning: Float?
    var afternoon: Float?
    var evening: Float?
    var night: Float? // i.e., before bed
    var afterMeal: Bool
    var repeatInDays: Int // e.g., taken every 2 days
}

// Stock represent the medicine stock
struct Stock: Hashable, Codable {
    var quantity: Float
    var type: String // e,g, strip, box, etc.
    var qtyPerType: Int
}
