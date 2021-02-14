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
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), myAffirmation: "...")
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, myAffirmation: "...")
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        let vc = AffirmationStrings()
        let randomAffirmation = vc.affirmations[Int.random(in: 0...10)]

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, myAffirmation: randomAffirmation)
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
}

struct Affirm_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        
        ZStack {
            Color.init(getRandomColor())
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
        Affirm_WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), myAffirmation: "Random String"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


func getRandomColor() -> UIColor {
    
    let colors = [#colorLiteral(red: 0.6475277543, green: 0.5764557719, blue: 0.6294283867, alpha: 1),#colorLiteral(red: 0.7882605791, green: 0.7882233858, blue: 0.8371105194, alpha: 1),#colorLiteral(red: 0.6384183168, green: 0.729480505, blue: 0.7047615647, alpha: 1),#colorLiteral(red: 0.460367918, green: 0.7215610743, blue: 0.7296198606, alpha: 1),#colorLiteral(red: 0.005418071058, green: 0.4743847847, blue: 0.5436778665, alpha: 1),#colorLiteral(red: 0.7164131403, green: 0.8667100668, blue: 0.8583627939, alpha: 1),#colorLiteral(red: 0.2163760066, green: 0.4784737825, blue: 0.4414744973, alpha: 1),#colorLiteral(red: 0.5776328444, green: 0.8667305708, blue: 0.8255947232, alpha: 1),#colorLiteral(red: 0.5776328444, green: 0.8667305708, blue: 0.8255947232, alpha: 1),#colorLiteral(red: 0.0744490996, green: 0.1214368269, blue: 0.1945256293, alpha: 1),#colorLiteral(red: 0.7751336694, green: 0.9021583796, blue: 0.7786861062, alpha: 1)]
    let randomColor = colors[Int.random(in: 0...10)]
    
    print("\(randomColor)")
    return randomColor
    
}
