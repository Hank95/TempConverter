//
//  ContentView.swift
//  TempCheck
//
//  Created by Henry Pendleton on 3/11/24.
//

import SwiftUI

enum TemperatureType: String, CaseIterable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
    
    var symbol: String {
        switch self {
        case .celsius: return "°C"
        case .fahrenheit: return "°F"
        case .kelvin: return "K"
        }
    }
}


struct ContentView: View {
    @State private var fromTemp = 0.0
    @State private var selectedTemperatureType = TemperatureType.celsius
    
    @FocusState private var tempAmountIsFocused : Bool
    
    private var celsius: Double {
        switch selectedTemperatureType {
        case .celsius:
            return fromTemp
        case .fahrenheit:
            return (fromTemp - 32) * 5 / 9
        case .kelvin:
            return fromTemp - 273.15
        }
    }
    
    private var fahrenheit: Double {
        switch selectedTemperatureType {
        case .celsius:
            return fromTemp * 9 / 5 + 32
        case .fahrenheit:
            return fromTemp
        case .kelvin:
            return (fromTemp - 273.15) * 9 / 5 + 32
        }
    }
    
    private var kelvin: Double {
        switch selectedTemperatureType {
        case .celsius:
            return fromTemp + 273.15
        case .fahrenheit:
            return (fromTemp - 32) * 5 / 9 + 273.15
        case .kelvin:
            return fromTemp
        }
    }
    
    private var formattedTemperature: String {
        let temp = fromTemp
        switch selectedTemperatureType {
        case .celsius:
            return "\(temp) \(selectedTemperatureType.symbol)"
        case .fahrenheit:
            return "\(temp) \(selectedTemperatureType.symbol)"
        case .kelvin:
            return "\(temp) \(selectedTemperatureType.symbol)"
        }
    }
    var body: some View {
        NavigationStack{
            Form{
                Section("From"){
                    Picker("Temperature Type", selection: $selectedTemperatureType) {
                        ForEach(TemperatureType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()

                    TextField("Temprature", value: $fromTemp, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($tempAmountIsFocused)
                }
                Section("To"){
                    Text("In Celsius: \(celsius, specifier: "%.2f") \(TemperatureType.celsius.symbol)")
                    
                    Text("In Fahrenheit: \(fahrenheit, specifier: "%.2f") \(TemperatureType.fahrenheit.symbol)")
                    
                    Text("In Kelvin: \(kelvin, specifier: "%.2f") \(TemperatureType.kelvin.symbol)")

                }
            }
            .navigationTitle("TempCheck")
            .toolbar{
                if tempAmountIsFocused {
                    Button("Done"){
                        tempAmountIsFocused = false
                    }
                }
                
            }
        }
    }
}

#Preview {
    ContentView()
}
