# MoodMate
1931083 - 지대한

iOS 미니 프로젝트

간단한 이모지와 색상, 메모만으로 그날의 감정을 기록하고, AI 요약과 시각화를 통해 감정 패턴을 되돌아볼 수 있는 감정 관리 애플리케이션

---

- 사용 언어 – Swift(SwiftUI)
- 사용 API – OpenAI GPT-3.5 Turbo
- 사용 라이브러리 – DGCharts (Pie Chart)

---


## 인앱 화면 예시 및 흐름

![vlcsnap-2025-06-18-05h03m22s030](https://github.com/user-attachments/assets/00312dd2-ff5a-4572-a21f-3a6fe35c2f5c)

- 앱을 실행하면 감정 기록 View가 우선 등장
- 유저는 이모지와 색상, 간단한 메모로 입력 View에서 감정을 기록
- 감정은 UserDefaults를 통해 저장되며, 입력한 날짜 기준으로 저장되어 관리.
- 기록된 감정은 캘린더, 파이 차트, AI 요약에서 확인할 수 있음.

---

## 기능 구현

| 클래스 또는 뷰             | 기능       | 설명                           |
| -------------------- | -------- | ---------------------------- |
| FeelingRecordView  | 감정 입력 화면 | 이모지 선택, 메모 작성, 색상 선택         |
| CalendarView       | 감정 리스트   | 날짜별 기록 열람 및 삭제 기능 포함         |
| StatsView          | 감정 통계    | DGCharts 기반 파이 차트            |
| SummaryView        | 감정 요약    | ChatGPT API를 통한 감정 흐름 요약     |
| FeelingDataManager | 데이터 관리   | UserDefaults 저장/불러오기 및 집계 처리 |
| ChatGPTManager     | API 관리   | OpenAI API와 통신 및 결과 파싱       |

---

## 주요 메소드 및 구성 요소

### 감정 저장 기능

FeelingDataManager의 아래 함수에서 진행

```swift
func addEntry(emoji: String, note: String, colorHex: String) {
    let newEntry = FeelingEntry(id: UUID(), date: Date(), emoji: emoji, note: note, colorHex: colorHex)
    entries.append(newEntry)
    save()
}
// 제거는 CalendarView의 func deleteEntry
```

### 감정 통계 파이 차트

```swift
    func makeUIView(context: Context) -> PieChartView {
        let chart = PieChartView()
        chart.legend.enabled = true
        chart.drawEntryLabelsEnabled = false
        chart.holeRadiusPercent = 0.4
        return chart
    }
    // UI 표시 함수

    func updateUIView(_ uiView: PieChartView, context: Context)
    // 생성 및 제거되는 리스트에 맞춰 변화하여 업데이트 되는 파이 차트 함수
```

![스크린샷 2025-06-18 044013](https://github.com/user-attachments/assets/d5f5ab5c-5753-49bc-81b7-306468d9f7af)

---

## 감정 기록 예시

- FeelingDataManager로 관리
- FeelingRecordView에서 기록 진행  

![화면 캡처 2025-06-18 043733](https://github.com/user-attachments/assets/2818b8d1-53f3-4c75-8110-69ca32040ce2)

---

## 감정 요약 예시 출력

```swift
    func requestSummary(from entries: [FeelingEntry], completion: @escaping (String?) -> Void) {
        let prompt = buildPrompt(from: entries)
      // OpenAI Chat Completion 호출 함수
}
```

![스크린샷 2025-06-18 043840](https://github.com/user-attachments/assets/851879c1-3b79-413a-b3b5-31ffc24624eb)

---

## 발표 영상


영상 주소 - https://www.youtube.com/watch?v=clCpaeKCQ3M
