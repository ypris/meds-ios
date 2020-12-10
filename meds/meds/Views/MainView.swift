//
//  ContentView.swift
//  meds
//
//  Created by Yohana Priscillia on 06/12/20.
//

import SwiftUI

// MainView handles the app main view
struct MainView: View {
    @ObservedObject var medObs = MedicineObsevable()
    @State private var selectedIdx = 0
    
    var body: some View {
        TabView(selection: $selectedIdx) {
            HomeView(medObs: self.medObs)
                .tabItem {
                    Image(systemName: "square.stack.3d.up.fill")
                    Text("Prep")
                }
                .tag(0)
            
            MedicineListView(medObs: self.medObs)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("All")
                }
                .tag(1)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
