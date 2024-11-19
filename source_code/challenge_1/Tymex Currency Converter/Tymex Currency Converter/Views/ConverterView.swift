//
//  ContentView.swift
//  Tymex Currency Converter
//
//  Created by HUY TON on 15/11/24.
//

import SwiftUI

struct ConverterView: View {
    
    @State private var inputAmount = ""
    @State private var iconAnimated = false
    
    @State private var source = "USD"
    @State private var dest = "VND"
    
    @State private var output = ""
    
    @FocusState private var isFocused: Bool
    
    @StateObject var converterVM = ConverterViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack {
                
                    Text("Tymex Converter")
                        .font(.title)
                        .foregroundStyle(.brandTint)
                        .fontWeight(.black)
                        
                    VStack(spacing: 10) {
                        
                        sourceCurrency(geo: geo)
                        
                        swapButton
                        
                        destCurrency(geo: geo)
                    }
                    .padding(.vertical)
                    
                    reloadSection
                    
                    
                    NavigationLink {
                        
                        ExchangeRatesView(exchangeRateVM: ExchangeRatesViewModel(fetchedData: FetchService.shared.fetch()!))
                        
                    } label: {
                        Label("Currency Stats", systemImage: "chart.bar.xaxis")
                        
                    }
                    
                    Spacer()
                    
                    Button {
                        isFocused.toggle()
                        
                        output = String(format: "%.2f", converterVM.convert(amount: inputAmount, source: source, dest: dest))
                        
                        
                    } label: {
                        
                        Text("Convert")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .bold()
                            .font(.title3)
                            .background(.indigo.gradient)
                            .foregroundStyle(.white)
                            .clipShape(.rect(cornerRadius: 15.0))
                    }
                    .opacity(isFocused ? 1.0 : 0)
                    .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: isFocused)
                    
                    
                }
                .padding()
                .background {
                    MyBackground()
                }
            }
            .overlay(alignment: .topTrailing) {
                if isFocused {
                    
                        Button("Done") {
                            isFocused.toggle()
                        }
                        .padding()

                }
            }
            .overlay {
                
                Feedback(message: $converterVM.message, status: $converterVM.status)
            }
            .task {
                if !converterVM.fetched {
                    await converterVM.fetchNewestData()
                }
            }
        .tint(Color.brandTint)
        }
    }
    
    func sourceCurrency(geo: GeometryProxy) -> some View {
        HStack {
            HStack {
                Text("From").animation(.snappy, value: self.iconAnimated)
                Spacer()
                Picker("", selection: $source) {
                    ForEach(converterVM.getSortedAvailableCurrency(), id: \.self) { currency in
                        
                            Text(currency)
                            .tag(currency)
                        }
                }
                .animation(.bouncy, value: iconAnimated)

                
            }
            .frame(maxWidth: geo.size.width * 0.35)
            
            
            Spacer()
        
            TextField("Enter amount ...", text: $inputAmount)
                .keyboardType(.decimalPad)
                .focused($isFocused)
                .frame(maxWidth: geo.size.width * 0.3, alignment: .leading)
            
                
        }
        .padding()
        .background(.ultraThickMaterial)
        .clipShape(.rect(cornerRadius: 15.0))
    }
    
    func destCurrency(geo: GeometryProxy) -> some View {
        HStack {
            HStack {
                Text("To").animation(.bouncy, value: self.iconAnimated)
                Spacer()
                Picker("", selection: $dest) {
                    
                    ForEach(converterVM.getSortedAvailableCurrency(), id: \.self) { currency in
                        
                        Text(currency)
                            .tag(currency)
                    }
                    
                }
            }
            .frame(maxWidth: geo.size.width * 0.35)
            Spacer()
            Text(output)
                .frame(maxWidth: geo.size.width * 0.3, alignment: .leading)
        }
        .padding()
        .background(.ultraThickMaterial)
        .clipShape(.rect(cornerRadius: 15.0))
    }
    
    var swapButton: some View {
        Button {
            iconAnimated.toggle()
            swap(&source, &dest)
            inputAmount = ""
            output = ""
            
        } label: {
            Image(systemName: "arrow.up.arrow.down")
                .bold()
                .imageScale(.large)
                .symbolEffect(.bounce, value: iconAnimated)
                .foregroundStyle(.white)
        }
    }
    
    var reloadSection: some View {
        HStack {
            Text("Updated at: \(converterVM.updatedTime?.formatted() ?? "Error in fetching data")")
                .italic()
                .foregroundStyle(.secondary)
                .font(.subheadline)
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "arrow.counterclockwise")
                    .padding(10)
                    .bold()
                    .background(.brandTint)
                    .clipShape(.circle)
                    .foregroundStyle(.white)
                    .symbolEffect(.variableColor)
            }
            
        }
    }
}

#Preview {
    ConverterView()
}
