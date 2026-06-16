# LangGraph 에이전트 패턴 

LangGraph와 Ollama를 활용한 에이전트 패턴 실습 프로젝트.

## 프로젝트 구성

| 파일 | 설명 |
|------|------|
| `03_langgraph_components.ipynb` | ReAct 패턴 구현 (단일 턴 + 자동 루프) |
| `04_agentic_search.ipynb` | Tavily를 이용한 에이전틱 검색 |
| `05_persistence_and_streaming.ipynb` | 메모리 지속성 및 스트리밍 |
| `06_human_in_the_loop.ipynb` | 인터럽트 기반 Human-in-the-Loop, 상태 수정, 시간 여행 |
| `07_essay_agent.ipynb` | 계획 → 조사 → 작성 → 반성 → 수정 흐름의 에세이 작성 에이전트 |

## 사전 요구사항

- Python 3.12
- [uv](https://docs.astral.sh/uv/) 패키지 매니저
- [Ollama](https://ollama.com/) (로컬 LLM 실행)
- Tavily API 키

## 설치

### 1. 의존성 설치

```bash
uv sync
```

### 2. Ollama 모델 다운로드

```bash
ollama pull llama3.1:8b
```

### 3. 환경변수 설정

`.env` 파일에 Tavily API 키를 설정합니다.

```bash
# .env
TAVILY_API_KEY=your_tavily_api_key_here
```

> Tavily API 키는 [https://tavily.com](https://tavily.com) 에서 무료로 발급받을 수 있습니다.

## 실행 방법

```bash
uv run jupyter notebook
```

## 노트북 동작 흐름

### 05 - Persistence & Streaming

```
사용자 질문
    │
    ▼
[LLM]  tool 호출 여부 판단
    │
    ▼ (tool 호출 시)
[Action]  Tavily 웹 검색
    │
    ▼
[LLM]  결과 기반 답변 생성
```

- `MemorySaver`로 thread별 대화 이력 유지
- `stream` / `astream_events`로 토큰 단위 스트리밍

### 06 - Human in the Loop

- `interrupt_before=["action"]`으로 도구 실행 전 인터럽트
- `get_state` / `update_state`로 상태 조회 및 수정
- `get_state_history`로 과거 상태 조회 및 시간 여행

### 07 - Essay Agent

```
입력 주제
    │
    ▼
[Planner]  에세이 개요 작성
    │
    ▼
[Research Plan]  Tavily로 관련 자료 수집
    │
    ▼
[Generate]  초안 작성
    │
    ▼
[Reflect]  피드백 생성
    │
    ▼
[Research Critique]  추가 자료 수집
    │
    ▼
[Generate]  수정본 작성  ←─ max_revisions 초과 시 종료
```