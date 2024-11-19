//
//  ExchangeRatesView.swift
//  Tymex Currency Converter
//
//  Created by HUY TON on 16/11/24.
//

import SwiftUI
import Charts

struct ExchangeRatesView: View {
    
    @ObservedObject var exchangeRateVM: ExchangeRatesViewModel
    @Environment(\.dismiss) private var dismiss
    

    var currencies: [Currency] {
        exchangeRateVM.sortedCurrencies
    }
    
    var body: some View {
        GeometryReader { geo in
        
            VStack {
                
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    Text("Exchange Rate compared to \(exchangeRateVM.baseCurrency)")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.brandTint)
                    Spacer()
                }
               
                Spacer()
                
                HStack {
                    Spacer()
                    HStack {
                        Text("Sort by: ").font(.headline)
                        Button {
                            exchangeRateVM.showLowestRate.toggle()
                        } label: {
                            Image(systemName: exchangeRateVM.showLowestRate ? "arrowshape.up.fill" : "arrowshape.down.fill")
                                .symbolEffect(.bounce, value: exchangeRateVM.showLowestRate)
                        }
                    }
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 15))
                }
                Chart {
                    ForEach(0...4, id: \.self) { index in
                        BarMark(x: .value("Currency", currencies[index].name), y: .value("", currencies[index].value))
                            .foregroundStyle(.brandTint)
                            .annotation {
                                Text(String(format: "%.1f", currencies[index].value))
                                    .font(.caption)
                            }
                    }
                }
                .animation(.easeInOut, value: exchangeRateVM.showLowestRate)
                .frame(height: geo.size.height * 0.6)
                .padding(.bottom)
                
            }
            .padding()
        }
        .tint(.brandTint)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    let exchangeRateVM = ExchangeRatesViewModel(fetchedData: FetchService.shared.fetch()!)

    return ExchangeRatesView(exchangeRateVM: exchangeRateVM).tint(.brandTint)
}
