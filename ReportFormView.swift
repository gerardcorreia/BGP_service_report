//
//  ReportFormView.swift
//  BGP_Service_Report
//
//  Created by user259062 on 6/19/24.
//
import SwiftUI
import PDFKit

struct ReportFormView: View {
    @Binding var showingForm: Bool
    var refreshFiles: () -> Void
    @Binding var technicianData: TechnicianData

    @State private var reportData = ReportData(
        technicianName: "", technicianNumber: "", technicianEmail: "", reportEmail: "",
        date: DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none),
        osNumber: "", client: "", address: "", clientName: "", clientPhoneNumber: "",
        intervention: "", centralCode: "", centralSN: "", centralModel: "", centralTipologia: "",
        centralTipologiaInstalacao: "", optfieldLimpeza: false, optfieldFixacao: false,
        optfieldFixTubagens: false, optfieldFugas: false, optfieldMangaEscape: false,
        optfieldVentilacao: false, optfieldCombustivel: false, optfieldNivelOleo: false,
        optfieldFugasValvAlivio: false, images: []
    )
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage? = nil

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Technician Information")) {
                    Text("Name: \(technicianData.technicianName)")
                    Text("Number: \(technicianData.technicianNumber)")
                    Text("Email: \(technicianData.technicianEmail)")
                    Text("Report Email: \(technicianData.reportEmail)")
                }
                Section(header: Text("Report Information")) {
                    TextField("Date", text: $reportData.date).disabled(true)
                    TextField("OS Number", text: $reportData.osNumber)
                    TextField("Client", text: $reportData.client)
                    TextField("Address", text: $reportData.address)
                    TextField("Client Name", text: $reportData.clientName)
                    TextField("Client Phone Number", text: $reportData.clientPhoneNumber)
                    TextField("Intervention", text: $reportData.intervention)
                    TextField("Central Code", text: $reportData.centralCode)
                    TextField("Central SN", text: $reportData.centralSN)
                    TextField("Central Model", text: $reportData.centralModel)
                    TextField("Central Tipologia", text: $reportData.centralTipologia)
                    TextField("Central Tipologia Instalacao", text: $reportData.centralTipologiaInstalacao)
                }
                Section(header: Text("Verification Fields")) {
                    Toggle("Limpeza", isOn: $reportData.optfieldLimpeza)
                    Toggle("Fixacao", isOn: $reportData.optfieldFixacao)
                    Toggle("Fix Tubagens", isOn: $reportData.optfieldFixTubagens)
                    Toggle("Fugas", isOn: $reportData.optfieldFugas)
                    Toggle("Manga Escape", isOn: $reportData.optfieldMangaEscape)
                    Toggle("Ventilacao", isOn: $reportData.optfieldVentilacao)
                    Toggle("Combustivel", isOn: $reportData.optfieldCombustivel)
                    Toggle("Nivel Oleo", isOn: $reportData.optfieldNivelOleo)
                    Toggle("Fugas Valv Alivio", isOn: $reportData.optfieldFugasValvAlivio)
                }
                Section(header: Text("Images")) {
                    Button("Add Image") {
                        showImagePicker = true
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(image: $selectedImage)
                            .onDisappear {
                                if let selectedImage = selectedImage {
                                    reportData.images.append(selectedImage)
                                }
                            }
                    }
                    ForEach(reportData.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                    }
                }
                Button("Generate PDF") {
                    generatePDF()
                }
            }
            .navigationBarItems(leading: Button("Cancel") {
                showingForm = false
            }, trailing: Button("Done") {
                showingForm = false
                refreshFiles()
            })
        }
        .onAppear {
            updateReportDataWithTechnicianData()
        }
    }

    func updateReportDataWithTechnicianData() {
        reportData.technicianName = technicianData.technicianName
        reportData.technicianNumber = technicianData.technicianNumber
        reportData.technicianEmail = technicianData.technicianEmail
        reportData.reportEmail = technicianData.reportEmail
    }

    func generatePDF() {
        guard let document = loadPDF(named: "Incêndio_reportview_teste_v4") else { return }
        populatePDF(document: document, with: reportData)
        if let url = savePDF(document: document, with: "Report_\(reportData.osNumber).pdf") {
            DispatchQueue.main.async {
                sharePDF(at: url)
            }
        }
    }
}
