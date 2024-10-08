import SwiftUI

struct TrainingView: View {
    @State private var progress: Double = 0.0
    @State private var isTraining = false
    @State private var trainingStatus = "Waiting to start..."
    
    var body: some View {
        VStack {
            Text(trainingStatus)
                .padding()
            
            ProgressView(value: progress, total: 1.0)
                .progressViewStyle(LinearProgressViewStyle())
                .padding()
                .opacity(isTraining ? 1 : 0)  // Show progress bar only when training
            
            Button("Upload Folder") {
                selectFolderAndTrain()
            }
            .disabled(isTraining)  // Disable button during training
        }
        .padding()
    }
    
    func selectFolderAndTrain() {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.allowsMultipleSelection = false
        
        // Handle folder selection
        if panel.runModal() == .OK {
            guard let selectedFolderURL = panel.url else {
                trainingStatus = "No folder selected."
                return
            }
            
            // Set the status with the selected folder's path
            trainingStatus = "Selected folder: \(selectedFolderURL.path)"
            isTraining = false
        }
    }
}

