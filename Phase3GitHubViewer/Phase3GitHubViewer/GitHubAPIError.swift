import Foundation

enum GitHubAPIError: LocalizedError, Equatable {
    case invalidUsername
    case invalidURL
    case invalidResponse
    case httpStatus(code: Int, message: String?)
    case noData
    case decodingFailed

    var errorDescription: String? {
        switch self {
        case .invalidUsername:
            return "請輸入有效的 GitHub 使用者名稱。"
        case .invalidURL:
            return "無法建立請求網址。"
        case .invalidResponse:
            return "伺服器回應格式異常。"
        case let .httpStatus(code, message):
            if let message, !message.isEmpty {
                return "HTTP \(code)：\(message)"
            }
            return "HTTP 錯誤：\(code)"
        case .noData:
            return "沒有收到資料。"
        case .decodingFailed:
            return "無法解析伺服器回應（JSON 格式可能已變更）。"
        }
    }
}
