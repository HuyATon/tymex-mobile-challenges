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
                header
                Spacer()
                if currencies.count > 0 {
                    VStack {
                        title
                        sorter
                        chart(geo: geo)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 15.0))
                }
                else {
                    ContentUnavailableView("Data is not available", systemImage: "network.slash")
                }
                Spacer()

            }
            .padding()
        }
        .tint(.brandTint)
        .navigationBarBackButtonHidden()
        .background(MyBackground())
    }
    
    var header: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .bold()
                    .padding(.trailing)
            }
            Text("Currency Stats")
                .font(.title2)
                .bold()
                .foregroundStyle(.brandTint)
            Spacer()
        }
    }
    
    var title: some View {
        Text("Exchange Rates for \(exchangeRateVM.baseCurrency)")
            .bold()
            .font(.title3)
    }
    
    var sorter: some View {
        HStack {
            Spacer()
            HStack {
                Text("Sort:")
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
    }
    
    func chart(geo: GeometryProxy) -> some View {
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
        .frame(height: geo.size.height * 0.4)
        .padding(.bottom)
    }
}

#Preview {
    let exchangeRateVM = ExchangeRatesViewModel(fetchedData: FetchService.shared.fetch()!)

    return ExchangeRatesView(exchangeRateVM: exchangeRateVM).tint(.brandTint)
}
