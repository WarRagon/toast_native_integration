import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            Button("Toast") {
                ToastUtils.show("Toast")
            }
        }
    }
}

#Preview {
    ContentView()
}
