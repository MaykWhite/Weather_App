//
//  DailyView.swift
//  Weather_App
//
//  Created by Mayk on 9/28/22.
//

import SwiftUI

struct ForecastListView: View {
    var daily: [DailyResponse]
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 50, height: 5)
                .padding(.top)
                .padding(.bottom, 5)
            Text("Daily Forecast")
                .frame(alignment: .leading)
            ScrollView(.vertical, showsIndicators: false, content: {
                LazyVStack(alignment:.leading, spacing: 10, content: {
                    ForEach(daily[0].listDaily , id: \.dateDaily) { day in
                        HStack {
                            Text(day.dateDaily.formatter)
                                .padding()
                            Text(day.tempDaily.dayTemperatureDaily
                                .roundDouble() + "°")
                                .padding()
                            Text("\(day.weatherDaily[0].descriptionDaily.capitalized)")
                                .padding()
                        }
                    }
                })
                .padding()
                .padding(.top)
            })
        }
        .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .background(.white)
        //.background(BlurView(style: .systemMaterial))
        .cornerRadius(15)
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastListView(daily: [previewDaily])
    }
}
