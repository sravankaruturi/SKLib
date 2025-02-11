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
    
    public init(header: String, prompt: String, text: String, action: @escaping () -> Void) {
        self.header = header
        self.prompt = prompt
        self.text = text
        self.action = action
    }

    public var body: some View {
        // Create an empty NavigationStack to apply the ".searchable" modifier
        NavigationStack {
            // Create an empty NavigationVew to apply the ".navigationBarTitle" modifier
            NavigationView {}
                // Suppress the NavigationView's default left panel
                .navigationViewStyle(.stack)
                // Set the navigation title bar text
                .navigationBarTitle(self.header)
        }
        // Restrict the navigation stack height so that just the title bar and
        // search input field are shown
        .frame(height: 170)
        // This modifier places a search field inside the navigation stack
        .searchable(
            text: self.$text,
            // Place the search bar below the title bar
            placement: .navigationBarDrawer,
            // Set the text that appears when the field is empty
            prompt: self.prompt
        )
        // Always enable "look to dictate" for this field regardless of system settings
        .searchDictationBehavior(.inline(activation: .onLook))
        // Change the on-screen keyboard's primary button label from "Search" to "Go"
        .keyboardType(.webSearch)
        // This modifier prevents the search bar from moving when search is
        // activated or dismissed
        .searchPresentationToolbarBehavior(.avoidHidingContent)
        // Action to be taken when the "Go" button on the keyboard is pressed
        .onSubmit(of: .search) {
            self.action()
        }
    }
}

#Preview {
    AdvancedTextField(
        header: "This is an example header",
        prompt: "This is the prompt",
        text: .constant(""), action: {}
    )
}

#endif
