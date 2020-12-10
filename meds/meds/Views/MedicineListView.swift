//
//  MedicineListView.swift
//  meds
//
//  Created by Yohana Priscillia on 06/12/20.
//

import SwiftUI

// MedicineListView handles the FE for showing list of all medicines
struct MedicineListView: View {
    @ObservedObject var medObs: MedicineObsevable
    
    var body: some View {
        NavigationView {
            List(medObs.medicines, id: \.self) { med in
                NavigationLink(destination: MedicineDetailView(med, medObs: self.medObs)) {
                    MedicineRowView(medicine: med)
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle(Text("Medicine List"), displayMode: .inline)
            .navigationBarItems(trailing: NavigationLink(
                destination: MedicineDetailView(medObs: self.medObs),
                label: {
                    Text("New")
                }
            ))
        }
    }
}

struct MedicineListView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineListView(medObs: MedicineObsevable())
    }
}
