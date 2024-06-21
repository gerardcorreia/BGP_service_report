//
//  TechnicianFormView.swift
//  BGP_Service_Report
//
//  Created by user259062 on 6/19/24.
//
import SwiftUI

struct TechnicianFormView: View {
    @Binding var technicianData: TechnicianData
    @Binding var showingTechnicianForm: Bool

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Technician Information")) {
                    TextField("Name", text: $technicianData.technicianName)
                        .onChange(of: technicianData.technicianName) { newValue in
                            technicianData.technicianName = newValue.lowercased()
                        }
                    TextField("Number", text: $technicianData.technicianNumber)
                        .onChange(of: technicianData.technicianNumber) { newValue in
                            technicianData.technicianNumber = newValue.lowercased()
                        }
                    TextField("Email", text: $technicianData.technicianEmail)
                        .onChange(of: technicianData.technicianEmail) { newValue in
                            technicianData.technicianEmail = newValue.lowercased()
                        }
                    TextField("Report Email", text: $technicianData.reportEmail)
                        .onChange(of: technicianData.reportEmail) { newValue in
                            technicianData.reportEmail = newValue.lowercased()
                        }
                }
            }
            .navigationBarItems(leading: Button("Cancel") {
                showingTechnicianForm = false
            }, trailing: Button("Save") {
                saveTechnicianData()
                showingTechnicianForm = false
            })
        }
    }

    func saveTechnicianData() {
        if let encoded = try? JSONEncoder().encode(technicianData) {
            UserDefaults.standard.set(encoded, forKey: "TechnicianData")
        }
    }
}
