//
//  ChatGPTManager.swift
//  MoodMate_Test
//
//  Created by 지대한 on 6/18/25.
//

import Foundation

class ChatGPTManager {
    static let shared = ChatGPTManager()
    
    private let apiKey = "sk-BlaBla" // 지피티 api 입력해야 함 여기에.
    private let endpoint = "https://api.openai.com/v1/chat/completions"
    
    func requestSummary(from entries: [FeelingEntry], completion: @escaping (String?) -> Void) {
        let prompt = buildPrompt(from: entries)
        
        let body: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "system", "content": "You are a helpful assistant that summarizes emotional logs."],
                ["role": "user", "content": prompt]
            ],
            "temperature": 0.7
        ]
        
        guard let url = URL(string: endpoint),
              let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            print("🚨 URL 또는 JSON 직렬화 오류")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        print("ChatGPT 요청 시작") // 디버그 라인 진행. 문제가 뭔지 확인해야 함. 에러가 있음
        print("Headers: \(request.allHTTPHeaderFields ?? [:])")
        print("Body: \(String(data: jsonData, encoding: .utf8) ?? "")")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("네트워크 오류: \(error.localizedDescription)")
                completion(nil)
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP 상태 코드: \(httpResponse.statusCode)")
            }

            guard let data = data else {
                print("데이터 없음")
                completion(nil)
                return
            }

            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let choices = json["choices"] as? [[String: Any]],
               let message = choices.first?["message"] as? [String: Any],
               let content = message["content"] as? String {
                print("요약 응답 수신 완료")
                completion(content)
            } else {
                print("JSON 파싱 실패")
                if let responseText = String(data: data, encoding: .utf8) {
                    print("응답 본문:\n\(responseText)")
                }
                completion(nil)
            }
        }.resume()
    }
    
    private func buildPrompt(from entries: [FeelingEntry]) -> String {
        let sorted = entries.sorted(by: { $0.date > $1.date })
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        let summary = sorted.map {
            "\(dateFormatter.string(from: $0.date)) \($0.emoji): \($0.note)"
        }.joined(separator: "\n")
        
        return """
        다음은 사용자의 감정 기록입니다. 이 기록을 바탕으로 최근 감정 상태를 요약해줘:

        \(summary)
        """
    }
}

