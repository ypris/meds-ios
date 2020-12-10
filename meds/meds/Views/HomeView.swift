//
//  HomeView.swift
//  meds
//
//  Created by Yohana Priscillia on 07/12/20.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var medObs: MedicineObsevable
    @State private var medsToPrep: [Medicine] = []
    @State private var selectedDate: Date = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker(
                    "For date: ",
                    selection: Binding<Date>(
                        get: { self.selectedDate },
                        set: {
                            self.selectedDate = $0
                            self.medsToPrep = self.medObs.filterByIntakeDate(selectedDate)
                        }
                    ),
                    in: Date()...,
                    displayedComponents: .date
                )
                .padding(20)
                
                List(medsToPrep, id: \.self) { med in
                    NavigationLink(destination: MedicineDetailView(med, medObs: self.medObs)) {
                        MedicineRowView(medicine: med)
                    }
                }
                .listStyle(PlainListStyle())
                
                ButtonPrimary(
                    label: "Prep Done",
                    action: {
                        self.medObs.updateNextIntakeDate(self.medsToPrep, from: self.selectedDate)
                    }
                )
                .padding([.horizontal, .bottom], 20)
            }
            .navigationBarTitle(Text("Meds Preparation"), displayMode: .inline)
        }
        .onAppear() {
            self.medsToPrep = self.medObs.filterByIntakeDate(selectedDate)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(medObs: MedicineObsevable())
    }
}
