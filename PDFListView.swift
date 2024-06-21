//
//  PDFListView.swift
//  BGP_Service_Report
//
//  Created by user259062 on 6/19/24.
//
import SwiftUI

struct PDFListView: View {
    @State private var showingForm = false
    @State private var showingPreview = false
    @State private var pdfFiles: [URL] = []
    @State private var selectedPDF: URL? = nil
    @Binding var technicianData: TechnicianData

    var body: some View {
        NavigationView {
            List {
                ForEach(pdfFiles, id: \.self) { pdfFile in
                    Button(action: {
                        selectedPDF = pdfFile
                        showingPreview = true
                    }) {
                        Text(pdfFile.lastPathComponent)
                    }
                }
                .onDelete(perform: deleteFiles)
            }
            .navigationBarItems(trailing: Button("Add Report") {
                self.showingForm = true
            })
            .onAppear(perform: loadPDFFiles)
            .sheet(isPresented: $showingPreview) {
                if let selectedPDF = selectedPDF {
                    PDFPreviewView(pdfURL: selectedPDF)
                }
            }
            .sheet(isPresented: $showingForm) {
                ReportFormView(showingForm: $showingForm, refreshFiles: loadPDFFiles, technicianData: $technicianData)
            }
        }
    }

    func loadPDFFiles() {
        let fileManager = FileManager.default
        if let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            do {
                let urls = try fileManager.contentsOfDirectory(at: documentURL, includingPropertiesForKeys: nil)
                self.pdfFiles = urls.filter { $0.pathExtension == "pdf" }
            } catch {
                print("Error loading PDF files: \(error)")
            }
        }
    }

    func deleteFiles(at offsets: IndexSet) {
        let fileManager = FileManager.default
        for index in offsets {
            do {
                try fileManager.removeItem(at: pdfFiles[index])
            } catch {
                print("Error deleting file: \(error)")
            }
        }
        pdfFiles.remove(atOffsets: offsets)
    }
}
