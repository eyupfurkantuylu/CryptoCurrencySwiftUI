//
//  ContentView.swift
//  CryptoCrazySUI
//
//  Created by Eyüp Tüylü on 21.01.2023.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var cryptoListViewModel : CryptoListViewModel
    
    init(){
        self.cryptoListViewModel = CryptoListViewModel()
    }
    
    var body: some View {
       
        NavigationView {
            
            List(cryptoListViewModel.cryptoList, id:\.id) { crypto in
                VStack{
                    Text(crypto.currency)
                        .font(.title3)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(crypto.price)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }.toolbar(content: {
                Button {
                    //button clicked
                    Task.init {
                        
                        await cryptoListViewModel.downloadCryptosContuniuation(url: URL( string:"https://raw.githubusercontent.com/atilsamancioglu/k21-JSONDataSet/master/crypto.json")!)
                    
                    }
                    
                    
                    
                } label: {
                    Text("Refresh")
                }

            })
            
            
            
            .navigationTitle(Text("Crypto Crazy"))
        }.task {
            await cryptoListViewModel.downloadCryptosContuniuation(url: URL( string:"https://raw.githubusercontent.com/atilsamancioglu/k21-JSONDataSet/master/crypto.json")!)
            
            /*
            cryptoListViewModel.downloadCryptosAsync(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/k21-JSONDataSet/master/crypto.json")!)
             */
        }
        /*
        .onAppear{
           
            
            
            
            
            /*
            cryptoListViewModel.downloadCryptos(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/k21-JSONDataSet/master/crypto.json")!)
             */
        }
         */
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
