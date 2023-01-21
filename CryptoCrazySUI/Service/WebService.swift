//
//  WebService.swift
//  CryptoCrazySUI
//
//  Created by Eyüp Tüylü on 21.01.2023.
//

import Foundation

class WebService {
    
    /*
    func downloadCurrenciesAsync(url:URL) async throws -> [CryptoCurrency] {
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let currencies  = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
        
        return currencies ?? []
    }
    */
    
    func downloadCurrenciesContinuation(url: URL) async throws -> [CryptoCurrency] {
        try await withCheckedThrowingContinuation({ continuation in
            
            downloadCurrencies(url: url){ result in
                switch result {
                case .success(let cryptos):
                    continuation.resume(returning: cryptos ?? [])
                case .failure(let error):
                    continuation.resume(throwing: error)
                    
                }
            }
            
            
        })
    }
    
    
    
    
    // ESKİ YÖNTEM
    // Escaping bu işlem uzun sürecek diyoruz. İş tamamlanınca bana şunu ver demiş oluyoruz.
    
    func downloadCurrencies(url: URL, completion : @escaping(Result<[CryptoCurrency]?,DownloaderError>) -> Void){
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.badUlr))
            }
            
            guard let data = data, error == nil else{
                return completion(.failure(.noData))
            }
            
            guard let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data) else{
                return completion(.failure(.dataParseError))
            }
            completion(.success(currencies))
        }.resume()
    }
    
    
    
    
    
    
    
}


enum DownloaderError : Error{
    case badUlr
    case noData
    case dataParseError
}
