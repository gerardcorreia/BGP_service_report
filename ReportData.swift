//
//  ReportData.swift
//  BGP_Service_Report
//
//  Created by user259062 on 6/19/24.
//
import Foundation
import SwiftUI

struct ReportData {
    var technicianName: String
    var technicianNumber: String
    var technicianEmail: String
    var reportEmail: String
    var date: String
    var osNumber: String
    var client: String
    var address: String
    var clientName: String
    var clientPhoneNumber: String
    var intervention: String
    var centralCode: String
    var centralSN: String
    var centralModel: String
    var centralTipologia: String
    var centralTipologiaInstalacao: String
    var optfieldLimpeza: Bool
    var optfieldFixacao: Bool
    var optfieldFixTubagens: Bool
    var optfieldFugas: Bool
    var optfieldMangaEscape: Bool
    var optfieldVentilacao: Bool
    var optfieldCombustivel: Bool
    var optfieldNivelOleo: Bool
    var optfieldFugasValvAlivio: Bool
    var images: [UIImage]
}
