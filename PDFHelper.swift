//
//  PDFHelper.swift
//  BGP_Service_Report
//
//  Created by user259062 on 6/20/24.
//
import PDFKit
import UIKit

func loadPDF(named: String) -> PDFDocument? {
    guard let path = Bundle.main.path(forResource: named, ofType: "pdf") else { return nil }
    let url = URL(fileURLWithPath: path)
    return PDFDocument(url: url)
}

func populatePDF(document: PDFDocument, with data: ReportData) {
    guard let page = document.page(at: 0) else { return }

    page.annotations.forEach { annotation in
        switch annotation.fieldName {
        case "txtfield_technician_name":
            annotation.contents = data.technicianName
        case "txtfield_technician_employee_number":
            annotation.contents = data.technicianNumber
        case "txtfield_technician_email":
            annotation.contents = data.technicianEmail
        case "txtfield_date":
            annotation.contents = data.date
        case "txtfield_OSnumber":
            annotation.contents = data.osNumber
        case "txtfield_client":
            annotation.contents = data.client
        case "txtfield_address":
            annotation.contents = data.address
        case "txtfield_clientname":
            annotation.contents = data.clientName
        case "txtfield_client_phonenumber":
            annotation.contents = data.clientPhoneNumber
        case "txtfield_intervention":
            annotation.contents = data.intervention
        case "txtfield_centralcod":
            annotation.contents = data.centralCode
        case "txtfield_centralsn":
            annotation.contents = data.centralSN
        case "txtfield_centralmodel":
            annotation.contents = data.centralModel
        case "txtfield_central_tipologia":
            annotation.contents = data.centralTipologia
        case "txtfield_central_tipologia_instalacao":
            annotation.contents = data.centralTipologiaInstalacao
        case "optfield_limpeza":
            annotation.contents = data.optfieldLimpeza ? "Ok" : "Nok"
        case "optfield_fixacao":
            annotation.contents = data.optfieldFixacao ? "Ok" : "Nok"
        case "optfield_fix_tubagens":
            annotation.contents = data.optfieldFixTubagens ? "Ok" : "Nok"
        case "optfield_fugas":
            annotation.contents = data.optfieldFugas ? "Ok" : "Nok"
        case "optfield_manga_escape":
            annotation.contents = data.optfieldMangaEscape ? "Ok" : "Nok"
        case "optfield_ventilacao":
            annotation.contents = data.optfieldVentilacao ? "Ok" : "Nok"
        case "optfield_combustivel":
            annotation.contents = data.optfieldCombustivel ? "Ok" : "Nok"
        case "optfield_nivel_oleo":
            annotation.contents = data.optfieldNivelOleo ? "Ok" : "Nok"
        case "optfield_fugas_valv_alivio":
            annotation.contents = data.optfieldFugasValvAlivio ? "Ok" : "Nok"
        default:
            break
        }
    }
    
    // Handle image insertion
    for (index, image) in data.images.enumerated() {
        let annotationName = "image_box_\(index + 1)"
        if let annotation = page.annotations.first(where: { $0.fieldName == annotationName }) {
            let imageData = image.jpegData(compressionQuality: 1.0)
            if let imageData = imageData,
               let imageStream = CGDataProvider(data: imageData as CFData),
               let cgImage = CGImage(jpegDataProviderSource: imageStream, decode: nil, shouldInterpolate: true, intent: .defaultIntent) {
                draw(image: cgImage, in: annotation.bounds, on: page)
            }
        }
    }
}

func draw(image: CGImage, in rect: CGRect, on page: PDFPage) {
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()!
    context.draw(image, in: rect)
    let drawnImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    page.draw(with: .mediaBox, to: context)
    drawnImage?.draw(in: rect)
}
