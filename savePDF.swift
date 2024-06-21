//
//  savePDF.swift
//  BGP_Service_Report
//
//  Created by user259062 on 6/19/24.
import PDFKit
import UIKit

func savePDF(document: PDFDocument, with fileName: String) -> URL? {
    let fileManager = FileManager.default
    guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName) else { return nil }
    document.write(to: url)
    return url
}

func sharePDF(at url: URL) {
    let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
    if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
       let rootViewController = scene.windows.first?.rootViewController {
        if let popoverController = activityVC.popoverPresentationController {
            popoverController.sourceView = rootViewController.view
            popoverController.sourceRect = CGRect(x: rootViewController.view.bounds.midX, y: rootViewController.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        rootViewController.present(activityVC, animated: true, completion: nil)
    }
}
