//
//  APIClient.swift
//  WeinShop_Swift
//
//  Created by Jennifer Hedtke on 17.10.22.
//

import Foundation
import UIKit

struct APIClient {
    
    let urlString = "https://public.syntax-institut.de/apps/JenniferHedtke/data.json"
    
    //MARK: - Winelist
    
    func getWineList(completion: @escaping([Wine]) -> Void) {
        //URL definieren
        let url = URL(string: urlString)
        guard url != nil else { return }
        
        //URL Session undDatatask
        let dataTask = URLSession.shared.dataTask(with: url!) { data, response, error in
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                
                do {
                    let wine = try decoder.decode([Wine].self, from: data!)
                    completion(wine)
                } catch {
                    print("Error by loading Winelist")
                }
            }
        }
        dataTask.resume()
    }
    
    //MARK: - Image
    
    func getImage(imageUrl: URL, completion: @escaping(UIImage) -> Void) {
        //URL Session und Downloadtask
        let downloadTask = URLSession.shared.downloadTask(with: imageUrl) { localUrl, urlResponse, error in
            let image = UIImage(data: try! Data(contentsOf: localUrl!))
            completion(image!)
        }
        downloadTask.resume()
    }
}
