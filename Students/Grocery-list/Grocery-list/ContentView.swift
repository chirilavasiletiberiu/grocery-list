//
//  ContentView.swift
//  Grocery-list
//
//  Created by tiberiu.chirila on 12.02.2026.
//

import SwiftUI
import SwiftData
import TipKit

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var items: [Item]
    
    @State private var item: String = ""
    
    @FocusState private var isFocused: Bool
    
    let buttonTip = ButtonTip()
    
    init() {
        self.setupTips()
    }
    
    func setupTips() {
        do {
            try Tips.resetDatastore()
            Tips.showAllTipsForTesting()
            try Tips.configure([
                .displayFrequency(.immediate)
            ])
        } catch {
            print("Error initialising TipKit: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(self.items) { item in
                    Text(item.title)
                        .font(.title.weight(.light))
                        .padding(.vertical, 2)
                        .foregroundStyle(item.isCompleted == false ? Color.primary : Color.accentColor)
                        .strikethrough(item.isCompleted)
                        .italic(item.isCompleted)
                        .swipeActions {
                            Button(role: .destructive) {
                                withAnimation {
                                    self.modelContext.delete(item)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button("Done", systemImage: item.isCompleted == false ? "checkmark.circle" : "x.circle") {
                                item.isCompleted.toggle()
                            }
                            .tint(item.isCompleted == false ? .green : .accentColor)
                        }
                }
            }
            .listStyle(.plain)
            .background(Color.clear)
            .navigationTitle("Grocery List")
            .toolbar {
                if self.items.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            self.addEssentialFood()
                        } label: {
                            Image(systemName: "carrot")
                        }
                        .popoverTip(self.buttonTip)
                    }
                }
            }
            .overlay {
                if self.items.isEmpty {
                    ContentUnavailableView("Empty Cart", systemImage: "cart.circle", description: Text("Add some items to the shopping list."))
                }
            }
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 12) {
                    TextField("", text: $item)
                        .textFieldStyle(.plain)
                        .padding(12)
                        .background(.tertiary)
                        .cornerRadius(12)
                        .font(.title.weight(.light))
                        .focused($isFocused)
                    
                    Button {
                        guard !self.item.isEmpty else { return }
                        
                        let newItem = Item(title: self.item, isCompleted: false)
                        self.modelContext.insert(newItem)
                        self.item = ""
                        self.isFocused = false
                    } label: {
                        Text("Save")
                            .font(.title2.weight(.medium))
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle)
                    .controlSize(.extraLarge)
                }
                .padding()
                .background(.bar)
            }
        }
    }
    
    func addEssentialFood() {
        self.modelContext.insert(Item(title: "Bakery", isCompleted: true))
        self.modelContext.insert(Item(title: "Soup", isCompleted: false))
        self.modelContext.insert(Item(title: "Coffee", isCompleted: .random()))
        self.modelContext.insert(Item(title: "Eggs", isCompleted: .random()))
        self.modelContext.insert(Item(title: "Pasta & Rice", isCompleted: .random()))
    }
}

#Preview("Sample Data") {
    let sampleData: [Item] = [
        Item(title: "Bakery", isCompleted: true),
        Item(title: "Soup", isCompleted: false),
        Item(title: "Coffee", isCompleted: .random()),
        Item(title: "Eggs", isCompleted: .random()),
        Item(title: "Pasta & Rice", isCompleted: .random())
    ]
    
    let container = try! ModelContainer(for: Item.self,
                                        configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    sampleData.forEach { container.mainContext.insert($0) }

    return ContentView()
        .modelContainer(container)
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
