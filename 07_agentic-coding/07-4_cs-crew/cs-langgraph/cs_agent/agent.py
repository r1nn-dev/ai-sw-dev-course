from typing import TypedDict, Literal
from langgraph.graph import StateGraph, END
from langchain_ollama import ChatOllama
from langchain_core.messages import SystemMessage, HumanMessage


# ── 상태 정의 ──────────────────────────────────────────────────────────────────
class CSState(TypedDict):
    user_message: str       # 고객이 입력한 원본 메시지
    reception_result: str   # 접수 담당자의 분류 결과
    response: str           # 최종 고객 응답


# ── LLM 설정 ───────────────────────────────────────────────────────────────────
llm = ChatOllama(model="qwen2.5-coder:7b")


# ── 노드 1: CS 접수 담당자 ─────────────────────────────────────────────────────
def receptionist_node(state: CSState) -> CSState:
    """고객 문의를 받아 유형을 판단한다. 기술 문의면 [기술지원필요] 접두어를 붙인다."""
    messages = [
        SystemMessage(content="""당신은 CS 상담 접수 담당자입니다.

고객 문의를 받으면 유형을 판단하여 처리합니다.

[일반 문의 처리] 아래 유형은 직접 답변합니다:
- 인사, 단순 문의
- 배송·환불·서비스 불만
- 직원 응대 문제

[기술 문의 이관] 아래 유형은 반드시 첫 줄을 "[기술지원필요]"로 시작하고, 다음 줄에 문제를 한 줄로 요약합니다:
- 소프트웨어 오류, 앱 충돌
- 하드웨어 고장, 기기 이상
- 네트워크·인터넷 연결 문제
- 계정·비밀번호·보안 문제

응대 원칙:
- 항상 고객이 사용하는 언어로 답변합니다.
- 친절하고 공감하는 말투를 유지합니다.
- 문의가 모호하면 추가 정보를 한 가지만 질문합니다."""),
        HumanMessage(content=state["user_message"]),
    ]
    result = llm.invoke(messages)
    return {"reception_result": result.content}


# ── 노드 2: 기술 지원 전문가 ───────────────────────────────────────────────────
def tech_support_node(state: CSState) -> CSState:
    """기술 문의를 전담하여 단계별 해결책을 제공한다."""
    messages = [
        SystemMessage(content="""당신은 기술 지원 전문가입니다.

전문 분야:
- 소프트웨어 오류 및 앱 문제
- 하드웨어 고장 및 기기 문제
- 네트워크·Wi-Fi·인터넷 연결
- 계정·보안·비밀번호 문제
- 클라우드·서버·API 문의

답변 방식:
1. 문제 원인을 쉽게 설명한다.
2. 해결 방법을 단계별로 안내한다.
3. 추가 질문을 환영하는 말로 마무리한다.

항상 고객이 사용하는 언어로 답변하고, 비전문가도 이해할 수 있게 설명한다."""),
        HumanMessage(content=state["user_message"]),
    ]
    result = llm.invoke(messages)
    return {"response": result.content}


# ── 라우팅 함수 ────────────────────────────────────────────────────────────────
def route(state: CSState) -> Literal["tech_support", "__end__"]:
    """접수 결과에 [기술지원필요]가 있으면 tech_support로, 없으면 종료."""
    if "[기술지원필요]" in state["reception_result"]:
        return "tech_support"
    return "__end__"


# ── 일반 문의 응답 정리 노드 ───────────────────────────────────────────────────
def finalize_general(state: CSState) -> CSState:
    """일반 문의는 접수 담당자의 답변을 최종 응답으로 저장한다."""
    return {"response": state["reception_result"]}


# ── 그래프 구성 ────────────────────────────────────────────────────────────────
builder = StateGraph(CSState)

builder.add_node("receptionist", receptionist_node)
builder.add_node("tech_support", tech_support_node)
builder.add_node("finalize_general", finalize_general)

builder.set_entry_point("receptionist")  # 루트 에이전트 — 그래프 실행 시 가장 먼저 호출되는 진입점

builder.add_conditional_edges(
    "receptionist",
    route,
    {
        "tech_support": "tech_support",
        "__end__": "finalize_general",
    },
)

builder.add_edge("tech_support", END)
builder.add_edge("finalize_general", END)

graph = builder.compile()
