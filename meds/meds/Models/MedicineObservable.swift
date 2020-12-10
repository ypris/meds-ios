//
//  MedicineObservable.swift
//  meds
//
//  Created by Yohana Priscillia on 06/12/20.
//

import Foundation

// MedicineObsevable is the view model for medicine
class MedicineObsevable: ObservableObject {
    static let SAVED_FILE = "MedsList.json"
    
    @Published var medicines: [Medicine] = []
    
    init() {
        loadMedicines()
    }
    
    // loadMedicines retrieves all meds from saved file
    private func loadMedicines() {
        self.medicines = Repository.load(MedicineObsevable.SAVED_FILE)
    }
    
    // addOne insert 1 new med record to saved file
    func addOne(_ med: Medicine) {
        self.medicines.append(med)
        Repository.save(self.medicines, to: MedicineObsevable.SAVED_FILE)
    }
    
    // update updates 1 med record to saved file
    func update(_ med: Medicine) {
        if let idx = self.medicines.firstIndex(where: {$0.name == med.name}) {
            self.medicines[idx] = med
        }
        
        Repository.save(self.medicines, to: MedicineObsevable.SAVED_FILE)
    }
    
    // updateNextIntakeDate updates the meds next intake date
    func updateNextIntakeDate(_ meds: [Medicine], from selectedDate: Date) {
        for med in meds {
            var dateComponents = DateComponents()
            dateComponents.day = med.prescription.repeatInDays
            
            let nextIntakeDate = Calendar.current.date(byAdding: dateComponents, to: selectedDate)
            
            if let idx = self.medicines.firstIndex(where: {$0.name == med.name}),
               let nextTakenTs = nextIntakeDate {
                self.medicines[idx].nextTakenTs = nextTakenTs
            }
        }
        
        Repository.save(self.medicines, to: MedicineObsevable.SAVED_FILE)
    }
    
    // filterByIntakeDate filters medicines that intake date is specified
    func filterByIntakeDate(_ date: Date) -> [Medicine] {
        var result: [Medicine] = []
        
        for med in self.medicines {
            guard med.status == .active else {
                continue
            }
            
            let numOfDays  = Calendar.current.dateComponents([.day], from: med.nextTakenTs, to: date).day            
            
            if let numberOfDays = numOfDays, numberOfDays.isMultiple(of: med.prescription.repeatInDays) {
                result.append(med)
            }
        }
        
        return result
    }
}
