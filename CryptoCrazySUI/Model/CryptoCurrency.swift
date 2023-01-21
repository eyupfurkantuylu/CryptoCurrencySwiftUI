//
//  CryptoCurrency.swift
//  CryptoCrazySUI
//
//  Created by Eyüp Tüylü on 21.01.2023.
//

import Foundation

struct CryptoCurrency : Hashable, Decodable, Identifiable{
    
    let id = UUID()
    let currency : String
    let price : String
    
    // Dışarıdan veriler nasıl geleceğini bildiriyoruz
    private enum CodingKeys : String, CodingKey{
        case currency = "currency"
        case price = "price"
        
    }
    
}
