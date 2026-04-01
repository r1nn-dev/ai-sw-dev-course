# To-Do Web App: 기능 및 코드 상세 설명

이 문서는 본 애플리케이션의 핵심 기능과 이를 구현하기 위해 사용된 기술적 접근 방식을 상세히 설명합니다.

---

## 1. 핵심 기능 및 구현 로직

### 📦 Todo 항목 생성 및 추가 (`addTodo` 함수)
시스템은 사용자가 입력한 텍스트와 마감일을 기반으로 새로운 리스트 항목(`<li>`)을 동적으로 생성합니다.

- **DOM 조작**: `document.createElement('li')`를 사용하여 항목을 생성하고 `innerHTML`을 통해 내부 구조(체크박스, 텍스트, 날짜 배지, 삭제 버튼)를 정의합니다.
- **마감일 처리 및 기한 초과(Overdue) 판단**:
  ```javascript
  const today = new Date().setHours(0, 0, 0, 0); // 오늘 날짜 00:00:00 기준
  const due = new Date(dateValue).setHours(0, 0, 0, 0);
  const isOverdue = due < today; // 과거 날짜인 경우 true
  ```
  이 로직을 통해 기한이 지난 항목에는 `.overdue` 클래스를 부여하여 시각적으로 강조합니다.

### 🔍 실시간 필터링 시스템 (`filterByKeyword` 함수)
특정 키워드를 포함하는 항목만 화면에 표시하는 기능을 수행합니다.

- **데이터 순회**: `querySelectorAll`로 모든 `<li>` 요소를 가져와 `forEach`로 순회합니다.
- **비교 로직**: `textContent.toLowerCase()`를 사용해 대소문자 구분 없이 검색어를 비교합니다.
- **조건부 렌더링**: `display: flex`와 `display: none`을 전환하여 필터링 결과를 즉시 반영합니다.
- **Null 및 공백 체크**: 키워드가 없을 경우 조기 리턴(Early Return)하여 모든 항목을 다시 노출시킵니다.

### 🗑 상태 관리 및 삭제
- **토글 완료**: 항목 클릭 시 `classList.toggle('completed')`를 사용하여 완료 상태를 시각적으로 전환합니다. (취소선 및 투명도 변경)
- **부드러운 삭제**: `remove()` 호출 전 `scale(0.9)`과 `opacity: 0` 애니메이션을 적용하고 `setTimeout`을 사용해 자연스럽게 사라지도록 구현했습니다.

---

## 2. 디자인 및 UI 시스템 (`style.css`)

### ✨ 글래스모피즘 (Glassmorphism)
현대적인 프리미엄 UI를 위해 다음과 같은 속성들을 조합했습니다.

- **투명도 및 블러**: `rgba(255, 255, 255, 0.05)`로 배경색을 지정하고, `backdrop-filter: blur(20px)`를 적용하여 유리가 겹쳐진 듯한 효과를 냈습니다.
- **테두리 하이라이트**: 아주 얇은 투명 테두리(`border: 1px solid rgba(255, 255, 255, 0.1)`)를 추가해 경계선을 명확히 했습니다.

### 🎨 색상 체계 및 그라데이션
- **액센트 컬러**: `linear-gradient(135deg, #00d2ff, #3a7bd5)`를 사용하여 주요 버튼과 타이틀에 생동감을 부여했습니다.
- **상태 컬러**: 성공(`--success`: #00ff88)과 위험(`--danger`: #ff4d4d) 컬러를 정의하여 직관적인 피드백을 제공합니다.

### 🎬 애니메이션 및 마이크로 인터랙션
- **진입 애니메이션**: `fadeIn`과 `slideIn` 키워드를 정의하여 애플리케이션 실행 시와 항목 추가 시 부드러운 전환 효과를 제공합니다.
- **호버 효과**: `transform: scale(1.01)`과 `filter: brightness(1.1)`를 활용해 상호작용의 즐거움을 더했습니다.

---

## 3. 파일 구조 및 역할

| 파일명 | 역할 |
| :--- | :--- |
| `todo-index.html` | 전체 앱의 뼈대 구성 및 JavaScript 기반 비즈니스 로직(Todo CRUD, 필터링) 관리 |
| `style.css` | 디자인 시스템(Glassmorphism), 색상 변수, 반응형 레이아웃 및 애니메이션 관리 |

---
*본 코드는 확장성과 가독성을 고려하여 CSS 변수와 Vanilla JS의 순수 기능을 최대한 활용하도록 설계되었습니다.*
