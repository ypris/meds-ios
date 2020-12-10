//
//  MedicineDetailView.swift
//  meds
//
//  Created by Yohana Priscillia on 06/12/20.
//

import SwiftUI
import Combine

// MedicineDetailView handles the FE to view medicine details
// Also include form to add and update details
struct MedicineDetailView: View {
    static let STATE_ADD = "add"
    static let STATE_UPDATE = "update"
    
    init(medObs: MedicineObsevable) {
        self.state = MedicineDetailView.STATE_ADD
        self._medicine = State(initialValue: Medicine.initEmpty())
        self.medObs = medObs
    }
    
    init(_ medicine: Medicine, medObs: MedicineObsevable) {
        self.state = MedicineDetailView.STATE_UPDATE
        self._medicine = State(initialValue: medicine)
        self.medObs = medObs
    }
    
    var state: String
    @State private var medicine: Medicine
    @ObservedObject var medObs: MedicineObsevable
    @Environment(\.presentationMode) var presentationMode
    
    private var isAddNewRecord: Bool {
        self.state == MedicineDetailView.STATE_ADD
    }
    
    var body: some View {
        Form {
            formSectionGeneral
            
            formSectionPrescription
            
            formSectionStock
        }
        .navigationBarTitle(
            Text(self.isAddNewRecord ? "Add New Medicine" : "Update Medicine"),
            displayMode: .inline
        )
        .navigationBarItems(
            trailing: Button(
                "Save",
                action: {
                    self.validate()
                    self.onSave()
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
        )
    }
    
    private func validate() {
        // @todo validates whether user input mandatory fields before save
    }
    
    private func onSave() {
        print(self.medicine)
        if self.isAddNewRecord {
            self.medicine.status = .active
            self.medObs.addOne(self.medicine)
        } else {
            self.medObs.update(self.medicine)
        }
    }
}

extension MedicineDetailView {
    var formSectionGeneral: some View {
        Section(header: Text("General")) {
            HStack {
                Text("Name")
                                
                TextField("", text: self.$medicine.name)
            }
            
            HStack {
                Text("Dosage")
                                
                TextField("X mg", text: self.$medicine.dosage)
            }
            
            HStack {
                Text("Function")
                                
                TextField("diabetes, cholesterol, etc.", text: self.$medicine.usage)
            }
            
            if self.state != MedicineDetailView.STATE_ADD {
                Picker("Status", selection: self.$medicine.status) {
                    ForEach(Status.allCases, id: \.self) { option in
                        Text(option.displayName)
                            .tag(option)
                    }
                }
            }
        }
    }
    
    var formSectionPrescription: some View {
        Section(header: Text("Doctor's Prescription")) {
            HStack {
                Image(systemName: "cloud.sun")
                
                TextFieldDecimalOptional(
                    title: "Morning",
                    text: self.$medicine.prescription.morning
                )
                
                Image(systemName: "sun.max")
                
                TextFieldDecimalOptional(
                    title: "Afternoon",
                    text: self.$medicine.prescription.afternoon
                )
            }
            
            HStack {
                Image(systemName: "moon.fill")
                
                TextFieldDecimalOptional(
                    title: "Evening",
                    text: self.$medicine.prescription.evening
                )
                
                Image(systemName: "moon.zzz.fill")
                
                TextFieldDecimalOptional(
                    title: "Night",
                    text: self.$medicine.prescription.night
                )
            }
            
            Toggle("After Meal", isOn: self.$medicine.prescription.afterMeal)
            
            HStack {
                Text("Repeat every")
                                
                TextFieldNumeric(
                    title: "x number of",
                    text: self.$medicine.prescription.repeatInDays
                )
                
                Text("day(s)")
            }
            
            DatePicker("Upcoming Intake", selection: self.$medicine.nextTakenTs, displayedComponents: .date)
        }
    }
    
    var formSectionStock: some View {
        Section(header: Text("Stock")) {
            HStack {
                Text("Current Quantity")
                                
                TextFieldDecimal(
                    title: "",
                    text: self.$medicine.stock.quantity
                )
            }
            
            HStack {
                Text("Sold in")
                
                TextField("strip/box/etc.", text: self.$medicine.stock.type)
                
                if medicine.stock.type != ""
                {
                    Text("|")
                    
                    TextFieldNumeric(
                        title: "",
                        text: self.$medicine.stock.qtyPerType
                    )
                    
                    Text("tablets per \(medicine.stock.type)")
                }
            }
        }
    }
}

struct MedicineDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineDetailView(medObs: MedicineObsevable())
    }
}
