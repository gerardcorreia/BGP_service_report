//
//  ContentView.swift
//  BGP_Service_Report
//
//  Created by user259062 on 6/20/24.
//
import SwiftUI

struct ContentView: View {
    @State private var showingTechnicianForm = false
    @State private var technicianData = TechnicianData(technicianName: "", technicianNumber: "", technicianEmail: "", reportEmail: "")

    var body: some View {
        NavigationView {
            VStack {
                Button("Edit Technician Data") {
                    showingTechnicianForm = true
                }
                .sheet(isPresented: $showingTechnicianForm) {
                    TechnicianFormView(technicianData: $technicianData, showingTechnicianForm: $showingTechnicianForm)
                        .onAppear(perform: loadTechnicianData)
                }
                
                NavigationLink(destination: PDFListView(technicianData: $technicianData)) {
                    Text("Manage Reports")
                }
                .padding()
            }
            .onAppear(perform: loadTechnicianData)
        }
    }

    func loadTechnicianData() {
        if let savedData = UserDefaults.standard.data(forKey: "TechnicianData"),
           let decodedData = try? JSONDecoder().decode(TechnicianData.self, from: savedData) {
            technicianData = decodedData
        }
    }
}
