"""
실습 — 고객 서비스 에이전트 통신 패턴 구현

[Step 1] 패턴 선택: 메모리 핸드오프 (Memory Handoff)
- 기술 지원 에이전트는 고객과의 대화 전체 맥락이 필요하다.
- 고객 서비스 에이전트가 어떤 정보가 핵심인지 사전에 판단하기 어렵다.
- 따라서 전체 대화 기록을 task에 담아 서브 에이전트에게 넘긴다.
- 서브 에이전트는 새 메모리(빈 대화 기록)에서 시작하므로 메모리 격리가 보장된다.

[Step 2] call_agent 도구 구현
- Anthropic Tool Use API를 사용하여 call_agent를 도구로 정의한다.
- 고객 서비스 에이전트가 기술 문의라고 판단하면 스스로 이 도구를 호출한다.

[Step 3] 두 에이전트 연결 및 테스트
- 고객 서비스 에이전트: 문의 분류 + call_agent 도구 호출 판단
- 기술 지원 에이전트: 전달받은 대화 맥락을 바탕으로 기술 문제 해결
"""

import json
import os
from anthropic import Anthropic
from dotenv import load_dotenv

load_dotenv()

client = Anthropic()

###### 시스템 프롬프트 ######

CUSTOMER_SERVICE_PROMPT = """
당신은 고객 서비스 에이전트입니다.

판단 기준:
- 일반 문의 (영업시간, 요금, 위치, 정책 등): 직접 답변한다.
- 기술적 문의 (오류 코드, 앱 오작동, 로그인 실패, 결제 오류 등):
  call_agent 도구를 호출하여 기술 지원 에이전트에게 전달한다.

call_agent 도구 호출 시:
- agent_name: "tech_support"
- task: 지금까지의 전체 대화 내용을 빠짐없이 포함한다.
  (고객이 언급한 오류 코드, 증상, 시도한 방법 등이 모두 들어가야 한다)
"""

TECH_SUPPORT_PROMPT = """
당신은 기술 지원 전문가입니다.
고객 서비스 에이전트로부터 전달받은 대화 맥락을 바탕으로 기술적 문제를 해결한다.

답변 원칙:
- 전달받은 맥락에서 오류 코드, 증상, 환경 정보를 먼저 파악한다.
- 파악한 정보를 답변에 직접 언급하며 구체적인 해결 절차를 제시한다.
- 추가 확인이 필요한 경우 구체적인 질문을 제시한다.
"""

###### [Step 2] call_agent 도구 정의 ######
# 에이전트가 스스로 호출할 수 있도록 Tool로 등록한다.

TOOLS = [
    {
        "name": "call_agent",
        "description": (
            "다른 에이전트를 호출하여 특정 작업을 수행하게 한다. "
            "기술적 문의가 들어오면 tech_support 에이전트를 호출한다."
        ),
        "input_schema": {
            "type": "object",
            "properties": {
                "agent_name": {
                    "type": "string",
                    "description": "호출할 에이전트 이름. 현재 사용 가능: 'tech_support'",
                },
                "task": {
                    "type": "string",
                    "description": (
                        "에이전트에게 전달할 작업 내용. "
                        "메모리 핸드오프 패턴에 따라 지금까지의 전체 대화 맥락을 포함해야 한다."
                    ),
                },
            },
            "required": ["agent_name", "task"],
        },
    }
]

# 에이전트 레지스트리 — agent_name으로 실행 함수를 조회한다.
# 예시 코드의 agent_registry.get_agent(agent_name) 과 동일한 역할이다.
AGENT_REGISTRY = {
    "tech_support": TECH_SUPPORT_PROMPT,
}


###### [Step 2] call_agent 함수 구현 ######

def call_agent(agent_name: str, task: str) -> dict:
    """
    서브 에이전트를 호출한다. 예시 코드의 call_agent와 동일한 역할.

    핵심 설계 원칙:
    - 메모리 격리: 서브 에이전트는 새 메모리(빈 messages)에서 시작한다.
      호출자의 이전 대화 기록을 자동으로 공유받지 않는다.
    - 컨텍스트 통제: 필요한 맥락만 task에 담아 전달한다.
    - 결과 추출: 마지막 content 블록이 에이전트의 최종 답변이다.

    Args:
        agent_name: 레지스트리에 등록된 에이전트 이름
        task: 전달할 작업 내용 (메모리 핸드오프 패턴 — 전체 대화 맥락 포함)

    Returns:
        {"success": True, "agent": agent_name, "result": "..."}
        {"success": False, "error": "..."}
    """
    # 레지스트리에서 에이전트 프롬프트 조회
    # 예시 코드: agent_run = agent_registry.get_agent(agent_name)
    agent_prompt = AGENT_REGISTRY.get(agent_name)
    if not agent_prompt:
        return {"success": False, "error": f"에이전트 '{agent_name}'을 레지스트리에서 찾을 수 없습니다."}

    try:
        # 서브 에이전트 실행 — 새 메모리(빈 messages)에서 시작 (메모리 격리)
        # 예시 코드: invoked_memory = Memory() / agent_run(user_input=task, memory=invoked_memory)
        result = client.messages.create(
            model="claude-opus-4-5",
            max_tokens=1024,
            system=agent_prompt,
            messages=[
                {"role": "user", "content": task}  # task = 전체 대화 맥락
            ],
        )

        # 마지막 메모리 항목을 결과로 반환
        # 예시 코드: last_memory = result_memory.items[-1]
        return {
            "success": True,
            "agent": agent_name,
            "result": result.content[-1].text,
        }

    except Exception as e:
        return {"success": False, "error": str(e)}


###### [Step 3] 고객 서비스 에이전트 실행 ######

def run_customer_service(conversation_history: list) -> str:
    """
    고객 서비스 에이전트를 실행한다.

    에이전트가 스스로 판단한다:
    - 일반 문의 → 직접 텍스트 응답 반환
    - 기술 문의 → call_agent 도구를 호출 → 기술 지원 에이전트에게 핸드오프
    """
    response = client.messages.create(
        model="claude-opus-4-5",
        max_tokens=1024,
        system=CUSTOMER_SERVICE_PROMPT,
        tools=TOOLS,                        # call_agent 도구를 에이전트에 제공
        messages=conversation_history,
    )

    # 에이전트가 도구 호출을 선택한 경우
    if response.stop_reason == "tool_use":
        for block in response.content:
            if block.type == "tool_use" and block.name == "call_agent":
                agent_name = block.input["agent_name"]
                task = block.input["task"]  # 에이전트가 스스로 맥락을 담아 구성한 task

                print(f"\n[에이전트 판단] 기술 문의 감지 → '{agent_name}' 호출")
                print(f"[전달되는 task 미리보기]\n{task[:300]}...\n")

                # call_agent 호출 — 메모리 핸드오프 실행
                result = call_agent(agent_name=agent_name, task=task)

                if result["success"]:
                    return f"[기술 지원팀] {result['result']}"
                else:
                    return f"[오류] {result['error']}"

    # 에이전트가 직접 응답한 경우 (일반 문의)
    return f"[고객 서비스] {response.content[-1].text}"


###### 대화 루프 ######

if __name__ == "__main__":
    print("=== 고객 서비스 채팅 시작 (종료: 'exit') ===\n")
    conversation_history = []  # 대화 기록 누적 — 핸드오프 시 전체가 전달된다

    while True:
        user_input = input("사용자: ").strip()
        if user_input.lower() == "exit":
            break
        if not user_input:
            continue

        conversation_history.append({"role": "user", "content": user_input})

        response = run_customer_service(conversation_history)
        print(f"\n{response}\n")

        conversation_history.append({"role": "assistant", "content": response})