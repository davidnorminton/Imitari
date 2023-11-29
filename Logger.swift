import Foundation

class Logger {
    static let shared = Logger()
    private let fileURL: URL
    private let logQueue = DispatchQueue(label: "com.example.app.logqueue")
    
    private init() {
        // Get the document directory
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        // Create a file named 'log.txt' in the document directory
        self.fileURL = documentDirectory.appendingPathComponent("logger.txt")
    }
    
    func log(_ message: String) {
        logQueue.async {
            let timeStamp = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .medium)
            let log = "\(timeStamp): \(message)\n"
            
            if let fileHandle = FileHandle(forWritingAtPath: self.fileURL.path) {
                // Append to file
                fileHandle.seekToEndOfFile()
                fileHandle.write(log.data(using: .utf8)!)
                fileHandle.closeFile()
            } else {
                do {
                    // If file doesn't exist, create it and write log
                    try log.write(to: self.fileURL, atomically: true, encoding: .utf8)
                } catch {
                    print("Error writing to log file: \(error)")
                }
            }
        }
    }
    
    func getLogs() -> String {
        do {
            // Read contents of the log file
            let logs = try String(contentsOf: fileURL, encoding: .utf8)
            return logs
        } catch {
            print("Error reading log file: \(error)")
            return "Error reading log file"
        }
    }
}
