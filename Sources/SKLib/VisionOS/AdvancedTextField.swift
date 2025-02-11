//
//  AdvancedTextField.swift
//  LTD
//
//  Created by Sravan Karuturi on 2/10/25.
//
import SwiftUI

#if os(visionOS)

public struct AdvancedTextField: View {

    var header: String
    var prompt: String
    @Binding var text: String
    var action: () -> Void
    
    public init(header: String, prompt: String, text: Binding<String>, action: @escaping () -> Void) {
        self.header = header
        self.prompt = prompt
        self._text = text  // Assigning the binding to the property wrapper
        self.action = action
    }

    public var body: some View {
        NavigationStack {
            NavigationView {}
                .navigationViewStyle(.stack)
                .navigationBarTitle(self.header)
        }
        .frame(height: 170)
        .searchable(
            text: self.$text,
            placement: .navigationBarDrawer,
            prompt: self.prompt
        )
        .searchDictationBehavior(.inline(activation: .onLook))
        .keyboardType(.webSearch)
        .searchPresentationToolbarBehavior(.avoidHidingContent)
        .onSubmit(of: .search) {
            self.action()
        }
    }
}

#Preview {
    AdvancedTextField(
        header: "This is an example header",
        prompt: "This is the prompt",
        text: .constant(""),
        action: {}
    )
}

#endif
