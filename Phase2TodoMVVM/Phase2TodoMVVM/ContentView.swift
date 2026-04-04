//
//  ContentView.swift
//  Phase2TodoMVVM
//
//  Created by Kai Fu Jhuang on 2026/4/4.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TodoListView(viewModel: TodoViewModel())
    }
}

#Preview {
    ContentView()
}
