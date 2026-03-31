# ollama-namu-agent
- 나무위키 검색 에이전트 구현

### 실습 개요
- AI 에이전트의 개념과 Tool Use(도구 사용) 패턴을 직접 구현해보는 실습.
- Ollama를 통해 로컬에서 LLM을 실행하고, 파일 읽기/쓰기/수정 및 나무위키 웹 검색 기능을 갖춘 에이전트를 만드는 실습.
- 핵심 학습 목표: 유저의 한 번 질문으로 여러 도구(Tool)를 연속으로 호출하는 에이전트 패턴을 구현하는 것   

도구: Google Antigravity   

참고 사항
- 모델 설치 명령어: ollama pull qwen2.5-coder:7b
- 나무위키 URL 형식: https://namu.wiki/w/검색어

필수 기능:
1. 파일 읽기/쓰기/수정 Tool 
    - 로컬 파일 시스템에 텍스트 파일을 읽고, 새로 쓰고, 기존 내용을 수정할 수 있는 Tool 구현
2. 나무위키 웹 검색 Tool
    - 사용자가 키워드를 입력하면 나무위키에서 해당 항목을 검색하여 내용을 가져오는 Tool 구현
3. 연속 Tool 호출 (Multi-step Tool Use)
    - 유저의 한 번 질문에 대해 2번 이상의 Tool을 연속으로 호출하는 로직 구현

예시 시나리오:
```bash
사용자: "젤다에 대해 검색해줘"
→ 에이전트가 자동으로: (1) 나무위키에서 "젤다" 검색 → (2) 검색 결과를 파일에 저장
```

기술 요구사항: 
- Ollama 설치 및 qwen2.5-coder:7b 모델 설치
- 구현 언어: Python 권장 (다른 언어도 가능)
- Ollama API (로컬 HTTP) 또는 ollama Python 라이브러리 활용
- 나무위키 검색은 requests + BeautifulSoup 또는 유사 라이브러리 활용

핵심 과제 (Multi-step Tool Calling):
- 유저의 한 번 질문에 에이전트가 어떻게 하면 2번 연속으로 Tool을 호출할 수 있는지 고민하고 구현해야 한다.
- 예를 들어:
    - 첫 번째 Tool 호출의 결과를 받아서 다음 Tool 의 입력으로 전달하는 패턴 (Chaining)
    - LLM 응답에서 tool_calls 파싱하고, 결과를 다시 메시지에 추가하여 반복 호출하는 루프 구조
    - Tool 결과를 컨텍스트로 유지하며 LLM 이 다음 행동을 결정하도록 하는 패턴

# 실습
사전 준비 — Ollama 설치
```bash
# 설치 확인
ollama --version
# 모델 설치
ollama pull qwen2.5-coder:7b
# 모델 실행 테스트
ollama run qwen2.5-coder:7b
```

## 실행 순서
1. 프로젝트 초기 세팅 (uv + 빈 파일 구조)
2. Ollama 모델 확인
3. 대화 루프 + 히스토리 구현
4. `tools.py` — 파일 I/O 함수 구현
5. `tools.py` — 나무위키 검색 함수 추가
6. `main.py` — System Prompt 기반 Tool Calling 루프 연결 (핵심)
7. 동작 검증
8. `.gitignore` + GitHub 업로드

### 1. 프로젝트 초기 세팅 (uv + 빈 파일 구조)
```bash
uv 패키지 매니저로 "ollama-namu-agent"라는 Python 프로젝트를 세팅해줘.
main.py와 tools.py 파일도 빈 상태로 만들어줘.
README.md에는 에디터에서 가상환경을 선택하는 가이드를 작성해줘.
```
예상 결과
```bash
namu-agent/
├── .venv/
├── .python-version
├── pyproject.toml
├── README.md
├── main.py
└── tools.py
```

### 2. Ollama 모델 확인
```bash
ollama list                     # 설치된 모델 확인
ollama pull qwen2.5-coder:7b    # 없으면 설치
ollama run qwen2.5-coder:7b     # 정상 동작 확인
```

### 3. 대화 루프 + 히스토리 구현
```bash
main.py에서 Ollama Python 라이브러리를 이용해서
qwen2.5-coder:7b 모델과 터미널에서 채팅할 수 있도록 구현해줘.
이전 대화를 기억할 수 있도록 대화 히스토리를 누적해줘.
"exit"를 입력하면 종료되도록 해줘.
```
예상 결과:
```
README.md 파일 업데이트
main.py 파일 업데이트
- 대화 히스토리 누적
- "exit" 입력 시 종료
```

### 4. `tools.py` — 파일 I/O 함수 구현
```bash
tools.py에 파일을 읽고, 새로 쓰고, 수정하는 함수를 각각 구현해줘.
에러가 발생하면 에러 메시지를 문자열로 반환하도록 해줘.
```

### 5. `tools.py` — 나무위키 검색 함수 추가
```bash
tools.py에 나무위키에서 키워드를 검색하는 함수를 추가해줘.
requests와 BeautifulSoup을 사용해서
[https://namu.wiki/w/{키워드}](https://namu.wiki/w/%7B%ED%82%A4%EC%9B%8C%EB%93%9C%7D) 페이지의 본문 텍스트를 가져오고,
앞 500자만 반환해줘.
에러 처리도 포함해줘.
```

### 6. `main.py` — System Prompt 기반 Tool Calling 루프 연결 (핵심)

```bash
main.py를 수정해서 LLM이 도구를 호출할 수 있는 에이전트로 만들어줘.
System Prompt 방식으로 구현해줘.

사용 가능한 도구 목록과 호출 형식을 System Prompt에 정의하고,
LLM이 도구를 쓰고 싶을 때는 아래 형식으로만 응답하도록 지시해줘.

[TOOL_CALL] {"tool": "도구이름", "args": {"인자명": "값"}}

사용 가능한 도구:
- search_namuwiki(keyword): 나무위키에서 키워드 검색
- read_file(path): 로컬 파일 읽기
- write_file(path, content): 로컬 파일 쓰기
- edit_file(path, old_text, new_text): 로컬 파일 수정

LLM 응답에 [TOOL_CALL]이 있으면:
1. JSON을 파싱해서 tools.py의 해당 함수를 실행한다.
2. 결과를 [TOOL_RESULT] 형식으로 히스토리에 추가한다.
3. LLM을 다시 호출한다.
4. [TOOL_CALL]이 없는 응답이 올 때까지 반복한다.

각 도구 호출과 결과를 터미널에 출력해줘.
```
**예상 동작 흐름**
```
사용자: "젤다에 대해 검색하고 결과를 zelda.md 파일에 저장해줘"
    ↓
LLM: [TOOL_CALL] {"tool": "search_namuwiki", "args": {"keyword": "젤다"}}
    ↓
[Tool Call] search_namuwiki(keyword=젤다)
[Tool Result] 젤다의 전설은 닌텐도가 개발한...
    ↓
히스토리에 추가 → LLM 재호출
    ↓
LLM: [TOOL_CALL] {"tool": "write_file", "args": {"path": "zelda.md", "content": "..."}}
    ↓
[Tool Call] write_file(path=zelda.md)
[Tool Result] 파일이 저장되었습니다.
    ↓
히스토리에 추가 → LLM 재호출
    ↓
LLM: "zelda.md에 저장 완료했습니다."  ← [TOOL_CALL] 없음, 루프 종료
```

### 7. 동작 검증
```bash
uv run main.py
```
```
# 검증용 입력
사용자: 젤다에 대해 검색하고 결과를 zelda.md 파일에 저장해줘.
```

### 8. `.gitignore` + GitHub 업로드

