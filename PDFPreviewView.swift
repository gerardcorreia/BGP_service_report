//
//  PDFPreviewView.swift
//  BGP_Service_Report
//
//  Created by user259062 on 6/19/24.
//
import SwiftUI
import PDFKit

struct PDFPreviewView: View {
    var pdfURL: URL
    
    var body: some View {
        PDFKitRepresentedView(url: pdfURL)
            .edgesIgnoringSafeArea(.all)
    }
}

struct PDFKitRepresentedView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {}
}
