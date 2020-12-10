//
//  MedicineRowView.swift
//  meds
//
//  Created by Yohana Priscillia on 06/12/20.
//

import SwiftUI

// MedicineRowView handles the FE for each row of MedicineListView
struct MedicineRowView: View {
    var medicine: Medicine
    
    private var hasMorningDosage: Bool {
        medicine.prescription.morning != nil &&
        medicine.prescription.morning != 0
    }
    
    private var hasAfternoonDosage: Bool {
        medicine.prescription.afternoon != nil &&
        medicine.prescription.afternoon != 0
    }
    
    private var hasEveningDosage: Bool {
        medicine.prescription.evening != nil &&
        medicine.prescription.evening != 0
    }
    
    private var hasNightDosage: Bool {
        medicine.prescription.night != nil &&
        medicine.prescription.night != 0
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(medicine.name)
                .bold()
            +
            Text(" \(medicine.dosage)")
                .font(.footnote)
            +
            Text(" (" + medicine.usage + ")")
                .italic()
                .foregroundColor(.gray)
                .font(.footnote)
            
            HStack(spacing: 10) {
                if hasMorningDosage {
                    HStack(spacing: 2) {
                        Text("\(medicine.prescription.morning!, specifier: "%.1f")")
                        
                        Image(systemName: "cloud.sun")
                    }
                }
                
                if hasAfternoonDosage {
                    HStack(spacing: 2) {
                        Text("\(medicine.prescription.afternoon!, specifier: "%.1f")")
                        
                        Image(systemName: "sun.max")
                    }
                }
                
                if hasEveningDosage {
                    HStack(spacing: 2) {
                        Text("\(medicine.prescription.evening!, specifier: "%.1f")")
                        
                        Image(systemName: "moon.fill")
                    }
                }
                
                if hasNightDosage {
                    HStack(spacing: 2) {
                        Text("\(medicine.prescription.night!, specifier: "%.1f")")
                        
                        Image(systemName: "moon.zzz.fill")
                    }
                }
            }
        }
    }
}

struct MedicineRowView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineRowView(medicine: Medicine(name: "Glucophage XR", usage: "Diabetes", dosage: "750mg", status: .active, prescription: Prescription(morning: 1, evening: 1), nextTakenTs: Date(), stock: Stock(quantity: 20, type: "Strip", qtyPerType: 10)))
    }
}
