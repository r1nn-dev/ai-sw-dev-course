# AI Agent Coding

## 1. Agent
- Agent: LLM(Large Language Model, 대규모 언어 모델)이 단순히 텍스트를 생성하는 것에 그치지 않고, 실제 도구(Tool)를 호출하고 환경과 상호작용할 수 있도록 확장된 시스템

**Agent의 동작 구조**
- 동작 흐름
    1. Task가 LLM에 입력되면, LLM은 Reasoning(추론) 과정을 반복하며 호출할 Tool을 결정한다.
    2. Tools
        - Action을 통해 Environment(파일 시스템, 외부 API 등)에 영향을 미친다.
        - 그 결과 Result가 다시 LLM의 컨텍스트로 피드백된다.
- 사용자가 한 번 질문하더라도, 내부적으로 LLM과 Tool 사이에 여러 번의 루프가 발생한다.

**프롬프트 구성 요소 (Terminology)**
- System Prompt: LLM의 전체적인 행동 방식과 규칙을 정의하는 프롬프트
- User Prompt: 사용자가 직접 입력하는 요청 메시지
- Assistant Prompt: LLM이 생성한 답변

**코딩 에이전트 만들기**
1. 사용 모델 및 도구
2. 패키지 및 환경 설정 (uv 패키지 매니저)
    - uv: Rust 기반의 Python 패키지 매니저로, pip + venv를 대체하는 빠른 도구.

**코딩 에이전트 구현 요구사항 (Steps)**
1. 대화 기억 (Conversation Memory)
    - 터미널에 출력된 결과를 읽고 그 정보를 대화에도 누적한다.
    - 이전 대화를 기억해야 한다. — 대화 히스토리
2. 도구 인식 및 호출 (Tool Calling)
    - LLM에게 사용 가능한 도구 목록을 System Prompt로 주입한다.
    - LLM은 요청을 분석해 어떤 도구를 호출할지 스스로 판단하여 도구를 호출한다.
    - 실제 도구 실행은 외부(Python 코드)에서 처리하고, 그 결과를 다시 LLM의 컨텍스트에 추가한다.
3. 파일 생성 및 수정 (File I/O)
    - Python 함수 — 기능을 각각 독립적인 함수로 분리한다.
    - 각 함수는 `tools.py` 파일에 모아 관리한다.

**구현 순서 예시 — 프롬프트 흐름**
```bash
1) Ollama의 llm 모델이랑 터미널에서 채팅할 수 있도록 해줘.
2) 대화를 기억해야 한다.
3) 시스템 프롬프트를 이용해서 파일을 읽고 쓰고 수정하는 함수를 정의하고 
	 이를 통해서 현재의 llm이 에이전트가 될 수 있도록 만들어줘. 
	 시스템 프롬프트를 통해서 이를 구현해줘.
	 파일 생성이 안되고 있는데 이유를 알 수 있도록 로그를 띄워줘.
```

## 2. MCP (Model Context Protocol)
- MCP(Model Context Protocol, 모델 컨텍스트 프로토콜): 에이전트가 호출할 수 있는 정보(도구와 데이터)를 제공하는 표준 프로토콜

### Terminology
- **Host**: MCP 클라이언트를 포함하는 애플리케이션
    - Cursor, Claude Desktop, 직접 개발한 앱 등
- **MCP Client**: Host 내부에서 MCP Server와 통신을 담당하는 모듈
    - Host 하나에 여러 MCP Client가 존재할 수 있다.
- **MCP Server**: 실제 Tool을 MCP 규격(JSON-RPC)으로 감싸서 외부에 노출하는 서버
- **Tool**: LLM이 실제로 사용하는 기능 단위
    - Private API, DB, Public Web API 등 다양한 백엔드와 연결될 수 있다.

### 동작 흐름 (Flow)
1. MCP Client → MCP Server: 도구 목록 요청
2. MCP Server → MCP Client: 각 Tool 정보를 JSON으로 반환
3. Host → LLM Context: Tool 목록 JSON을 모델의 컨텍스트에 주입
4. User → Host: 질문 입력
5. LLM: 컨텍스트를 기반으로 필요한 Tool 호출을 판단하고 요청 생성
6. MCP Server: Tool을 실행하고 결과를 반환
7. LLM: 결과를 컨텍스트에 추가하여 최종 응답 생성