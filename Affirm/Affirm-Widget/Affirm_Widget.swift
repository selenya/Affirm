//
//  Affirm_Widget.swift
//  Affirm-Widget
//
//  Created by Selen Yanar on 14.02.2021.
//

import WidgetKit
import SwiftUI
import Intents


struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        let rectangle = Rectangle()
        return SimpleEntry(date: Date(), configuration: ConfigurationIntent(), myAffirmation: "...", rectangle: rectangle)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let rectangle = Rectangle()
        let entry = SimpleEntry(date: Date(), configuration: configuration, myAffirmation: "...", rectangle: rectangle)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        let vc = AffirmationStrings()
        let randomAffirmation = vc.affirmations[Int.random(in: 0...17)]
        let rectangle = Rectangle()

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 17 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, myAffirmation: randomAffirmation, rectangle: rectangle)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let myAffirmation: String
    let rectangle: Rectangle
}

struct Affirm_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        
        ZStack {
            
            entry.rectangle
                .fill(changeBackgroundColor(topColor: getRandomColor(), bottomColor: getRandomColor()))
                .ignoresSafeArea()
            
            Text(entry.myAffirmation)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding()
            
        }
        
    }
}

@main
struct Affirm_Widget: Widget {
    let kind: String = "Affirm_Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            Affirm_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct Affirm_Widget_Previews: PreviewProvider {
    static var previews: some View {
        let rectangle = Rectangle()
        Affirm_WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), myAffirmation: "Random String", rectangle: rectangle))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


func getRandomColor() -> UIColor {
    
    let colors = [#colorLiteral(red: 0.9788444638, green: 0.3417158127, blue: 0.2214691639, alpha: 1),#colorLiteral(red: 0.9569323659, green: 0.8279810548, blue: 0.36699754, alpha: 1),#colorLiteral(red: 0.6384183168, green: 0.729480505, blue: 0.7047615647, alpha: 1),#colorLiteral(red: 0.460367918, green: 0.7215610743, blue: 0.7296198606, alpha: 1),#colorLiteral(red: 0.005418071058, green: 0.4743847847, blue: 0.5436778665, alpha: 1),#colorLiteral(red: 0.1532693207, green: 0.1371036172, blue: 0.2263761759, alpha: 1),#colorLiteral(red: 0.2163760066, green: 0.4784737825, blue: 0.4414744973, alpha: 1),#colorLiteral(red: 0.9347010255, green: 0.5886977315, blue: 0.2905469537, alpha: 1),#colorLiteral(red: 0.5776328444, green: 0.8667305708, blue: 0.8255947232, alpha: 1),#colorLiteral(red: 0.0744490996, green: 0.1214368269, blue: 0.1945256293, alpha: 1),#colorLiteral(red: 0.8758333325, green: 0.5962575674, blue: 0.5674185753, alpha: 1),#colorLiteral(red: 0.6777182221, green: 0.7374146581, blue: 0.6468991637, alpha: 1),#colorLiteral(red: 0.9853708148, green: 0.7609826922, blue: 0.7074975371, alpha: 1),#colorLiteral(red: 0.8452489972, green: 0.9690846801, blue: 0.5771339536, alpha: 1),#colorLiteral(red: 0.7821670175, green: 0.3336869478, blue: 0.2427659035, alpha: 1)]
    let randomColor = colors[Int.random(in: 0...14)]
    
    print("\(randomColor)")
    return randomColor
    
}


func changeBackgroundColor (topColor: UIColor, bottomColor: UIColor) -> LinearGradient {
    let linearBackgroundColor = LinearGradient(gradient: Gradient(colors: [Color(topColor), Color(bottomColor)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    return linearBackgroundColor
    
}
